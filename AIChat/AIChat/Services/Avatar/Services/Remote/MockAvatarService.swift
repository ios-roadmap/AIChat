//
//  MockAvatarService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

import SwiftUI

struct MockAvatarService: RemoteAvatarService {
    
    let avatars: [AvatarModel]
    let delay: Double
    let showError: Bool
    
    init(
        avatars: [AvatarModel] = AvatarModel.mocks,
        delay: Double = 0.0,
        showError: Bool = false
    ) {
        self.avatars = avatars
        self.delay = delay
        self.showError = showError
    }
    
    private func tryShowError() throws {
        if showError {
            throw URLError(.unknown)
        }
    }
    
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws {
        try tryShowError()
    }
    
    func getFeaturedAvatars() async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return avatars.shuffled()
    }
    
    func getPopularAvatars() async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return avatars.shuffled()
    }
    
    func getAvatarsForCategory(category: CharacterOption) async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return avatars.shuffled()
    }
    
    func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return avatars.shuffled()
    }
    
    func getAvatar(id: String) async throws -> AvatarModel {
        try tryShowError()
        guard let avatar = avatars.first(where: { $0.id == id }) else {
            throw URLError(.noPermissionsToReadFile)
        }
        try await Task.sleep(for: .seconds(delay))
        return avatar
    }
    
    func incrementAvatarClickCount(avatarId: String) async throws {
        
    }
}
