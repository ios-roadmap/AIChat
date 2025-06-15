//
//  LocalAvatarPersistance.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 15.06.2025.
//

@MainActor
protocol LocalAvatarPersistance {
    func addRecentAvatar(avatar: AvatarModel) throws
    func getRecentAvatars() throws -> [AvatarModel]
}
