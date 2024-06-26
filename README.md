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

## Notes

- The "Same Tab" and "New Tab" options will display the web content within the app.
- The "External" option will switch to the device's default browser app.
- Make sure to enter complete URLs, including the "http://" or "https://" prefix.

## Troubleshooting

- If the URL doesn't load, check your internet connection and ensure the URL is valid.
- If the external browser doesn't open, make sure you've included the necessary URL schemes in the Info.plist file.

## License

This project is open-source and available under the MIT License.
