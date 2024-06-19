//
//  FavoriteButton.swift
//  CocktailBook
//
//  Created by Rachana  on 19/06/24.
//

import Foundation
import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    
    var body: some View {
        Button(action: {
            isFavorite.toggle()
        }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(isFavorite ? .purple : .gray)
                .font(.system(size: 24))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
