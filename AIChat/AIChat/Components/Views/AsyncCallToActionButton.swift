//
//  AsyncCallToActionButton.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 20.05.2025.
//

import SwiftUI

struct AsyncCallToActionButton: View {
    
    var isLoading: Bool = false
    var title: String = "Save"
    var action: () -> Void
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(title)
            }
        }
        .callToActionButton()
        .anyButton(option: .press) {
            action()
        }
        .disabled(isLoading)
        
    }
}

private struct PreviewView: View {
    
    @State private var isLoadimg: Bool = false
    
    var body: some View {
        AsyncCallToActionButton(
            isLoading: isLoadimg,
            title: "Finish") {
                isLoadimg = true
                
                Task {
                    try? await Task.sleep(for: .seconds(2))
                    isLoadimg = false
                }
            }
    }
}

#Preview {
    PreviewView()
        .padding()
}
