//
//  RecipeServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Vincent Caronnet on 23/07/2021.
//

@testable import Reciplease
import Alamofire
import XCTest

class RecipeServiceTestCase: XCTestCase {
    var sut: RecipeService!
//    var expectation: XCTestExpectation!
    let timeOut = 1.0
    
    override func setUp() {
//        let configuration = URLSessionConfiguration.af.default
//        configuration.protocolClasses = [MockURLProtocol.self]
//        let session = Session(configuration: configuration)
//
//        sut = RecipeService(
//            session: session,
//            apiURL: MockResponseData.goodURL
//        )
//        expectation = expectation(description: "Service expectation")
    }
    
    func testGivenResponseAndDataAreCorrect_WhenGetRecipe_ThenResponseIsASuccess() {
        // Given
        MockURLProtocol.requestHandler = { request in
            return (
                error: nil,
                response: MockResponseData.responseOK,
                data: MockResponseData.correctData
            )
        }
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)
        
        sut = RecipeService(
            session: session,
            apiURL: MockResponseData.goodURL
        )
        let expectation = expectation(description: "Service expectation")
        
        // When
        sut.getRecipes(from: ["chicken"]) { recipeError, recipeData in
            // Then
            
            XCTAssertNil(recipeError)
            XCTAssertNotNil(recipeData)
            
            XCTAssertEqual(recipeData, RecipeDataSample.value)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeOut)
    }

    func testGivenDataIsIncorrect_WhenGetRecipe_ThenReturnError() {
        print(">>>>>>>>>>>")
        print("RecipeServiceTestCase ~> testGivenDataIsIncorrect")
        // Given
        MockURLProtocol.requestHandler = { request in
            return (
                error: nil,
                response: MockResponseData.responseOK,
                data: MockResponseData.incorrectData
            )
        }
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)
        
        sut = RecipeService(
            session: session,
            apiURL: MockResponseData.goodURL
        )
        let expectation = expectation(description: "Service expectation")
        
        // When
        sut.getRecipes(from: ["chicken"]) { recipeError, recipeData in
            // Then
            
            XCTAssertNotNil(recipeError)
            XCTAssertNil(recipeData)
            
            XCTAssertEqual(recipeError, .undefined)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeOut)
        print("<<<<<<<<<<<<<")
    }

    func testGivenResponseIsIncorrect_WhenGetRecipe_ThenReturnError() {
        // Given
        MockURLProtocol.requestHandler = { request in
            return (
                error: nil,
                response: MockResponseData.responseKO,
                data: MockResponseData.correctData
            )
        }
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)
        
        sut = RecipeService(
            session: session,
            apiURL: MockResponseData.goodURL
        )
        let expectation = expectation(description: "Service expectation")
        
        // When
        sut.getRecipes(from: ["chicken"]) { recipeError, recipeData in
            // Then
            
            XCTAssertNotNil(recipeError)
            XCTAssertNil(recipeData)
            
            XCTAssertEqual(recipeError, .undefined)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeOut)
    }

    func testGivenNoInternetConnection_WhenGetRecipe_ThenReturnError() {
        print(">>>>>>>>>>>>>")
        print("RecipeServiceTestCase ~> testGivenNoInternetConnection")
        // Given
        MockURLProtocol.requestHandler = { request in
            return (
                error: MockResponseData.internetConnectionError,
                response: MockResponseData.responseKO,
                data: MockResponseData.correctData
            )
        }
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)
        
        sut = RecipeService(
            session: session,
            apiURL: MockResponseData.goodURL
        )
        let expectation = expectation(description: "Service expectation")
        
        // When
        sut.getRecipes(from: ["chicken"]) { recipeError, recipeData in
            // Then
            XCTAssertNotNil(recipeError)
            XCTAssertNil(recipeData)
            
            XCTAssertEqual(recipeError, .internetConnection)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeOut)
        print("<<<<<<<<<<<<<")
    }
}
