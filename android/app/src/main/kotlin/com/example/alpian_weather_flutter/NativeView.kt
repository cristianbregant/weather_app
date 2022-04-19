package com.example.alpian_weather_flutter

import android.content.Context
import android.graphics.Color
import android.view.View
import android.webkit.WebSettings
import android.webkit.WebView
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView

internal class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
   // private val textView: TextView
    private val webview: WebView

    override fun getView(): View {
        return webview
    }



    override fun dispose() {}

    init {
        webview = WebView(context)
        webview.settings.javaScriptEnabled = true
        webview.loadUrl("https://openweathermap.org/weathermap?basemap=map&cities=false&layer=temperature&lat=51&lon=0&zoom=10")

    }
}