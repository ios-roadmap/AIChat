//
//  CategoryCellView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 19.05.2025.
//

import SwiftUI

struct CategoryCellView: View {
    
    var title: String = "Aliens"
    var imageName: String = Constants.randomImage
    var font: Font = .body
    var cornerRadius: CGFloat = 16
    
    var body: some View {
        ImageLoaderView(urlString: imageName)
            .aspectRatio(1, contentMode: .fit)
            .overlay(alignment: .bottomLeading) {
                Text(title)
                    .font(font)
                    .fontWeight(.semibold)
                    .padding(16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .addingGradientBackgroundForText()
            }
            .cornerRadius(cornerRadius)
    }
}

#Preview {
    CategoryCellView()
        .frame(width: 150)
}
