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
    
    func getChat(userId: String, avatarId: String) async throws -> ChatModel? {
//        let result: [ChatModel] = try await collection
//            .whereField(ChatModel.CodingKeys.userId.rawValue, isEqualTo: userId)
//            .whereField(ChatModel.CodingKeys.avatarId.rawValue, isEqualTo: avatarId)
//            .getAllDocuments()
//            
//        return result.first
        
        try await collection.getDocument(id: ChatModel.chatId(userId: userId, avatarId: avatarId))
    }
    
    func streamChatMessages(chatId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<[ChatMessageModel], Error> {
        messagesCollection(chatId: chatId).streamAllDocuments()
    }
}
