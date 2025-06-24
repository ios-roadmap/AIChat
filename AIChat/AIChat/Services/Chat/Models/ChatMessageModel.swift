//
//  ChatMessageModel.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 19.05.2025.
//

import Foundation

struct ChatMessageModel: Identifiable, Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case chatId = "chat_id"
        case authorId = "author_id"
        case content
        case seenByIds = "seen_by_ids"
        case dateCreated = "data_created"
    }
    
    func hasBeenSeenByCurrentUser(userId: String) -> Bool {
        guard let seenByIds else { return false }
        return seenByIds.contains(userId)
    }
    
    static func newUserMessage(
        chatId: String,
        userId: String,
        message: AIChatModel
    ) -> Self {
        .init(
            id: UUID().uuidString,
            chatId: chatId,
            authorId: userId,
            content: message,
            seenByIds: [userId],
            dateCreated: .now
        )
    }
    
    static func newAIMessage(
        chatId: String,
        avatarId: String,
        message: AIChatModel
    ) -> Self {
        .init(
            id: UUID().uuidString,
            chatId: chatId,
            authorId: avatarId,
            content: message,
            seenByIds: [],
            dateCreated: .now
        )
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
                authorId: UserAuthInfo.mock().uid,
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
                authorId: AvatarModel.mock.avatarId,
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
