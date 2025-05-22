//
//  NavigationPathOption.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 22.05.2025.
//

enum NavigationPathOption: Hashable {
    case chat(avatarId: String)
    case category(category: CharacterOption, imageName: String)
}
