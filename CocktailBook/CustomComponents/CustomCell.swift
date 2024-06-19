//
//  CustomCell.swift
//  CocktailBook
//
//  Created by Rachana  on 19/06/24.
//

import SwiftUI
struct CustomCell: View {
    var cocktail: Cocktail // Assuming Cocktail is your data model
    var viewModel: CocktailBookListViewModel//Instance of viewmodel
    var viewModelFav:Bool
    var index:Int
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack{
//                if let index = viewModel.cocktails.firstIndex(where: { $0.id == cocktail.id }) {
                    Text(cocktail.name)
                        .font(.headline)
                        .foregroundColor(viewModelFav ? .purple : .black)
                    Spacer()
                    FavoriteButton(isFavorite: Binding(
                        get: { viewModelFav},
                        set: { newValue in viewModel.cocktails[index].isFavorite = newValue }
                    ), tag: viewModel.cocktails[index].id)
              //  }
                
            }
            Text(cocktail.shortDescription)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }

}
