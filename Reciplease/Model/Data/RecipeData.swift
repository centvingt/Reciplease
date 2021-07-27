//
//  RecipeData.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 17/07/2021.
//

import Foundation

struct RecipeData: Decodable, Equatable {
    static func == (lhs: RecipeData, rhs: RecipeData) -> Bool {
        return lhs.count == rhs.count
            && lhs.hits == lhs.hits
    }
    
    let count: Int64
    let hits: [Hit]
    
    struct Hit: Decodable, Equatable {
        static func == (lhs: Hit, rhs: Hit) -> Bool {
            return lhs.recipe == rhs.recipe
        }
        let recipe: Recipe
    }
}

struct Recipe: Decodable, Equatable {
    let label: String
    let image: String
    let url: String
    let ingredientLines: [String]
    let totalTime: Float
    let calories: Double
}
