//
//  ChatModel.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 19.05.2025.
//

import Foundation

struct ChatModel: Identifiable {
    let id: String
    let userId: String
    let avatarId: String
    let dateCreated: Date
    let dateModified: Date
    
    static var mock: ChatModel {
        mocks[0]
    }
    
    static var mocks: [ChatModel] {
        let now = Date()
        return [
            ChatModel(
                id: "chat_001",
                userId: "user_123",
                avatarId: "avatar_blue",
                dateCreated: now,
                dateModified: now
            ),
            ChatModel(
                id: "chat_002",
                userId: "user_456",
                avatarId: "avatar_green",
                dateCreated: now.addingTimeInterval(hours: -1),
                dateModified: now.addingTimeInterval(minutes: -30)
            ),
            ChatModel(
                id: "chat_003",
                userId: "user_789",
                avatarId: "avatar_red",
                dateCreated: now.addingTimeInterval(hours: -2),
                dateModified: now.addingTimeInterval(hours: -1)
            ),
            ChatModel(
                id: "chat_004",
                userId: "user_321",
                avatarId: "avatar_purple",
                dateCreated: now.addingTimeInterval(days: -1),
                dateModified: now.addingTimeInterval(hours: -10)
            )
        ]
    }
}
