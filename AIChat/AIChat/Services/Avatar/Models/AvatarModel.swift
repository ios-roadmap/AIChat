//
//  AvatarModel.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.05.2025.
//

import Foundation

///Default olarak Sendable olur. Task içinde kullanımda Sendable şartı vardır.
///Struct vs Class (advanced):  https://www.youtube.com/watch?v=-JLenSTKEcA&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=9&t=911s
///What is the Sendable protocol:  https://www.youtube.com/watch?v=wSmTbtOwgbE&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=13&t=4s

struct AvatarModel {
    
    let avatarId: String
    let name: String?
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    let profileImageName: String?
    let authorId: String?
    let dateCreated: Date?
    
    init(avatarId: String,
         name: String? = nil,
         characterOption: CharacterOption? = nil,
         characterAction: CharacterAction? = nil,
         characterLocation: CharacterLocation? = nil,
         profileImageName: String? = nil,
         authorId: String? = nil,
         dateCreated: Date? = nil) {
        self.avatarId = avatarId
        self.name = name
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
        self.profileImageName = profileImageName
        self.authorId = authorId
        self.dateCreated = dateCreated
    }
    
    static var mock: AvatarModel {
        mocks[0]
    }
    
    static var mocks: [AvatarModel] {
        [
            .init(avatarId: UUID().uuidString, name: "Alpha", characterOption: .alien, characterAction: .smiling, characterLocation: .park, profileImageName: Constants.randomImage, authorId: UUID().uuidString, dateCreated: .now),
            .init(avatarId: UUID().uuidString, name: "Beta", characterOption: .dog, characterAction: .eating, characterLocation: .forest, profileImageName: Constants.randomImage, authorId: UUID().uuidString, dateCreated: .now),
            .init(avatarId: UUID().uuidString, name: "Gamma", characterOption: .cat, characterAction: .drinking, characterLocation: .museum, profileImageName: Constants.randomImage, authorId: UUID().uuidString, dateCreated: .now),
            .init(avatarId: UUID().uuidString, name: "Delta", characterOption: .woman, characterAction: .shopping, characterLocation: .park, profileImageName: Constants.randomImage, authorId: UUID().uuidString, dateCreated: .now),
        ]
    }
    
    var characterDescription: String {
        
    }14 14 de kaldım. https://www.swiftful-thinking.com/products/swiftui-advanced-architecture/categories/2156266542/posts/2181762818
}

struct AvatarDescriptionBuilder {
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    
    init(characterOption: CharacterOption, characterAction: CharacterAction, characterLocation: CharacterLocation) {
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
    }
    
    var characterDescription: String {
        "A \(characterOption.rawValue) that is \(characterAction?.rawValue  in the \(characterLocation))"
    }
}

enum CharacterOption: String {
    case man, woman, alien, dog, cat
}

enum CharacterAction: String {
    case smiling, sitting, eating, drinking, walking, shopping, studying, working, relaxing, figthing, crying
}

enum CharacterLocation: String {
    case park, mall, museum, city, desert, forest, space
}
