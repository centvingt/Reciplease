//
//  MockResponseData.swift
//  RecipleaseTests
//
//  Created by Vincent Caronnet on 23/07/2021.
//

import Foundation

class MockResponseData {
    // MARK: - Simulate URL
    
    static let goodURL = "https://www.apple.com/fr/"
    static let badURL = "bad url"
    
    // MARK: - Simulate response
    static let responseOK = HTTPURLResponse(
        url: URL(string: goodURL)!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: [:]
    )!
    static let responseKO = HTTPURLResponse(
        url: URL(string: goodURL)!,
        statusCode: 500,
        httpVersion: nil,
        headerFields: [:]
    )!
    static let responseWithBadURL = HTTPURLResponse(
        url: URL(string: badURL)!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: [:]
    )!
    static let responseWithConnectionError = HTTPURLResponse(
        url: URL(string: badURL)!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: [:]
    )!
    
    // MARK: - Simulate error
    class FakeResponseDataError: Error {}
    static let error = FakeResponseDataError()
    static let internetConnectionError = URLError(.notConnectedToInternet)
    static let undefinedError = URLError(.cannotFindHost)
    
    // MARK: - Simulate data
    static var correctData: Data? {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "EdamanData", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let incorrectData = "incorrect data".data(using: .utf8)!
}
