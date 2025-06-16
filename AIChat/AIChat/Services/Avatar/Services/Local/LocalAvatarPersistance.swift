//
//  LocalAvatarPersistence.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 15.06.2025.
//

@MainActor
protocol LocalAvatarPersistence {
    func addRecentAvatar(avatar: AvatarModel) throws
    func getRecentAvatars() throws -> [AvatarModel]
}
