//
//  ChatModel.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 19.05.2025.
//

import Foundation
import IdentifiableByString

struct ChatModel: Identifiable, Codable, StringIdentifiable {
    let id: String
    let userId: String
    let avatarId: String
    let dateCreated: Date
    let dateModified: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case avatarId = "avatar_id"
        case dateCreated = "date_created"
        case dateModified = "date_modified"
    }
    
    static func chatId(userId: String, avatarId: String) -> String {
        "\(userId)_\(avatarId)"
    }
    
    static func new(userId: String, avatarId: String) -> Self {
        .init(
            id: chatId(userId: userId, avatarId: avatarId),
            userId: userId,
            avatarId: avatarId,
            dateCreated: .now,
            dateModified: .now
        )
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
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
