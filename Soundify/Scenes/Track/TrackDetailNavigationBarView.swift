//
//  TrackDetailNavigationBarView.swift
//  Soundify
//
//  Created by Viet Anh on 3/18/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import UIKit

final class TrackDetailNavigationBarView: UIView {
    
    private let titleLabel = UILabel()
    private let dismissButton = UIButton(type: .custom)
    
    private unowned var viewControllerDetail: UIViewController!
    
    private let screenWidth = UIScreen.main.bounds.size.width
    
    private var navigationBarHeight: CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return height
    }
    
    func configView (on viewController: UIViewController, aboveSafeArea view: UIView, with track: Track) {
        setupView(on: viewController, aboveSafeArea: view)
        
        configTitleLabel(track)
        
        configDismissButton()
    }
    
    private func setupView(on viewController: UIViewController, aboveSafeArea: UIView) {
        viewControllerDetail = viewController
        
        viewController.view.addSubview(self)
        
        self.backgroundColor = .clear
        
        self.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(aboveSafeArea.snp.bottom)
            make.height.equalTo(navigationBarHeight)
        }
    }
    
    private func configTitleLabel(_ track: Track) {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(screenWidth - 82)
        }
        
        titleLabel.do {
            $0.text = track.album?.name
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textColor = .white
        }
    }
    
    private func configDismissButton() {
        self.addSubview(dismissButton)
        
        dismissButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        dismissButton.do {
            $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            $0.tintColor = .white
            $0.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        }
    }
    
    @objc private func dismissButtonClicked() {
        viewControllerDetail.dismiss(animated: true, completion: nil)
    }
}
