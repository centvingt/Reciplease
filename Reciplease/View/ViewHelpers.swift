//
//  ViewHelpers.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 18/07/2021.
//

import UIKit

struct ViewHelpers {
    static func setRoundedCornersOf(view: UIView) {
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
    }
}
