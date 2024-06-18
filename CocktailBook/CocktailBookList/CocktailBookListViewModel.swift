//
//  CocktailBookListViewModel.swift
//  CocktailBook
//
//  Created by Rachana  on 18/06/24.
//

import Foundation
import Combine

class CocktailBookListViewModel: ObservableObject {
    @Published var cocktails: [Cocktail] = []
    private var cancellables = Set<AnyCancellable>()
    private let cocktailsAPI = CocktailsAPI()
    
    func fetchCocktails() {
        cocktailsAPI.fetchCocktails { result in
            if case let .success(data) = result {
                do {
                    let cocktails = try JSONDecoder().decode([Cocktail].self, from: data)
                    DispatchQueue.main.async {
                        self.cocktails = cocktails
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            } else if case let .failure(error) = result {
                print("Error fetching data: \(error)")
            }
        }
    }
}
