////
////  ViewController.swift
////  Runner
////
////  Created by Cristian Bregant on 18/04/22.
////
//
//import Foundation
//import UIKit
//import WebKit
//
//public class MyWebview: NSObject, FlutterPlatformView, WKScriptMessageHandler, WKNavigationDelegate {
//    let frame: CGRect
//    let viewId: Int64
//    let channel: FlutterMethodChannel
//    let webview: WKWebView
//    
//    init(_ frame: CGRect, viewId: Int64, channel: FlutterMethodChannel, args: Any?) {
//        self.frame = frame
//        self.viewId = viewId
//        self.channel = channel
//        
//        let config = WKWebViewConfiguration()
//        let webview = WKWebView(frame: frame, configuration: config)
//
//        self.webview = webview
//
//        super.init()
//        
//        channel.setMethodCallHandler({
//            (call: FlutterMethodCall, result: FlutterResult) -> Void in
//            if (call.method == "loadUrl") {
//                let url = call.arguments as! String
//                webview.load(URLRequest(url: URL(string: "https://www.google.it")!))
//            }
//        })
//    }
//    
//    public func view() -> UIView {
//        return self.webview
//    }
//}
