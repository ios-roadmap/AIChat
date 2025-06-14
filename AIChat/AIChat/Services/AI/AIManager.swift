//
//  AIManager.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

import SwiftUI

@MainActor
@Observable
class AIManager {
    
    private let service: AIService
    
    init(service: AIService) {
        self.service = service
    }
    
    func generateImage(input: String) async throws -> UIImage {
        try await service.generateImage(input: input)
    }
}
