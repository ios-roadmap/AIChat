//
//  ChatManager.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 21.06.2025.
//

import SwiftUI

@MainActor
@Observable
class ChatManager {
    
    private let service: ChatService
    
    init(service: ChatService) {
        self.service = service
    }
    
    func createNewChat(chat: ChatModel) async throws {
        try await service.createNewChat(chat: chat)
    }
}
