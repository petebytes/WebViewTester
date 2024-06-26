//
//  ViewController.swift
//  WebViewTester
//
//  Created by Ghar on 6/25/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        urlTextField.delegate = self
    }
    
    func setupWebView() {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        
        // Add content controller to handle JavaScript messages
        let contentController = WKUserContentController()
        configuration.userContentController = contentController
        
        // Disable text input to potentially avoid BETextInput warning
        let script = WKUserScript(source: "document.body.style.webkitUserSelect='none';", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(script)
        
        if webView == nil {
            webView = WKWebView(frame: view.bounds, configuration: configuration)
            webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.insertSubview(webView, at: 0)
        }
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        // Disable zoom to potentially avoid some layout issues
        webView.scrollView.bouncesZoom = false
        
        // Load the application's info page
        let htmlString = """
        <html>
        <head>
            <meta name='viewport' content='width=device-width, initial-scale=1'>
            <style>
                body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; padding: 20px; line-height: 1.6; }
                h1 { color: #007AFF; }
            </style>
        </head>
        <body>
            <h1>WebViewTester</h1>
            <p>WebViewTester is an iOS application that demonstrates different ways of opening web content within the app and in external browsers.</p>
            <h2>Features:</h2>
            <ul>
                <li>Open URLs in the same tab within the app</li>
                <li>Open URLs in a new tab within the app</li>
                <li>Open URLs in an external browser</li>
            </ul>
            <h2>Tech Stack:</h2>
            <ul>
                <li>iOS 14.0+</li>
                <li>Swift 5.0</li>
                <li>UIKit</li>
                <li>WebKit</li>
            </ul>
            <p>Enter a URL in the text field above and try out the different loading options!</p>
        </body>
        </html>
        """
        webView.loadHTMLString(htmlString, baseURL: nil)
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
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("WebView failed provisional navigation: \(error.localizedDescription)")
        if (error as NSError).code == NSURLErrorNotConnectedToInternet {
            // Handle no internet connection error
            print("No internet connection")
        }
    }
}

// MARK: - WKUIDelegate
extension ViewController: WKUIDelegate {
    // Implement any necessary WKUIDelegate methods here
}
// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        loadURL(in: .sameTab)
        return true
    }
}
