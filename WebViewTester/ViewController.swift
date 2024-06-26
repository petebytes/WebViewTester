//
//  ViewController.swift
//  WebViewTester
//
//  Created by Ghar on 6/25/24.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    func setupWebView() {
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        // Load a default page
        if let url = URL(string: "https://www.example.com") {
            webView.load(URLRequest(url: url))
        }
    }
    
    @IBAction func openInSameTab(_ sender: Any) {
        loadURL(in: .sameTab)
    }
    
    @IBAction func openInNewTab(_ sender: Any) {
        loadURL(in: .newTab)
    }
    
    @IBAction func openInExternalBrowser(_ sender: Any) {
        loadURL(in: .externalBrowser)
    }
    
    enum OpenMethod {
        case sameTab, newTab, externalBrowser
    }
    
    func loadURL(in method: OpenMethod) {
        guard let urlString = urlTextField.text, let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        switch method {
        case .sameTab:
            webView.load(URLRequest(url: url))
        case .newTab:
            webView.load(URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30.0))
        case .externalBrowser:
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}


// MARK: - WKNavigationDelegate
extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView finished loading")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("WebView failed to load: \(error.localizedDescription)")
    }
}

// MARK: - WKUIDelegate
extension ViewController: WKUIDelegate {
    // Implement any necessary WKUIDelegate methods here
}
