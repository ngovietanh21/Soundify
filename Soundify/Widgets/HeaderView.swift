//
//  HeaderView.swift
//  Soundify
//
//  Created by Viet Anh on 3/4/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
        setUpView(title)
    }
    
    private func setUpView(_ title: String) {
        self.backgroundColor = #colorLiteral(red: 0.09718047827, green: 0.07773689181, blue: 0.07808386534, alpha: 1)
        self.addSubview(titleLabel)
        titleLabel.text = title        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
}
