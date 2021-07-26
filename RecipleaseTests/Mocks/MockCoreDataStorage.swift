//
//  MockCoreDataStorage.swift
//  RecipleaseTests
//
//  Created by Vincent Caronnet on 25/07/2021.
//

@testable import Reciplease

class MockCoreDataStorage: CoreDataStorageProtocol {
    var recipes = [Recipe]()

    func saveRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
    }
    
    func getAllRecipes() -> [Recipe]? {
        if recipes.isEmpty {
            return nil
        }
        return recipes
    }
    
    func getRecipe(with url: String) -> Recipe? {
        guard
            let recipe = recipes
                .first(where: { $0.url == url })
        else { return nil }
        return recipe
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        recipes = recipes.filter{ $0 != recipe }
    }
}
