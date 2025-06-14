//
//  AvatarService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

import SwiftUI

protocol AvatarService: Sendable {
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws
    func getFeaturedAvatars() async throws -> [AvatarModel]
    func getPopularAvatars() async throws -> [AvatarModel]
    func getAvatarsForCategory(category: CharacterOption) async throws -> [AvatarModel]
    func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel]
}
