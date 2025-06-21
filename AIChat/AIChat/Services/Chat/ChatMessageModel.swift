//
//  ChatMessageModel.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 19.05.2025.
//

import Foundation

struct ChatMessageModel: Identifiable {
    let id: String
    let chatId: String
    let authorId: String?
    let content: AIChatModel?
    let seenByIds: [String]?
    let dateCreated: Date?

    init(
        id: String,
        chatId: String,
        authorId: String? = nil,
        content: AIChatModel? = nil,
        seenByIds: [String]? = nil,
        dateCreated: Date? = nil
    ) {
        self.id = id
        self.chatId = chatId
        self.authorId = authorId
        self.content = content
        self.seenByIds = seenByIds
        self.dateCreated = dateCreated
    }
    
    func hasBeenSeenByCurrentUser(userId: String) -> Bool {
        guard let seenByIds else { return false }
        return seenByIds.contains(userId)
    }

    static var mock: ChatMessageModel {
        mocks[0]
    }

    static var mocks: [ChatMessageModel] {
        let now = Date()
        return [
            ChatMessageModel(
                id: "msg_001",
                chatId: "chat_001",
                authorId: "user_123",
                content: .init(
                    role: .user,
                    message: "Hello baby"
                ),
                seenByIds: ["user_456"],
                dateCreated: now
            ),
            ChatMessageModel(
                id: "msg_002",
                chatId: "chat_001",
                authorId: "user_456",
                content: .init(
                    role: .assistant,
                    message: "What are you talking about? My brother'ım."
                ),
                seenByIds: ["user_123", "user_789"],
                dateCreated: now.addingTimeInterval(minutes: -5)
            )
        ]
    }
}
