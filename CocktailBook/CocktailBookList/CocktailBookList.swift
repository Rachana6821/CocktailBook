//
//  CocktailBookList.swift
//  CocktailBook
//
//  Created by Rachana  on 18/06/24.
//

import SwiftUI

struct CocktailBookList: View {
    
    @StateObject private var viewModel = CocktailBookListViewModel()
    @State private var selectedFilter: CocktailFilter = .all
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: Binding(
                    get: { self.selectedFilter },
                    set: { newValue in
                           self.selectedFilter = newValue
                           self.viewModel.applyFilter(newValue)
                         }
                ), label: Text("Select Filter")) {
                    Text("All Cocktails").tag(CocktailFilter.all)
                    Text("Alcoholic").tag(CocktailFilter.alcoholic)
                    Text("Non-Alcoholic").tag(CocktailFilter.nonAlcoholic)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List(viewModel.filteredCocktails) { cocktail in
                    NavigationLink(destination: CocktailDetailView(cocktail: cocktail)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(cocktail.name)
                                    .font(.headline)
                                Text(cocktail.shortDescription)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                .navigationBarTitle("Cocktails", displayMode: .inline)
            }
           
        } .onAppear {
            self.selectedFilter = .all
            viewModel.fetchCocktails()
            viewModel.applyFilter(selectedFilter)
        }
        
    }
}

struct CocktailBookList_Previews: PreviewProvider {
    static var previews: some View {
        CocktailBookList()
    }
}

