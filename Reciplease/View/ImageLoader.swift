//
//  ImageLoader.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 20/07/2021.
//

import Foundation
import SDWebImage

struct ImageLoader {
    static func load(stringUrl: String?, imageView: UIImageView) {
        guard let stringUrl = stringUrl, let url = URL(string: stringUrl) else { return }
        imageView.sd_setImage(with: url, completed: nil)
    }
}
