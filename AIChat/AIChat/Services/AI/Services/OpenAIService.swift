//
//  OpenAIService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

import SwiftUI
import OpenAI

typealias ChatContent = ChatQuery.ChatCompletionMessageParam.ChatCompletionUserMessageParam.Content.VisionContent
typealias ChatText = ChatQuery.ChatCompletionMessageParam.ChatCompletionUserMessageParam.Content.VisionContent.ChatCompletionContentPartTextParam

struct OpenAIService: AIService {
    
    var openAI: OpenAI {
        print(Keys.OpenAIKey)
        return OpenAI(
            apiToken: Keys.OpenAIKey
        )
    }
    
    func generateImage(input: String) async throws -> UIImage {
        let query = ImagesQuery(
            prompt: input,
            n: 1,
            responseFormat: .b64_json,
            size: ._256,
            user: nil
        )
        
        let result = try await openAI.images(query: query)
        
        guard let b64Json = result.data.first?.b64Json,
              let data = Data(base64Encoded: b64Json),
              let image = UIImage(data: data) else {
            throw OpenAIError.invalidResponse
        }
        
        return image
    }
    
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel {
        let messages = chats.compactMap { $0.toOpenAIModel() }
        
        let query = ChatQuery(
            messages: messages,
            model: .gpt3_5Turbo
        )
        
        let result = try await openAI.chats(query: query)
        
        guard let chat = result.choices.first?.message,
              let model = AIChatModel(chat: chat) else {
            throw OpenAIError.invalidResponse
        }
        
        return model
    }
    
    enum OpenAIError: LocalizedError {
        case invalidResponse
    }
}

struct AIChatModel: Codable {
    let role: AIChatRole
    let message: String
    
    init(role: AIChatRole, message: String) {
        self.role = role
        self.message = message
    }
    
    init?(chat: ChatResult.Choice.ChatCompletionMessage) {
        self.role = AIChatRole(role: chat.role)
        if let string = chat.content?.string {
            self.message = string
        } else {
            return nil
        }
    }
    
    func toOpenAIModel() -> ChatQuery.ChatCompletionMessageParam? {
        ChatQuery.ChatCompletionMessageParam(
            role: role.openAIRole,
            content: [
                ChatContent.chatCompletionContentPartTextParam(ChatText(text: message))
            ]
        )
    }
    
    static var mock: AIChatModel {
        .init(role: .assistant, message: "This is returned text from the AI")
    }
}

enum AIChatRole: Codable {
    case system, user, assistant, tool
    
    init(role: ChatQuery.ChatCompletionMessageParam.Role) {
        switch role {
        case .system:
            self = .system
        case .user:
            self = .user
        case .assistant:
            self = .assistant
        case .tool:
            self = .tool
        }
    }
    
    var openAIRole: ChatQuery.ChatCompletionMessageParam.Role {
        switch self {
        case .system:
            return .system
        case .user:
            return .user
        case .assistant:
            return .assistant
        case .tool:
            return .tool
        }
    }
}
