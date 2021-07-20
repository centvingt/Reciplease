//
//  RecipeData.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 17/07/2021.
//

import Foundation

struct RecipeData: Decodable {
    let count: Int64
    let hits: [Hit]
    
    struct Hit: Decodable {
        let recipe: Recipe
    }
}

struct Recipe: Decodable {
    let label: String
    let image: String
    let url: String
    let ingredientLines: [String]
    let totalTime: Float
    let calories: Double
}
