//
//  AppViewBuilder.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 7.05.2025.
//

import SwiftUI

public struct AppViewBuilder<TabbarView: View, OnboardingView: View>: View {
    public var showTabBar: Bool
    @ViewBuilder public var tabbarView: TabbarView
    @ViewBuilder public var onboardingView: OnboardingView

    public init(
        showTabBar: Bool,
        @ViewBuilder tabbarView: @escaping () -> TabbarView,
        @ViewBuilder onboardingView: @escaping () -> OnboardingView
    ) {
        self.showTabBar = showTabBar
        self.tabbarView = tabbarView()
        self.onboardingView = onboardingView()
    }

    public var body: some View {
        ZStack {
            if showTabBar {
                tabbarView
                    .transition(.move(edge: .trailing))
            } else {
                onboardingView
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.smooth, value: showTabBar)
    }
}

private struct PreviewView: View {
    
    @State private var showTabBar: Bool = false
    
    var body: some View {
        AppViewBuilder(
            showTabBar: showTabBar,
            tabbarView: {
                ZStack {
                    Color.red.ignoresSafeArea()
                    Text("Tabbar")
                }
            },
            onboardingView: {
                ZStack {
                    Color.blue.ignoresSafeArea()
                    Text("Onboarding")
                }
            }
        )
        .onTapGesture {
            showTabBar.toggle()
        }
    }
}
