//
//  MockRecipeService.swift
//  RecipleaseTests
//
//  Created by Vincent Caronnet on 25/07/2021.
//

@testable import Reciplease

class MockRecipeService: RecipeServiceProtocol {
    var recipeError: RecipeError?
    var recipeData: RecipeData?
    
    func getRecipes(
        from ingredients: [String],
        completion: @escaping (RecipeError?, RecipeData?) -> ()
    ) {
        completion(recipeError, recipeData)
    }
}
