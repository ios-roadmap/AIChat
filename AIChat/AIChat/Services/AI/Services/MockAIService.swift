//
//  MockAIService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

import SwiftUI

struct MockAIService: AIService {
    
    let delay: Double
    let showError: Bool
    
    init(delay: Double = 0.0, showError: Bool = false) {
        self.delay = delay
        self.showError = showError
    }
    
    private func tryShowError() throws {
        if showError {
            throw URLError(.unknown)
        }
    }
    
    func generateImage(input: String) async throws -> UIImage {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return UIImage(systemName: "photo")!
    }
    
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return AIChatModel.mock
    }
}
