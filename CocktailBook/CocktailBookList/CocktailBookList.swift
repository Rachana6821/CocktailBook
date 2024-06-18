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
    
        private var navigationTitle: String {
            switch selectedFilter {
            case .all:
                return "All Cocktails"
            case .alcoholic:
                return "Alcoholic Cocktails"
            case .nonAlcoholic:
                return "Non-Alcoholic Cocktails"
            }
        }
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
                    NavigationLink(destination: CocktailDetailView(cocktail: cocktail, navigationTitle: navigationTitle)) {
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

