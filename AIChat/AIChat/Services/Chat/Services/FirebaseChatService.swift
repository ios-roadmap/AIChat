//
//  FirebaseChatService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 21.06.2025.
//

import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseChatService: ChatService {
    
    private var collection: CollectionReference {
        Firestore.firestore().collection("chats")
    }
    
    private func messagesCollection(chatId: String) -> CollectionReference {
        collection.document(chatId).collection("messages")
    }
    
    func createNewChat(chat: ChatModel) async throws {
        try collection.document(chat.id).setData(from: chat, merge: true)
    }
    
    func addChatMessage(chatId: String, message: ChatMessageModel) async throws {
        try messagesCollection(chatId: chatId).document(chatId).setData(from: message, merge: true)
        
        try await collection.document(chatId).updateData([
            ChatModel.CodingKeys.dateModified.rawValue: Date.now
        ])
    }
}
