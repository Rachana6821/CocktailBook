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
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack{
                if let index = viewModel.cocktails.firstIndex(where: { $0.id == cocktail.id }) {
                    Text(cocktail.name)
                        .font(.headline)
                        .foregroundColor(viewModel.cocktails[index].isFavorite ? .purple : .black)
                    Spacer()
                    FavoriteButton(isFavorite: Binding(
                        get: { viewModel.cocktails[index].isFavorite},
                        set: { newValue in viewModel.cocktails[index].isFavorite = newValue }
                    ), tag: viewModel.cocktails[index].id)
                }
                
            }
            Text(cocktail.shortDescription)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }

}
