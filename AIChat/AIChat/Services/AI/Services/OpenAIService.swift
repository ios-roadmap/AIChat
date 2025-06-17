//
//  OpenAIService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

import SwiftUI
import OpenAI

struct OpenAIService: AIService {
    
    typealias ChatContent = ChatQuery.ChatCompletionMessageParam.UserMessageParam.Content.VisionContent
    typealias ChatText = ChatQuery.ChatCompletionMessageParam.UserMessageParam.Content.VisionContent.ChatCompletionContentPartTextParam
    
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
    
    func generateText(input: String) async throws -> String {
        let message = ChatQuery.ChatCompletionMessageParam(
            role: .user,
            content: [ChatContent.chatCompletionContentPartTextParam(ChatText(text: input))]
        )!
        let query = ChatQuery(
            messages: [
                message
            ],
            model: .gpt3_5Turbo
        )
        let result = try await openAI.chats(query: query)
        
        guard let chat = result.choices.first?.message else {
            throw OpenAIError.invalidResponse
        }
        
        print("qwe")
        print(chat.content)
        return chat.content ?? "null"
    }
    
    enum OpenAIError: LocalizedError {
        case invalidResponse
    }
}
