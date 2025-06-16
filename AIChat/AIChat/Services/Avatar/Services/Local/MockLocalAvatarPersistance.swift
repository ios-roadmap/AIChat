//
//  MockLocalAvatarPersistence.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 15.06.2025.
//

@MainActor
struct MockLocalAvatarPersistence: LocalAvatarPersistence {
    
    func addRecentAvatar(avatar: AvatarModel) throws {
        
    }
    
    func getRecentAvatars() throws -> [AvatarModel] {
        AvatarModel.mocks.shuffled()
    }
}
