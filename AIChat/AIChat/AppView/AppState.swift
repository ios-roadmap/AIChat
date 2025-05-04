//
//  AppState.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 4.05.2025.
//

import SwiftUI

@Observable
class AppState {
    private(set) var showTabBar: Bool {
        didSet {
            UserDefaults.standard.set(showTabBar, forKey: "showTabbarView")
        }
    }
    init(showTabBar: Bool = UserDefaults.standard.bool(forKey: "showTabbarView")) {
        self.showTabBar = showTabBar
    }
    func updateViewState(showTabBarView: Bool) {
        showTabBar = showTabBarView
    }
}

extension UserDefaults {
    private enum Keys {
        static let showTabbarView = "showTabbarView"
    }
    static var showTabbarView: Bool {
        get {
            standard.bool(forKey: Keys.showTabbarView)
        }
        set {
            standard.set(newValue, forKey: Keys.showTabbarView)
        }
    }
}
