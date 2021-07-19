//
//  ViewController.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 17/07/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("ViewController ~> viewDidLoad")
        EdamanService.shared.getRecipe(from: ["lol"]) { error, data in
            if let error = error {
                print(error)
            }
            if let data = data {
                print(data)
            }
        }
    }
}

