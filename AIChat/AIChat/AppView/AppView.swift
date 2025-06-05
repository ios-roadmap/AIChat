//
//  AppView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 4.05.2025.
//

import SwiftUI

struct AppView: View {

    @Environment(\.authService) private var authService
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
        .task {
            await checkUserStatus()
        }
        .onChange(of: appState.showTabBar) { oldValue, newValue in
            if !newValue { //showTabBar
                Task {
                    await checkUserStatus()
                }
            }
        }
    }
    
    private func checkUserStatus() async {
        if let user = authService.getAuthenticatedUser() {
            // User is authenticated
            print("User already signed in: \(user.uid)")
        } else {
            
            do {
                let user = try await authService.signInAnonymously()
                
                print("Sign in anonymously successful: \(user.user.uid)")
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    AppView(appState: .init(showTabBar: true))
}

#Preview("False") {
    AppView(appState: .init(showTabBar: false))
}
