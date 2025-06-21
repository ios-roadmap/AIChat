//
//  ChatRowCellViewBuilder.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 19.05.2025.
//

import SwiftUI

struct ChatRowCellViewBuilder: View {
    
    var currentUserId: String? = ""
    var chat: ChatModel
    var getAvatar: () async -> AvatarModel?
    var getLastChatMessage: () async -> ChatMessageModel?
    
    @State private var avatar: AvatarModel?
    @State private var lastChatMessage: ChatMessageModel?
    
    @State private var didLoadAvatar: Bool = false
    @State private var didLoadChatMessage: Bool = false
    
    private var isLoading: Bool {
        if didLoadAvatar && didLoadChatMessage {
            return false
        }
        
        return true
    }
    
    private var hasNewChat: Bool {
        guard let lastChatMessage,
              let currentUserId else { return false }
        
        return lastChatMessage.hasBeenSeenByCurrentUser(userId: currentUserId)
    }
    
    private var headline: String? {
        if isLoading {
            return "xxxx xxxx"
        }
        
        return avatar?.name
    }
    
    private var subheadline: String? {
        if isLoading {
            return "xxxx xxxx xxxx xxxxx"
        }
        
        if avatar == nil && lastChatMessage == nil {
            return "Error"
        }
        
        return lastChatMessage?.content?.message
    }
    
    var body: some View {
        ChatRowCellView(
            imageName: avatar?.profileImageName,
            headline: headline,
            subheadline: subheadline,
            hasNewChat: isLoading ? false : hasNewChat
        )
        .redacted(reason: isLoading ? .placeholder : [])
        .task {
            avatar = await getAvatar()
            didLoadAvatar = true
        }
        .task {
            lastChatMessage = await getLastChatMessage()
            didLoadChatMessage = true
        }
    }
}

#Preview {
    VStack {
        ChatRowCellViewBuilder(
            chat: .mock,
            getAvatar: {
                try? await Task.sleep(for: .seconds(2))
                return .mock
            },
            getLastChatMessage: {
                try? await Task.sleep(for: .seconds(2))
                return .mock
            })
        
        ChatRowCellViewBuilder(
            chat: .mock,
            getAvatar: {
                .mock
            },
            getLastChatMessage: {
                .mock
            })
        
        ChatRowCellViewBuilder(
            chat: .mock,
            getAvatar: {
                nil
            },
            getLastChatMessage: {
                nil
            })
    }
}
