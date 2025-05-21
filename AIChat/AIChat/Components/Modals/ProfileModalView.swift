//
//  ProfileModalView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 21.05.2025.
//

import SwiftUI

struct ProfileModalView: View {
    
    var imageName: String? = Constants.randomImage
    var title: String? = "Alpha"
    var subtitle: String? = "Alien"
    var headline: String? = "An alien in the park."
    var onXMarkPressed: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            if let imageName {
                ImageLoaderView(urlString: imageName, forceTransitionAnimation: true)
                    .aspectRatio(1, contentMode: .fit)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                
                if let subtitle {
                    Text(subtitle)
                        .font(.title3)
                }
                
                if let headline {
                    Text(headline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.ultraThickMaterial)
        .cornerRadius(16)
        .overlay(alignment: .topTrailing) {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundStyle(.accent)
                .padding(4)
                .tappableBackground()
                .anyButton {
                    onXMarkPressed()
                }
                .padding(8)
        }
    }
}

#Preview("Modal w/in Image") {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        ProfileModalView(onXMarkPressed: {
            
        })
        .padding(40)
    }
}

#Preview("Modal w/out Image") {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        ProfileModalView(onXMarkPressed: {
            
        })
        .padding(40)
    }
}
