//
//  MockAIService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

import SwiftUI

struct MockAIService: AIService {
    
    func generateImage(input: String) async throws -> UIImage {
        try await Task.sleep(for: .seconds(2))
        return UIImage(systemName: "photo")!
    }
    
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel {
        try await Task.sleep(for: .seconds(2))
        return AIChatModel.mock
    }
}
