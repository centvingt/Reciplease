//
//  CoreDataStorageTestCase.swift
//  RecipleaseTests
//
//  Created by Vincent Caronnet on 25/07/2021.
//

@testable import Reciplease
import XCTest

class CoreDataStorageTestCase: XCTestCase {
    var sut = CoreDataStorage(.inMemory)
    
    let recipe1 = RecipeDataSample.value.hits[0].recipe
    let recipe2 = RecipeDataSample.value.hits[1].recipe
    
    override func setUp() {
        super.setUp()
        
        sut = CoreDataStorage(.inMemory)
    }
    
    func testGivenRecipesStored_WhenAllRecipes_ThenReturnCorrectData() {
        // Given
        sut.saveRecipe(recipe1)
        sut.saveRecipe(recipe2)

        // When
        let query = sut.getAllRecipes()
        
        // Then
        XCTAssertNotNil(query)
        XCTAssertEqual(query, [recipe1, recipe2])
    }
    
    func testGivenRecipe_WhenSaveSameRecipe_ThenSavedRecipeIsTheSame() {
        // Given
        sut.saveRecipe(recipe1)
        
        // When
        sut.saveRecipe(recipe1)
        
        // Then
        let query = sut.getRecipe(with: recipe1.url)
        
        XCTAssertNotNil(query)
        XCTAssertEqual(query, recipe1)
    }
    
    func testGivenNoCorrectRecipeSaved_WhenGetRecipe_ThenReturnNil() {
        // Given
        sut.saveRecipe(recipe1)
        
        // When
        let query = sut.getRecipe(with: recipe2.url)
        
        // Then
        XCTAssertNil(query)
    }
    
    func testGivenRecipeSaved_WhenDeleteRecipe_ThenGetRecipeReturnNil() {
        // Given
        sut.saveRecipe(recipe1)
        
        // When
        sut.deleteRecipe(recipe1)
        
        // Then
        let query = sut.getRecipe(with: recipe1.url)
        XCTAssertNil(query)
    }
    
    func testGivenNoRecipeSaved_WhenDeleteRecipe_ThenGetRecipeReturnNil() {
        // Given
        
        // When
        sut.deleteRecipe(recipe1)
        
        // Then
        let query = sut.getRecipe(with: recipe1.url)
        XCTAssertNil(query)
    }
    
    func testGivenNoRecipeSaved_WhenGetRecipes_ThenGetAllRecipesReturnNil() {
        // Given
        
        // When
        let query = sut.getAllRecipes()
        
        // Then
        XCTAssertNil(query)
    }
}
