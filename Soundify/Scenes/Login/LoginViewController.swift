//
//  ViewController.swift
//  Soundify
//
//  Created by Viet Anh on 2/24/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import WebKit

final class LoginViewController: UIViewController {
    private let userRepository = UserRepository()
    private let loginWebView = LoginWebView()
    private let spotifyViewController = UIViewController()
    private lazy var loginNavigationController = UINavigationController(rootViewController: spotifyViewController)
    
    override func viewDidLoad() {
        setUpUILoginWebView()
        setUpBarButton()
    }
    
    @IBAction private func loginButtonClicked(_ sender: UIButton) {
        popUpLoginView()
    }
    
    private func popUpLoginView() {
        userRepository.login(on: loginWebView)
        self.present(loginNavigationController, animated: true, completion: nil)
        loginWebView.reload()
    }
}

//MARK: - SetUp LoginNavigationController
extension LoginViewController {
    private func setUpUILoginWebView() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        loginNavigationController.navigationBar.titleTextAttributes = textAttributes
        
        loginNavigationController.navigationBar.isTranslucent = false
        loginNavigationController.navigationBar.tintColor = UIColor.white
        loginNavigationController.navigationBar.barTintColor = #colorLiteral(red: 0.1137254902, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
        loginNavigationController.modalPresentationStyle = .overFullScreen
        
        spotifyViewController.view.addSubview(loginWebView)
        
        loginWebView.navigationDelegate = self
        loginWebView.setupUI(on: spotifyViewController)
    }
    
    private func setUpBarButton() {
        spotifyViewController.navigationItem.title = "spotify.com"
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.handleCancelButton))
        spotifyViewController.navigationItem.leftBarButtonItem = cancelButton
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.handleRefreshControl))
        spotifyViewController.navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc private func handleCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleRefreshControl() {
        self.loginWebView.reload()
    }
}

//MARK: - WKNavigationDelegate
extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let code = navigationAction.request.queryString(after: Constants.responseQuery) {
            userRepository.requestToken(with: code) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.gotoMainTabBarScene()
                case .failure(let error):
                    self.showErrorAlert(message: error.debugDescription)
                default:
                    break
                }
            }
        }
        decisionHandler(.allow)
    }
    
    private func gotoMainTabBarScene() {
        DispatchQueue.main.async {
            if let mainTabBar = AppStoryboard.main.instantiateInitialViewController() {
                mainTabBar.modalTransitionStyle = .flipHorizontal
                mainTabBar.modalPresentationStyle = .overFullScreen
                self.show(mainTabBar, sender: nil)
            }
        }
    }
}
