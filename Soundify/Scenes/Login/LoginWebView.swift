//
//  LoginWebView.swift
//  Soundify
//
//  Created by Viet Anh on 2/25/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import WebKit

class LoginWebView: WKWebView {
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(on viewControler: UIViewController) {
        viewControler.view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: viewControler.view.topAnchor),
            self.leadingAnchor.constraint(equalTo: viewControler.view.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: viewControler.view.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: viewControler.view.trailingAnchor)
        ])
    }
    
}
