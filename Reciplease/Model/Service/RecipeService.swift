//
//  RecipeService.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 17/07/2021.
//

import Foundation
import Alamofire

class RecipeService: RecipeServiceProtocol {
    static let shared = RecipeService()
    private init() { }
    
    private var apiURL: String = "https://api.edamam.com/api/recipes/v2?app_id=21ff0084&app_key=695a6b93bca9422faafe734d310a0b99&type=public"
    
    func getRecipe(
        from ingredients: [String],
        completion: @escaping (RecipeError?, RecipeData?) -> ()
    ) {
        guard let q = ingredients
                .joined(separator: ",")
                .lowercased()
                .addingPercentEncoding(withAllowedCharacters: .letters) else {
            completion(.undefined, nil)
            return
        }
        
        DispatchQueue.main.async {
            AF.request("\(self.apiURL)&\(q)")
                .validate()
                .responseDecodable(of: RecipeData.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(nil, value)
                    case let .failure(error):
                        // TODO: Intercepter l’erreur de l’absence de connexion internet
                        print("RecipeService ~> getRecipe ~> error ~>", error)
                        completion(.undefined, nil)
                    }
                }
        }
    }
}

protocol RecipeServiceProtocol {
    func getRecipe(
        from ingredients: [String],
        completion: @escaping (RecipeError?, RecipeData?) -> ()
    )
}
