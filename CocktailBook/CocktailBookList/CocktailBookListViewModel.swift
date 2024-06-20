//
//  CocktailBookListViewModel.swift
//  CocktailBook
//
//  Created by Rachana  on 18/06/24.
//

import Foundation
import Combine

///Enum created for filter cases for reusing
enum CocktailFilter {
    case all
    case alcoholic
    case nonAlcoholic
}

class CocktailBookListViewModel: ObservableObject {
    @Published var cocktails: [Cocktail] = []
    private var cancellables = Set<AnyCancellable>()
    @Published var filteredCocktails: [Cocktail] = []
    private let cocktailsAPI: CocktailsAPI = FakeCocktailsAPI()

    
    init() {
          fetchCocktails()
      }
      ///Fetch Details from Cocktail API

    func fetchCocktails() {
        cocktailsAPI.fetchCocktails { result in
            if case let .success(data) = result {
                do {
                    let cocktails = try JSONDecoder().decode([Cocktail].self, from: data)
                    DispatchQueue.main.async {
                        // Sort cocktails alphabetically by name
                        self.cocktails = cocktails.sorted { $0.name < $1.name }
                        //Adding to User Defaults for persistence
                        if let array = UserDefaults.standard.object(forKey: "favorites") as? Array<String> {
                            for (index, _) in self.cocktails.enumerated() {
                                if array.contains(self.cocktails[index].id) {
                                    self.cocktails[index].isFavorite = true
                                }
                            }
                        }
                        //Adding customised coctail array to filtered array
                        self.filteredCocktails = self.cocktails
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            } else if case let .failure(error) = result {
                print("Error fetching data: \(error)")
            }
        }
    }

    /// Method to apply filter to the cocktails from json data
    
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

