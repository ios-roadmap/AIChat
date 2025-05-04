//
//  AppView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 4.05.2025.
//

import SwiftUI
import IRStyleKit

struct AppView: View {

    @State var appState: AppState = AppState()

    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabbarView: {
                TabBarView()
            },
            onboardingView: {
                OnboardingView()
            }
        )
        .environment(appState)
    }
}

#Preview {
    AppView(appState: .init(showTabBar: true))
}

#Preview("False") {
    AppView(appState: .init(showTabBar: false))
}
