//
//  RecipleaseService.swift
//  Reciplease
//
//  Created by Déborah Suon on 06/05/2022.
//

import Foundation

class RecipleaseService {
    
    private let recipeSession: RecipleaseProtocol
    
    init(recipeSession: RecipleaseProtocol = RecipleaseSession()) {
        self.recipeSession = recipeSession
    }
    
    /// network call to get the recipes
    func getRecipes(ingredientsList: [String], completionHandler: @escaping (Bool, RecipesSearch?) -> Void) {

        guard let url = recipeUrl(ingredientsList: ingredientsList) else { return }
        print(url)
        recipeSession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let recipeSearch = try? JSONDecoder().decode(RecipesSearch.self, from: data) else {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, recipeSearch)
        }
        print("test OK------")
    }

    /// func to create the url of the recipe for the search
    func recipeUrl(ingredientsList: [String]) -> URL? {
        let ingredientUrl = ingredientsList.joined(separator: ",")
        print(ingredientUrl)
        guard let url = URL(string: recipeSession.urlStringApi + ingredientUrl) else { return nil }
        print(url)
        return url
    }
}
/// ID for API = 71985ae2     
