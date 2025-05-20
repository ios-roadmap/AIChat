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
    let content: String?
    let seenByIds: [String]?
    let dateCreated: Date?

    init(
        id: String,
        chatId: String,
        authorId: String? = nil,
        content: String? = nil,
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
                content: "Hello, how are you?",
                seenByIds: ["user_456"],
                dateCreated: now
            ),
            ChatMessageModel(
                id: "msg_002",
                chatId: "chat_001",
                authorId: "user_456",
                content: "I'm good, thanks! And you?",
                seenByIds: ["user_123", "user_789"],
                dateCreated: now.addingTimeInterval(minutes: -5)
            ),
            ChatMessageModel(
                id: "msg_003",
                chatId: "chat_002",
                authorId: "user_789",
                content: "Meeting starts in 10 minutes.",
                seenByIds: [],
                dateCreated: now.addingTimeInterval(hours: -1)
            ),
            ChatMessageModel(
                id: "msg_004",
                chatId: "chat_003",
                authorId: "user_321",
                content: "Don't forget to submit your report.",
                seenByIds: nil,
                dateCreated: now.addingTimeInterval(hours: -2, minutes: -15)
            )
        ]
    }
}
