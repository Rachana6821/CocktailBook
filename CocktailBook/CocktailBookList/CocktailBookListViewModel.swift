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
    @Published var cocktails: [Cocktail] = []//Fetched cocktails from api
    private var cancellables = Set<AnyCancellable>()
    @Published var filteredCocktails: [Cocktail] = []//Empty Array to store filtered cocktails
    private let cocktailsAPI: CocktailsAPI = FakeCocktailsAPI()//Api instance
    @Published var isLoading: Bool = false // Loading state
    @Published var showAlert: Bool = false // Alert state
    @Published var alertMessage: String = "" // Alert message
    
    
    init() {
          fetchCocktails()
      }
      ///Fetch Details from Cocktail API

    func fetchCocktails() {
        self.isLoading = true
        cocktailsAPI.fetchCocktails { result in
            if case let .success(data) = result {
                do {
                    let cocktails = try JSONDecoder().decode([Cocktail].self, from: data)
                    DispatchQueue.main.async {
                        self.isLoading = false
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
                    self.alertMessage = "Error decoding data: \(error.localizedDescription)"
                    self.showAlert = true
                    print("Error decoding data: \(error)")
                }
            } else if case let .failure(error) = result {
                self.alertMessage = "Error fetching data: \(error.localizedDescription)"
                self.showAlert = true
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

