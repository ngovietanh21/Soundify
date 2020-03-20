//
//  TopDetailView.swift
//  Soundify
//
//  Created by Viet Anh on 3/15/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit

protocol TopDetailViewDelegate: class {
    func leftBarButtonItemClicked()
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

final class TopDetailView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var navigationBarView: UIView!
    @IBOutlet private weak var detailImageView: UIImageView!
    @IBOutlet private weak var imageTopSpaceConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabel: UILabel!
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect ,with album: Album) {
        self.init(frame: frame)
        setUpDetailView(with: album)
    }
    
    convenience init(frame: CGRect ,with playlist: Playlist) {
        self.init(frame: frame)
        setUpDetailView(with: playlist)
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TopDetailView", owner: self, options: nil)
        addSubview(contentView)
    }

    //MARK: - Variable for Stretchy Header Effect
    /// Delegate
    weak var delegate: TopDetailViewDelegate?
    
    /// Public
    let edgeInsets = UIEdgeInsets(top: 270, left: 0, bottom: 0, right: 0)
    
    /// Private
    private let viewHeight: CGFloat = 270
    private var isHiddenTitleNavigation = true
    private let topAlignmentConstraintImageView: CGFloat = 15
    private let screenHeight = UIScreen.main.bounds.size.height
    private let screenWidth = UIScreen.main.bounds.size.width
    private var navigationBarHeight: CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return height
    }
    
    //MARK: - Setup View
    
    private func configView() {
        navigationBarView.setGradientBackground(colorTop: #colorLiteral(red: 0.1450815201, green: 0.1451086104, blue: 0.1450755298, alpha: 1), colorBottom: #colorLiteral(red: 0.09718047827, green: 0.07773689181, blue: 0.07808386534, alpha: 1))
        titleLabel.alpha = 0.0
        detailImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
        }
    }
    
    private func setUpDetailView(with album: Album) {
        configView()
        titleLabel.text = album.name
        detailImageView.sd_setImage(with: URL(string: album.images.first?.url ?? ""), completed: nil)
    }
    
    private func setUpDetailView(with playlist: Playlist) {
        configView()
        titleLabel.text = playlist.name
        detailImageView.sd_setImage(with: URL(string: playlist.images.first?.url ?? ""), completed: nil)
        
    }
    
    //MARK: - For scrollViewDidScroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = viewHeight - (scrollView.contentOffset.y + viewHeight)
        changeAlphaTitle(at: y)
        changePositionImage(at: y)
    }
    
    private func changeAlphaTitle(at yPosition: CGFloat) {
        
        if yPosition >= navigationBarHeight - topAlignmentConstraintImageView {
            if !isHiddenTitleNavigation {
                isHiddenTitleNavigation = true
                UIView.animate(withDuration: 0.1) { self.titleLabel.alpha = 0.0 }
            }
        } else if isHiddenTitleNavigation {
            isHiddenTitleNavigation = false
            UIView.animate(withDuration: 0.1) { self.titleLabel.alpha = 1.0 }
        }
    }
    
    private func changePositionImage(at yPosition: CGFloat) {
        
        let position = min(max(yPosition, navigationBarHeight), screenHeight)
        
        frame = CGRect(x: 0, y: 0, width: screenWidth, height: position)

        if yPosition >= viewHeight {
            detailImageView.transform = CGAffineTransform(scaleX: yPosition / viewHeight, y: yPosition / viewHeight)
            imageTopSpaceConstraint.constant = topAlignmentConstraintImageView
        } else {
            imageTopSpaceConstraint.constant =
                (yPosition - (viewHeight - topAlignmentConstraintImageView)) + ((yPosition - viewHeight) * 0.6)
        }
    }
    
    //MARK: - IBAction
    
    @IBAction private func backButtonClicked(_ sender: UIButton) {
        delegate?.leftBarButtonItemClicked()
    }
    
}
