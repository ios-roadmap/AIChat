//
//  TabBarView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 4.05.2025.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        NavigationStack {
            TabView {
                ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "eyes")
                }

                Text("Chats")
                    .tabItem {
                        Label("Chats", systemImage: "bubble.left.and.bubble.right.fill")
                    }

                Text("Profile")
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    TabBarView()
}
