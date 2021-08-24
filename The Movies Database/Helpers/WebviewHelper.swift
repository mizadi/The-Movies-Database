//
//  WebviewHelper.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 12/07/2021.
//

import Foundation
import UIKit
import WebKit
class WebviewHelper {
    static func openWebview(_ url: URL, frame: CGRect) -> UIViewController {
        let webview = WKWebView(frame: frame)
        webview.load(URLRequest(url: url))
        webview.alpha = 0.0
        let controller = UIViewController()
        controller.view = webview
        
        
        UIView.animate(withDuration: 0.5) {
            webview.alpha = 1.0
        }
        return controller
    }
}
