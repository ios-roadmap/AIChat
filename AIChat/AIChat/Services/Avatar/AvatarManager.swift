//
//  AvatarManager.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

import SwiftUI

@MainActor
@Observable
class AvatarManager {
    
    private let local: LocalAvatarPersistence
    private let remote: RemoteAvatarService
     
    init(service: RemoteAvatarService, local: LocalAvatarPersistence = MockLocalAvatarPersistence()) {
        self.remote = service
        self.local = local
    }
    
    func addRecentAvatar(avatar: AvatarModel) async throws {
        try local.addRecentAvatar(avatar: avatar)
        try await remote.incrementAvatarClickCount(avatarId: avatar.id)
    }
    
    func getRecentAvatars() throws -> [AvatarModel] {
        try local.getRecentAvatars()
    }
    
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws {
        try await remote.createAvatar(avatar: avatar, image: image)
    }
    
    func getFeaturedAvatars() async throws -> [AvatarModel] {
        try await remote.getFeaturedAvatars()
    }
    
    func getPopularAvatars() async throws -> [AvatarModel] {
        try await remote.getPopularAvatars()
    }
    
    func getAvatarsForCategory(category: CharacterOption) async throws -> [AvatarModel] {
        try await remote.getAvatarsForCategory(category: category)
    }
    
    func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel] {
        try await remote.getAvatarsForAuthor(userId: userId)
    }
    
    func getAvatar(id: String) async throws -> AvatarModel {
        try await remote.getAvatar(id: id)
    }
    
    func removeAuthorIdFromAvatar(avatarId: String) async throws {
        try await remote.removeAuthorIdFromAvatar(avatarId: avatarId)
    }
    
    func aremoveAuthorIdFromAllUserAvatarss(userId: String) async throws {
        try await remote.removeAuthorIdFromAllUserAvatars(userId: userId)
    }
    
}
