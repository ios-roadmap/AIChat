//
//  MockChatService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 21.06.2025.
//

struct MockChatService: ChatService {
    func createNewChat(chat: ChatModel) async throws {
        
    }
    
    func addChatMessage(chatId: String, message: ChatMessageModel) async throws {
        
    }
    
    func getChat(userId: String, avatarId: String) async throws -> ChatModel? {
        return nil
    }
    
    func streamChatMessages(chatId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<[ChatMessageModel], Error> {
        AsyncThrowingStream { continuation in
            
        }
    }
}


