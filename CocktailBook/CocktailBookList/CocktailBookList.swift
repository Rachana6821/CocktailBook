//
//  CocktailBookList.swift
//  CocktailBook
//
//  Created by Rachana  on 18/06/24.
//

import SwiftUI

struct CocktailBookList: View {
    @StateObject private var viewModel = CocktailBookListViewModel()//Instance of viewmodel
    @State private var selectedFilter: CocktailFilter = .all //Default selected filter
    
    private var navigationTitle: String {// Navigation Title based on the selected filter
        switch selectedFilter {
        case .all:
            return "All Cocktails"
        case .alcoholic:
            return "Alcoholic Cocktails"
        case .nonAlcoholic:
            return "Non-Alcoholic Cocktails"
        }
    }
    /// View which shows the Filter and list of coctails based on filter segment selected.
    var body: some View {
        ///Navigation View
        NavigationView {
            ///Vertical Stack View which has segement control and list view
            VStack {
                ///
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
                    NavigationLink(destination: CocktailDetailView(cocktail: cocktail, navigationTitle: navigationTitle, viewModel: viewModel)) {
                        HStack {
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
                }
                .listStyle(.plain)
                .navigationBarItems(leading: Text("\(navigationTitle)").font(.title))
            }
        }
        .onAppear {
            selectedFilter = .all
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

