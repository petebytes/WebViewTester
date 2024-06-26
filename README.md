# WebViewTester

WebViewTester is an iOS application that demonstrates different ways of opening web content within the app and in external browsers.

## Features

- Open URLs in the same tab within the app
- Open URLs in a new tab within the app
- Open URLs in an external browser

## Requirements

- Xcode 12.0 or later
- iOS 14.0 or later
- Swift 5.0 or later

## Installation

1. Clone the repository or download the source code.
2. Open the `WebViewTester.xcodeproj` file in Xcode.
3. Select your target device or simulator.
4. Build and run the project (Cmd + R).

## Usage

1. Launch the app on your device or simulator.
2. You'll see a text field at the top of the screen where you can enter a URL.
3. Below the text field, there are three buttons:
   - "Same Tab": Opens the URL in the same tab within the app's WebView.
   - "New Tab": Opens the URL in a new tab within the app's WebView.
   - "External": Opens the URL in the device's default external browser.

4. Enter a valid URL in the text field (e.g., https://www.example.com).
5. Tap one of the buttons to open the URL using the selected method.

## How Web Page Tests are Launched

1. Same Tab:
   - When you tap the "Same Tab" button, the app uses the current WebView to load the URL.
   - This is handled by the `openInSameTab(_:)` method in the ViewController.
   - Technical details:
     - The method calls `loadURL(in: .sameTab)`.
     - Inside `loadURL(in:)`, it creates a `URLRequest` with the entered URL.
     - It then calls `webView.load(URLRequest(url: url))` to load the content in the existing WebView.
     - The WKWebView handles the loading process, including any necessary network requests.

2. New Tab:
   - Tapping the "New Tab" button creates a new WebView and loads the URL into it.
   - This functionality is implemented in the `openInNewTab(_:)` method of the ViewController.
   - Technical details:
     - A new `WKWebView` is created with the same configuration as the main WebView.
     - A new `UIViewController` is created to host this WebView.
     - The new ViewController is given a tab bar item with an incremented number.
     - The new ViewController is added to the `TabBarController`'s `viewControllers` array.
     - The URL is loaded into the new WebView using `newWebView.load(URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30.0))`.

3. External Browser:
   - The "External" button opens the URL in the device's default web browser.
   - This is handled by the `openInExternalBrowser(_:)` method in the ViewController.
   - Technical details:
     - The method calls `loadURL(in: .externalBrowser)`.
     - Inside `loadURL(in:)`, it uses `UIApplication.shared.open(url, options: [:], completionHandler: nil)`.
     - This iOS API call hands off the URL to the system, which then opens it in the user's default browser app.
     - The app's Info.plist file includes necessary URL schemes (http, https) in the `LSApplicationQueriesSchemes` array to allow this functionality.

Each of these methods first validates the URL entered by the user before attempting to load it. The URL validation is done by attempting to create a `URL` object from the entered string. If this fails, the app prints "Invalid URL" to the console.

All web content within the app is loaded using a `WKWebView`, which is configured with a non-persistent `WKWebsiteDataStore` to avoid storing browsing data between sessions. The `WKWebView` is set up in the `setupWebView()` method, which also disables text selection and zoom to avoid potential layout issues.

The app uses `WKNavigationDelegate` and `WKUIDelegate` to handle navigation events and user interface actions in the WebView. This allows for custom handling of page load successes, failures, and other navigation-related events.

## Notes

- The "Same Tab" and "New Tab" options display the web content within the app using WKWebView.
- The "External" option switches to the device's default browser app.
- Make sure to enter complete URLs, including the "http://" or "https://" prefix.
- The app uses a non-persistent WKWebsiteDataStore to avoid storing browsing data between sessions.

## Troubleshooting

- If the URL doesn't load, check your internet connection and ensure the URL is valid.
- If the external browser doesn't open, make sure you've included the necessary URL schemes in the Info.plist file.

## License

This project is open-source and available under the MIT License.
