//
//  ImageLoaderView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 7.05.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    let urlString: String
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                WebImage(url: .init(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: .fill)
                    .allowsHitTesting(false)
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView(urlString: Constants.randomImage)
        .frame(width: 100, height: 200)
        .anyButton(option: .highlight) {
            
        }
}
