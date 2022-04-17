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
        self.view.addSubview(webView)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.leadingAnchor.constraint(equalTo: self.webView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: self.webView.trailingAnchor),
            self.view.topAnchor.constraint(equalTo: self.webView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: self.webView.bottomAnchor)
        ])
        configureWebView()
        loadAuth()
        // Do any additional setup after loading the view.
    }

}

// MARK: - WKNavigationDelegate
extension VKLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
                  decisionHandler(.allow)
                  return
              }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        if let token = params["access_token"], let id = params["user_id"] {
            NetworkSessionData.shared.token = token
            NetworkSessionData.shared.userId = Int(id)
            print(token)
            decisionHandler(.cancel)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
               guard let nextVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
               nextVC.modalPresentationStyle = .fullScreen
               nextVC.transitioningDelegate = nextVC
               self.present(nextVC, animated: true)
        }

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
            URLQueryItem(name: "client_id", value: "8134649"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "offline, friends, photos, groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "0")
        ]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        self.webView.load(request)
    }

}


