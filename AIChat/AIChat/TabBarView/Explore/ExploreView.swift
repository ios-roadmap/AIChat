//
//  ExploreView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 4.05.2025.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Explore")
                NavigationLink("Click", destination: Text("sqe"))
            }
        }
    }
}

#Preview {
    ExploreView()
}
