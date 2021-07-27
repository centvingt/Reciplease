//
//  RecipeService.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 17/07/2021.
//

import Foundation
import Alamofire

protocol RecipeServiceProtocol {
    func getRecipes(
        from ingredients: [String],
        completion: @escaping (RecipeError?, RecipeData?) -> ()
    )
}

class RecipeService: RecipeServiceProtocol {
    static let shared = RecipeService()
    private init() { }
    
    private var session: Session = AF
    private var apiURL: String = "https://api.edamam.com/api/recipes/v2?app_id=21ff0084&app_key=695a6b93bca9422faafe734d310a0b99&type=public"
    
    init(
        session: Session = AF,
        apiURL: String
    ) {
        self.session = session
        self.apiURL = apiURL
    }
    
    func getRecipes(
        from ingredients: [String],
        completion: @escaping (RecipeError?, RecipeData?) -> ()
    ) {
        guard let q = ingredients
                .joined(separator: ",")
                .lowercased()
                .addingPercentEncoding(
                    withAllowedCharacters: .letters
                )
        else {
            completion(.undefined, nil)
            return
        }
        
        let url = "\(self.apiURL)&q=\(q)"
        
        DispatchQueue.main.async {
            self.session.request(url)
                .validate()
                .responseDecodable(of: RecipeData.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(nil, value)
                    case let .failure(error):
                        print("RecipeService ~> getRecipe ~> error ~>", error)
                        guard let underlyingError = error.underlyingError,
                              let urlError = underlyingError as? URLError,
                              urlError.code == .notConnectedToInternet
                        else {
                            completion(.undefined, nil)
                            return
                        }
                        completion(.internetConnection, nil)
                    }
                }
        }
    }
}

