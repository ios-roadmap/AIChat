//
//  AIService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

protocol AIService: Sendable {
    func generateImage(input: String) async throws -> UIImage
}
