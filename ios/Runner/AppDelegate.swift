import UIKit
import Flutter
import WebKit
import os.log


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)

      registrar(forPlugin: "flutter")!.register(UIRectViewFactory(), withId: "alpian-weather")

      
             return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


class UIRectViewFactory: NSObject, FlutterPlatformViewFactory {
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return UIRectView(frame)
    }
}

class UIRectView: NSObject, FlutterPlatformView, UIGestureRecognizerDelegate {
    let frame: CGRect

    init(_ frame: CGRect) {
        self.frame = frame
    }

    func view() -> UIView {
        let preferences = WKPreferences()
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.preferences.javaScriptEnabled = true

        let view: WKWebView = WKWebView(frame: frame,configuration: configuration)
        
        view.load(URLRequest(url: URL(string: "https://openweathermap.org/weathermap?basemap=map&cities=false&layer=temperature&lat=51&lon=0&zoom=10")!))
        return view
    }
}
