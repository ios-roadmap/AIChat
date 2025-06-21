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
    
    @State private var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
    @State private var avatar: AvatarModel?
    @State private var currentUser: UserModel? = .mock
    @State private var textFieldText: String = ""
    @State private var chat: ChatModel?
    
    @State private var showAlert: AnyAppAlert?
    @State private var showChatSettings: AnyAppAlert?
    
    @State private var scrollPosition: String?
    @State private var showProfileModal: Bool = false
    
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
                Image(systemName: "ellipsis")
                .padding(8)
                .anyButton {
                    onChatSettingsPressed()
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
        .onAppear {
            loadCurrentUser()
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
                let uid = try authManager.getAuthId()
                
                try TextValidationHelper.checkIfTextIsValid(text: content)
                
                if chat == nil {
                    let newChat = ChatModel.new(userId: uid, avatarId: avatarId)
                    try await chatManager.createNewChat(chat: newChat)
                    chat = newChat
                }
                
                let newChatMessage = AIChatModel(
                    role: .user,
                    message: content
                )
                
                let chatId = UUID().uuidString
                let message = ChatMessageModel.newUserMessage(
                    chatId: chatId,
                    userId: uid,
                    message: newChatMessage
                )
                
                chatMessages.append(message)
                scrollPosition = message.id
                textFieldText = ""
                
                let aiChats = chatMessages.compactMap(\.content)
                let result = try await aiManager.generateText(chats: aiChats)
                
                let newAIMessage = ChatMessageModel.newAIMessage(
                    chatId: chatId ,
                    avatarId: avatarId,
                    message: result
                )

                chatMessages.append(newAIMessage)
                
            } catch let error {
                showAlert = .init(
                    error: error
                )
            }
        }
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

#Preview {
    NavigationStack {
        ChatView()
            .previewEnvironment()
    }
}
