//
//  ButtonBarView.swift
//  Soundify
//
//  Created by Viet Anh on 3/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit

final class ButtonBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(on viewController: UIViewController , hasSegmentedControl segmentedControl: UISegmentedControl) {
        backgroundColor = .lightGray
        self.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.height.equalTo(3)
            make.leading.equalTo(viewController.view.safeAreaLayoutGuide.snp.leading)
            make.width.equalTo(segmentedControl.snp.width).multipliedBy( 1.0 / Double(segmentedControl.numberOfSegments) )
        }
    }
}
