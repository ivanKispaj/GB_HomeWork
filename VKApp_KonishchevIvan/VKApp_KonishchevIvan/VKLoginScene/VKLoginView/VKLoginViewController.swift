//
//  VKLoginViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 12.04.2022.
//

import UIKit
import WebKit

final class VKLoginViewController: UIViewController {


    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: config)
        return view
    }()

    override func loadView() {
        super.loadView()
        self.view = webView

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        configureWebView()
        loadAuth()
    }

}


private extension VKLoginViewController {

    func configureWebView() {
        navigationController?.navigationBar.isHidden = true
        self.webView.navigationDelegate = self
    }

    func loadAuth() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8134649"), // ID приложения 8134649, 8142951, 8134649
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "offline, friends, groups, photos, status, wall"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "0")
        ]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
}


