//
//  RecipeModel.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 19/07/2021.
//

import Foundation

class RecipeModel {
    // MARK: - Dependency injection
    
    private let recipeService: RecipeServiceProtocol
//    private let coreDataStorage: CoreDataStorageProtocol

    init(
        recipeService: RecipeServiceProtocol = RecipeService.shared
//        ,
//        coreDataStorage: CoreDataStorageProtocol = CoreDataStorage()
    ) {
        self.recipeService = recipeService
//        self.coreDataStorage = coreDataStorage
    }
    
    // MARK: - Service request
    
    func getRecipes(
        for ingredients: [String],
        completion: @escaping (RecipeError?, [Recipe]?) -> ()
    ) {
        recipeService.getRecipe(from: ingredients) { recipeError, recipeData in
            // MARK: Errors handling
            
            if let recipeError = recipeError {
                if recipeError == .internetConnection {
                    completion(.internetConnection, nil)
                } else {
                    completion(.undefined, nil)
                }
                return
            }
            guard let recipeData = recipeData else {
                completion(.undefined, nil)
                return
            }

            guard recipeData.count > 0 else {
                completion(.noRecipeData, nil)
                return
            }
            
            // MARK: Data return
            
            completion(
                nil,
                recipeData.hits.map({ $0.recipe })
            )
        }
    }
}
