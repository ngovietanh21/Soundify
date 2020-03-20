//
//  SearchSegmentedControl.swift
//  Soundify
//
//  Created by Viet Anh on 3/9/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import SnapKit

final class SearchSegmentedControl: UISegmentedControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(on viewController: UIViewController) {
        let safeArea = viewController.view.safeAreaLayoutGuide
        snp.makeConstraints { (make) in
            make.top.equalTo(safeArea.snp.top)
            make.leading.equalTo(safeArea.snp.leading)
            make.trailing.equalTo(safeArea.snp.trailing)
            make.height.equalTo(40)
        }
    }
    
    func setUpView() {
        selectedSegmentIndex = 0
        removeSeparators(withBackgroundColor: .clear, tintColor: .clear)
        
        let textAttributesNormal : [NSAttributedString.Key: Any] =
            [.foregroundColor : UIColor.lightText]
        
        let textAttributesSelected : [NSAttributedString.Key: Any] =
            [.foregroundColor : UIColor.white]
        
        setTitleTextAttributes(textAttributesNormal, for: .normal)
        setTitleTextAttributes(textAttributesSelected, for: .selected)
    }
}

