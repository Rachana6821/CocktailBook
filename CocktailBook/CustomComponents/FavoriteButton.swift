//
//  FavoriteButton.swift
//  CocktailBook
//
//  Created by Rachana  on 19/06/24.
//

import Foundation
import SwiftUI
///Reusable favorite toggle button customised

struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    let tag: String
    var body: some View {
        Button(action: {
            isFavorite.toggle()
            updateFavoriteStatus(id: tag)
        }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(isFavorite ? .purple : .gray)
                .font(.system(size: 24))
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    ///Saving the status for persistence
    func updateFavoriteStatus(id: String) {
        var fav = [String]()
        if let array = UserDefaults.standard.object(forKey: "favorites") as? Array<String> {
            fav = array
        }
        if fav.contains(id) {
            if let index = fav.firstIndex(where: { $0 == id }) {
                fav.remove(at: index)
            }
        } else {
            fav.append(id)
        }
        UserDefaults.standard.set(fav, forKey: "favorites")
    }
}
