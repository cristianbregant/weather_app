////
////  FLNativeView.swift
////  Runner
////
////  Created by Cristian Bregant on 15/04/22.
//
//
//import Foundation
//
//public class WebviewFactory : NSObject, FlutterPlatformViewFactory {
//    let controller: FlutterViewController
//    
//    init(controller: FlutterViewController) {
//        self.controller = controller
//    }
//    
//    public func create(
//        withFrame frame: CGRect,
//        viewIdentifier viewId: Int64,
//        arguments args: Any?
//    ) -> FlutterPlatformView {
//        let channel = FlutterMethodChannel(
//            name: "webview" + String(viewId),
//            binaryMessenger: controller
//        )
//        return MyWebview(frame, viewId: viewId, channel: channel, args: args)
//    }
//}
////