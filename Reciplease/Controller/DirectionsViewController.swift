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
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        guard
            let recipeURL = recipeURL,
            let url = URL(string: recipeURL)
        else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)

    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "loading" {
                if webView.isLoading {
//                    activityIndicator.startAnimating()
//                    activityIndicator.isHidden = false
                    print("DirectionsViewController ~> webView.isLoading")
                } else {
//                    activityIndicator.stopAnimating()
                    print("DirectionsViewController ~> !webView.isLoading ~> keyPath ~>", keyPath)
                }
            }
        }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//extension DirectionsViewController: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print("DirectionsViewController ~> didFinish")
//    }
//}
