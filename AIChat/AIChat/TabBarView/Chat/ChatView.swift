//
//  ChatView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 20.05.2025.
//

import SwiftUI

struct ChatView: View {
    
    @Environment(UserManager.self) private var userManager
    @Environment(AvatarManager.self) private var avatarManager
    @Environment(AuthManager.self) private var authManager
    @Environment(AIManager.self) private var aiManager
    @Environment(ChatManager.self) private var chatManager
    
    @State private var chatMessages: [ChatMessageModel] = []
    @State private var avatar: AvatarModel?
    @State private var currentUser: UserModel? = .mock
    @State private var textFieldText: String = ""
    @State private var chat: ChatModel?
    
    @State private var showAlert: AnyAppAlert?
    @State private var showChatSettings: AnyAppAlert?
    
    @State private var scrollPosition: String?
    @State private var showProfileModal: Bool = false
    @State private var isGeneratingResponse: Bool = false
    @State private var messageListener: ListenerRegistration?
    
    var avatarId: String = AvatarModel.mock.avatarId
    
    var body: some View {
        VStack(spacing: 0) {
            scrollViewSection
            textFieldSection
        }
        .navigationTitle(avatar?.name ?? "")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    if isGeneratingResponse {
                        ProgressView()
                    }
                    
                    Image(systemName: "ellipsis")
                        .padding(8)
                        .anyButton {
                            onChatSettingsPressed()
                        }
                }
            }
        }
        .showCustomAlert(
            type: .confirmationDialog,
            alert: $showChatSettings
        )
        .showCustomAlert(
            alert: $showAlert
        )
        .showModal(showModal: $showProfileModal) {
            if let avatar {
                profileModal(avatar: avatar)
            }
        }
        .task {
            await loadAvatar()
        }
        .task {
            await loadChat()
            await listenForChatMessages()
        }
        .onAppear {
            loadCurrentUser()
        }
        .onDisappear {
            messageListener?.remove()
        }
    }
    
    private func loadChat() async {
        do {
            let uid = try authManager.getAuthId()
            chat = try await chatManager.getChat(userId: uid, avatarId: avatarId)
            print(chat)
        } catch {
            print("error loading chat")
        }
    }
    
    private func getChatId() throws -> String {
        guard let chat else {
            throw ChatViewError.noChat
        }
        
        return chat.id
    }
    
    private func listenForChatMessages() async {
        do {
            let chatId = try getChatId()
            
            for try await value in chatManager.streamChatMessages(chatId: chatId, onListenerConfigured: { listener in
                messageListener?.remove()
                messageListener = listener
            }) {
                chatMessages = value.sorted(by: { $0.dateCreatedCalculated < $1.dateCreatedCalculated })
                scrollPosition = chatMessages.last?.id
            }
            
        } catch {
            print("Failed to attach chat message listener.")
        }
    }
    
    private func loadCurrentUser() {
        currentUser = userManager.currentUser
    }
    
    private func loadAvatar() async {
        do {
            let avatar = try await avatarManager.getAvatar(id: avatarId)
            self.avatar = avatar
            try? await avatarManager.addRecentAvatar(avatar: avatar)
        } catch {
            print("Error loading avatar: \(error)")
        }
    }
    
    private func profileModal(avatar: AvatarModel) -> some View {
        ProfileModalView(
            imageName: avatar.profileImageName,
            title: avatar.name,
            subtitle: avatar.characterOption?.rawValue.capitalized,
            headline: avatar.characterDescription,
            onXMarkPressed: {
                onXMarkPressed()
            }
        )
        .padding(40)
        .transition(.move(edge: .bottom))
    }
    
    private var scrollViewSection: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(chatMessages) { message in
                    
                    let isCurrentUser = message.authorId == authManager.auth?.uid
                    ChatBubbleViewBuilder(
                        message: message,
                        isCurrentUser: isCurrentUser,
                        currentUserProfileColor: currentUser?.profileColorCalculated ?? .accent,
                        imageName: isCurrentUser ? nil : avatar?.profileImageName,
                        onImagePressed: {
                            onAvatarImagePressed()
                        }
                    )
                    .id(message.id)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .rotationEffect(.degrees(180))
        }
        .rotationEffect(.degrees(180))
        .animation(
            .default,
            value: chatMessages.count
        )
        .animation(
            .default,
            value: scrollPosition
        )
    }
    
    private var textFieldSection: some View {
        TextField(
            "Say something...",
            text: $textFieldText
        )
        .keyboardType(.alphabet)
        .autocorrectionDisabled()
        .padding(12)
        .padding(.trailing, 60)
        .overlay(
            alignment: .trailing,
            content: {
                Image(systemName: "arrow.up.circle.fill")
                .font(.system(size: 32))
                .padding(.trailing, 4)
                .foregroundStyle(.accent)
                .anyButton {
                    onSendMessagePressed()
                }
            }
        )
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 100)
                .fill(
                    Color(uiColor: .systemBackground)
                )
                
                RoundedRectangle(cornerRadius: 100)
                .stroke(
                    Color.gray.opacity(0.3),
                    lineWidth: 1
                )
            }
        )
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color(uiColor: .secondarySystemBackground))
    }
    
    private func onSendMessagePressed() {
        let content = textFieldText
        
        Task {
            do {
                //get user id
                let uid = try authManager.getAuthId()
                
                //validate textfield text
                try TextValidationHelper.checkIfTextIsValid(text: content)
                
                // if chat is nil, then create a new chat
                if chat == nil {
                    chat = try await createNewChat(uid: uid)
                }
                
                //if there is no chat, throw error should never happen
                guard let chat else {
                    throw ChatViewError.noChat
                }
                
                //create user chat
                let newChatMessage = AIChatModel(
                    role: .user,
                    message: content
                )
                
                let message = ChatMessageModel.newUserMessage(
                    chatId: chat.id,
                    userId: uid,
                    message: newChatMessage
                )
                 
                //upload user chat
                try await chatManager.addChatMessage(chatId: chat.id, message: message)
                textFieldText = ""
                
                //generate ai response
                isGeneratingResponse = true
                var aiChats = chatMessages.compactMap(\.content)
                if let avatarDescription = chatMessages.compactMap({ $0.content }) {
                    Dakika 15 den tekrar başla.
                }
                
                let result = try await aiManager.generateText(chats: aiChats)
                
                // create ai chat
                let newAIMessage = ChatMessageModel.newAIMessage(
                    chatId: chat.id,
                    avatarId: avatarId,
                    message: result
                )

                // upload ai chat
                try await chatManager.addChatMessage(chatId: chat.id, message: newAIMessage)
                
            } catch let error {
                showAlert = .init(
                    error: error
                )
            }
            
            isGeneratingResponse = false
        }
    }
    
    enum ChatViewError: Error {
        case noChat
    }
    
    private func createNewChat(uid: String) async throws -> ChatModel {
        let newChat = ChatModel.new(userId: uid, avatarId: avatarId)
        try await chatManager.createNewChat(chat: newChat)
        
        defer {
            Task {
                await listenForChatMessages()
            }
        }
        
        return newChat
    }
    
    private func onChatSettingsPressed() {
        showChatSettings = .init(
            title: "",
            subtitle: "What would you like to do?",
            buttons: {
                AnyView(
                    Group {
                        Button("Report User / Chat", role: .destructive) {
                            
                        }
                        Button("Delete Chat", role: .destructive) {
                            
                        }
                    }
                )
            }
        )
    }
    
    private func onAvatarImagePressed() {
        showProfileModal = true
    }
    
    private func onXMarkPressed() {
        showProfileModal = false
    }
}

#Preview("Working chat") {
    NavigationStack {
        ChatView()
            .previewEnvironment()
    }
}

#Preview("Slow AI generation") {
    NavigationStack {
        ChatView()
            .environment(AIManager(service: MockAIService(delay: 10)))
            .previewEnvironment()
    }
}

#Preview("Failed AI generation") {
    NavigationStack {
        ChatView()
            .environment(AIManager(service: MockAIService(delay: 5, showError: true)))
            .previewEnvironment()
    }
}
