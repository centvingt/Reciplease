//
//  RecipeDataSample.swift
//  RecipleaseTests
//
//  Created by Vincent Caronnet on 25/07/2021.
//

@testable import Reciplease
import Foundation

struct RecipeDataSample {
    static let value = RecipeData(
        count: 10000,
        hits: [
            RecipeData.Hit(
                recipe: Recipe(
                    label: "Chicken Vesuvio",
                    image: "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg",
                    url: "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
                    ingredientLines: [
                        "1/2 cup olive oil",
                        "5 cloves garlic, peeled",
                        "2 large russet potatoes, peeled and cut into chunks",
                        "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)",
                        "3/4 cup white wine",
                        "3/4 cup chicken stock",
                        "3 tablespoons chopped parsley",
                        "1 tablespoon dried oregano",
                        "Salt and pepper",
                        "1 cup frozen peas, thawed"
                    ],
                    totalTime: 60.0,
                    calories: 4228.043058200812
                )
            ),
            RecipeData.Hit(
                recipe: Recipe(
                    label: "Chicken Paprikash",
                    image: "https://www.edamam.com/web-img/e12/e12b8c5581226d7639168f41d126f2ff.jpg",
                    url: "http://norecipes.com/recipe/chicken-paprikash/",
                    ingredientLines: [
                        "640 grams chicken - drumsticks and thighs ( 3 whole chicken legs cut apart)",
                        "1/2 teaspoon salt",
                        "1/4 teaspoon black pepper",
                        "1 tablespoon butter – cultured unsalted (or olive oil)",
                        "240 grams onion sliced thin (1 large onion)",
                        "70 grams Anaheim pepper chopped (1 large pepper)",
                        "25 grams paprika (about 1/4 cup)",
                        "1 cup chicken stock",
                        "1/2 teaspoon salt",
                        "1/2 cup sour cream",
                        "1 tablespoon flour – all-purpose"
                    ],
                    totalTime: 0.0,
                    calories: 3033.2012500008163
                )
            )
        ]
    )
}
