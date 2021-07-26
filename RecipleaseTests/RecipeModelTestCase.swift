//
//  RecipeModelTestCase.swift
//  RecipleaseTests
//
//  Created by Vincent Caronnet on 25/07/2021.
//

@testable import Reciplease
import XCTest

class RecipeModelTestCase: XCTestCase {
    var sut = RecipeModel()
    
    var recipeService = MockRecipeService()
    var coreDataStorage = MockCoreDataStorage()
    
    let recipe1 = RecipeDataSample.value.hits[0].recipe
    let recipe2 = RecipeDataSample.value.hits[1].recipe
    
    override func setUp() {
        super.setUp()
        
        recipeService = MockRecipeService()
        coreDataStorage = MockCoreDataStorage()
        
        sut = RecipeModel(
            recipeService: recipeService,
            coreDataStorage: coreDataStorage
        )
    }
    
    func testGivenServiceReturnData_WhenGetRecipe_ThenGetData() {
        // Given
        recipeService.recipeData = RecipeDataSample.value
        
        // When
        sut.getRecipes(for: ["chicken"]) { recipeError, recipes in
            // Then
            XCTAssertNil(recipeError)
            XCTAssertNotNil(recipes)
            
            XCTAssertEqual(recipes, [self.recipe1, self.recipe2])
        }
    }
    
    func testGivenServiceReturnError_WhenGetRecipe_ThenGetError() {
        // Given
        recipeService.recipeError = .undefined
        
        // When
        sut.getRecipes(for: ["chicken"]) { recipeError, recipes in
            // Then
            XCTAssertNotNil(recipeError)
            XCTAssertNil(recipes)
            
            XCTAssertEqual(recipeError, .undefined)
        }
    }
    
    func testGivenServiceReturnInternetConnectionError_WhenGetRecipe_ThenGetError() {
        // Given
        recipeService.recipeError = .internetConnection
        
        // When
        sut.getRecipes(for: ["chicken"]) { recipeError, recipes in
            // Then
            XCTAssertNotNil(recipeError)
            XCTAssertNil(recipes)
            
            XCTAssertEqual(recipeError, .internetConnection)
        }
    }
    
    func testGivenServiceReturnNoData_WhenGetRecipe_ThenGetError() {
        // Given
        recipeService.recipeError = nil
        recipeService.recipeData = nil

        // When
        sut.getRecipes(for: ["chicken"]) { recipeError, recipes in
            // Then
            XCTAssertNotNil(recipeError)
            XCTAssertNil(recipes)
            
            XCTAssertEqual(recipeError, .undefined)
        }
    }
    
    func testGivenServiceReturnNoRecipe_WhenGetRecipe_ThenGetError() {
        // Given
        recipeService.recipeError = nil
        recipeService.recipeData = RecipeData(count: 0, hits: [])

        // When
        sut.getRecipes(for: ["chicken"]) { recipeError, recipes in
            // Then
            XCTAssertNotNil(recipeError)
            XCTAssertNil(recipes)
            
            XCTAssertEqual(recipeError, .noRecipeData)
        }
    }
    
    func testGivenRecipeIsNotInFavorite_WhenSetFavorite_ThenRecipeIsFavorite() {
        // Given
        
        // When
        sut.setFavorite(for: recipe1)
        
        // Then
        let recipeIsFavorite = sut.recipeIsFavorite(recipe1)
        
        XCTAssertTrue(recipeIsFavorite)
    }
    
    func testGivenRecipeIsInFavorite_WhenSetFavorite_ThenRecipeIsNotFavorite() {
        // Given
        sut.setFavorite(for: recipe1)
        
        // When
        sut.setFavorite(for: recipe1)
        
        // Then
        let recipeIsFavorite = sut.recipeIsFavorite(recipe1)
        
        XCTAssertFalse(recipeIsFavorite)
    }
    
    func testGivenNoFavorite_WhenGetFavorites_ThenReturnNil() {
        // Given
        
        // When
        let favorites = sut.getFavorites()
        
        // Then
        XCTAssertNil(favorites)
    }
    
    func testGivenFavorites_WhenGetFavorites_ThenReturnNil() {
        // Given
        sut.setFavorite(for: recipe1)
        sut.setFavorite(for: recipe2)

        // When
        let favorites = sut.getFavorites()
        
        // Then
        XCTAssertNotNil(favorites)
        XCTAssertEqual(favorites, [recipe1, recipe2])
    }
}
