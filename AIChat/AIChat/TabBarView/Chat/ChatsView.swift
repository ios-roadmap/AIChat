//
//  ChatsView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 4.05.2025.
//

import SwiftUI

struct ChatsView: View {
    
    @Environment(AvatarManager.self) private var avatarManager
    
    @State private var chats: [ChatModel] = []
    @State private var recentAvatars: [AvatarModel] = []
    
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                if !recentAvatars.isEmpty {
                    recentsSection
                }
                
                chatsSection
            }
            .navigationTitle("Chats")
            .navigationDestinationForCoreModule(path: $path)
            .onAppear {
                loadRecentAvatars()
            }
        }
    }
    
    func loadRecentAvatars() {
        do {
            recentAvatars = try avatarManager.getRecentAvatars()
        } catch {
            print("Failed to load recent avatars: \(error)")
        }
    }
    
    private var chatsSection: some View {
        Section {
            if chats.isEmpty {
                Text("Yout chats will appear here!")
                    .foregroundStyle(.secondary)
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(40)
                    .removeListRowFormatting()
            } else {
                ForEach(chats) { chat in
                    ChatRowCellViewBuilder(
                        currentUserId: nil,
                        chat: chat,
                        getAvatar: {
                            try? await Task.sleep(for: .seconds(2))
                            return AvatarModel.mocks.randomElement()!
                        },
                        getLastChatMessage: {
                            try? await Task.sleep(for: .seconds(2))
                            return ChatMessageModel.mocks.randomElement()!
                        }
                    )
                    .anyButton(option: .highlight) {
                        onChatPressed(chat: chat)
                    }
                    .removeListRowFormatting()
                }
            }
        } header: {
            Text("Chats")
        }
    }
    
    private var recentsSection: some View {
        Section {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(recentAvatars, id: \.self) { avatar in
                        if let imageName = avatar.profileImageName {
                            VStack(spacing: 8) {
                                ImageLoaderView(urlString: imageName)
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipShape(.circle)
                                
                                Text(avatar.name ?? "")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .anyButton {
                                onAvatarPressed(avatar: avatar)
                            }
                        }
                    }
                }
                .padding(.top, 12)
            }
            .frame(height: 120)
            .scrollIndicators(.hidden)
            .removeListRowFormatting()
        } header: {
            Text("Recents")
        }
    }
    
    private func onChatPressed(chat: ChatModel) {
        path.append(.chat(avatarId: chat.avatarId))
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
}

#Preview {
    NavigationStack {
        ChatsView()
            .environment(
                AvatarManager(
                    service: MockAvatarService(),
                    local: MockLocalAvatarPersistance()
                )
            )
    }
}
