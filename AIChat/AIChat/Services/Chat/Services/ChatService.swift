//
//  ChatService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 21.06.2025.
//

protocol ChatService: Sendable {
    func createNewChat(chat: ChatModel) async throws
    func addChatMessage(chatId: String, message: ChatMessageModel) async throws
    func getChat(userId: String, avatarId: String) async throws -> ChatModel?
    func streamChatMessages(chatId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<[ChatMessageModel], Error>
}
