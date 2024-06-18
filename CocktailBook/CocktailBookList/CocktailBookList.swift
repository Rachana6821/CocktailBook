//
//  CocktailBookList.swift
//  CocktailBook
//
//  Created by Rachana  on 18/06/24.
//

import SwiftUI

struct CocktailBookList: View {
   
@StateObject private var viewModel = CocktailBookListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.cocktails) { cocktail in
                NavigationLink(destination: CocktailDetailView(cocktail: cocktail)) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(cocktail.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text(cocktail.name)
                                    .font(.headline)
                                Text(cocktail.shortDescription)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(5)
                        
                    }
                }
                
            }
            .navigationBarTitle("Cocktails", displayMode: .inline)
            .onAppear {
                viewModel.fetchCocktails()
            }
           
        }
    }
}


struct CocktailBookList_Previews: PreviewProvider {
    static var previews: some View {
        CocktailBookList()
    }
}

