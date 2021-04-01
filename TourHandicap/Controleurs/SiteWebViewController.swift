//
//  SiteWebViewController.swift
//  TourHandicap
//
//  Created by Lionel Nouboussi on 31/03/2021.
//

import UIKit
import WebKit

class SiteWebViewController: UIViewController, WKNavigationDelegate {
    
    var url : String?
    var webview : WKWebView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let myURL = URL(string: url!){
        // Do any additional setup after loading the view.
            let urlRequest = URLRequest(url: myURL)
            //webview.loadHTMLString("pageweb", baseURL: myURL)
            webview.load(urlRequest)
        }
        self.navigationItem.title = "\(url!)"
    }
    
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        self.view = webview

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


