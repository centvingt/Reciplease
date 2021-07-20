//
//  DirectionsViewController.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 20/07/2021.
//

import UIKit
import WebKit

class DirectionsViewController: UIViewController, WKUIDelegate {
    var recipeURL: String?
    
    var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var container: UIView!
    
    override func loadView() {
        super.loadView()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        container.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0).isActive = true
        webView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0).isActive = true
        
        container.layer.opacity = 0
        
        guard
            let recipeURL = recipeURL,
            let url = URL(string: recipeURL)
        else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
}

extension DirectionsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 4, options: []) {
            self.activityIndicator.stopAnimating()
            self.container.layer.opacity = 1
        }
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        present(
            RecipeAlert.getAlert(for: .noRecipeData),
            animated: true
        )
    }
}
