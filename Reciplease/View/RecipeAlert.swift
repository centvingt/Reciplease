//
//  RecipeAlert.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 19/07/2021.
//

import Foundation
import UIKit

enum RecipeError {
    case internetConnection,
         noRecipeData,
         webView,
         undefined
}

class RecipeAlert {
    static func getAlert(for error: RecipeError) -> UIAlertController {
        var title = ""
        var message = ""
        
        switch error {
        case .internetConnection:
            title = "No internet connection"
            message = "Activate your internet connection before using the application."
        case .noRecipeData:
            title = "No recipes"
            message = "No recipes were found with your ingredients."
        case .webView:
            title = "Website error"
            message = "The website encountered an error."
        case .undefined:
            title = "Undefined error"
            message = "An indeterminate error has occurred."
        }
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )
        
        return alert
    }
}
