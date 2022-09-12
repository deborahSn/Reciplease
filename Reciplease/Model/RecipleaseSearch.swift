//
//  RecipleaseSearch.swift
//  Reciplease
//
//  Created by Déborah Suon on 08/05/2022.
//

import Foundation


struct RecipesSearch: Decodable {
    let hits: [Hit]
}

struct Hit: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let label: String
    let image: String?
    let url: String
    let totalTime: Int?
    let ingredientLines: [String]
}
