//
//  CocktailBookListViewModel.swift
//  CocktailBook
//
//  Created by Rachana  on 18/06/24.
//

import Foundation
import Combine

enum CocktailFilter {
    case all
    case alcoholic
    case nonAlcoholic
}

class CocktailBookListViewModel: ObservableObject {
    @Published var cocktails: [Cocktail] = []
    private var cancellables = Set<AnyCancellable>()
    @Published var filteredCocktails: [Cocktail] = []
    private let cocktailsAPI = CocktailsAPI()
    
    func fetchCocktails() {
        cocktailsAPI.fetchCocktails { result in
            if case let .success(data) = result {
                do {
                    let cocktails = try JSONDecoder().decode([Cocktail].self, from: data)
                    DispatchQueue.main.async {
                        // Sort cocktails alphabetically by name
                        self.cocktails = cocktails.sorted { $0.name < $1.name }

                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            } else if case let .failure(error) = result {
                print("Error fetching data: \(error)")
            }
        }
    }
    func applyFilter(_ filter: CocktailFilter) {
            switch filter {
            case .all:
                filteredCocktails = cocktails
            case .alcoholic:
                filteredCocktails = cocktails.filter { $0.type.lowercased() == "alcoholic" }
            case .nonAlcoholic:
                filteredCocktails = cocktails.filter { $0.type.lowercased() == "non-alcoholic" }
            }
        }
    }

