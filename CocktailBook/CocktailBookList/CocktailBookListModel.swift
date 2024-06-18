//
//  CocktailBookListModel.swift
//  CocktailBook
//
//  Created by Rachana  on 18/06/24.
//

import Foundation

struct Cocktail: Identifiable, Codable {
    let id: String
    let name: String
    let type: String
    let shortDescription: String
    let longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
}

