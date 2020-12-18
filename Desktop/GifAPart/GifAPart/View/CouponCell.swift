//
//  CouponCell.swift
//  GifAPart
//
//  Created by Abdul Diallo on 8/11/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SDWebImage

private let padding = CGFloat(10)

protocol ButtonActionDelegate : class {
    func likePressed(_ cell: CouponCell)
    func dislikePressed(_ cell: CouponCell)
    func followPressed(_ cell: CouponCell)
    func bookmarkPressed(_ cell: CouponCell)
}

class CouponCell : UITableViewCell {
    
    //MARK: - properties
    
    private var dashedLine : UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleView : UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: 0.00, green: 0.30, blue: 0.81, alpha: 1.00)
        view.dimension(height: 50)
        return view
    }()
    
    private let provider : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()
    
    private let descriptionCoupon : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
        view.dimension(height: 40)
        return view
    }()
    
    private var providerLogo : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .orange
        return view
    }()
    
    private var followLabel : UILabel = {
        let label = UILabel()
        label.text = "Follow"
        label.font = UIFont.systemFont(ofSize: 7)
        label.textColor = .gray
        return label
    }()
    
    private var bookmarkLabel : UILabel = {
        let label = UILabel()
        label.text = "Bookmark"
        label.font = UIFont.systemFont(ofSize: 7)
        label.textColor = .gray
        return label
    }()
    
    var coupon : Coupon? {
        didSet {
            configCoupon()
        }
    }
    
    weak var delegate : ButtonActionDelegate?
    
    //MARK: - bottom action buttons properties
    
    var likeButton : UIButton = {
        let button = UIButton()
        return button
    }()
    var dislikeButton : UIButton = {
        let button = UIButton()
        return button
    }()
    var followButton : UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    var bookmarkButton : UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    var moreDetailsButton : UIButton = {
        let button = UIButton()
        button.setTitle("More", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    var expiresLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 8)
        return label
    }()
    
    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        configButtonStackViews()
        addTargetToButtons()
        roundEdges()
        print(contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers and configuration

extension CouponCell {
    
    fileprivate func configUI() {
        addSubview(titleView)
        titleView.anchor(top:topAnchor, left: leftAnchor, right: rightAnchor,
                         paddingTop: padding,
                         paddingLeft: padding*2,
                         paddingBottom: padding,
                         paddingRight: padding*2)
        //anchor titleview
        titleView.addSubview(provider)
        provider.centerX(inView: titleView)
        provider.centerY(inView: titleView)
        //anchor logo
        titleView.addSubview(providerLogo)
        providerLogo.anchor(left: titleView.leftAnchor,
                            paddingLeft: padding)
        providerLogo.dimension(height: 35, width: 35)
        providerLogo.centerY(inView: titleView)
        //anchor dashedLine
        addSubview(dashedLine)
        dashedLine.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: bottomAnchor,
                          right: rightAnchor,
                          paddingTop: padding,
                          paddingLeft: padding*2,
                          paddingBottom: padding)
        let height = contentView.layer.frame.height * 3
        dashedLine.addLineDashedStroke(width: UIApplication.shared.windows.first!.layer.frame.width - 40,
                                       height: CGFloat(height),
                                       pattern: [4,4], borderWidth: 2)
        //anchor bottomview
        addSubview(bottomView)
        bottomView.anchor(left: leftAnchor,
                          bottom: bottomAnchor,
                          right: rightAnchor,
                          paddingLeft: padding*2,
                          paddingBottom: padding,
                          paddingRight: padding*2)
        //anchor description coupon
        addSubview(descriptionCoupon)
        descriptionCoupon.anchor(top: titleView.bottomAnchor,
                                 left: leftAnchor,
                                 bottom: bottomView.topAnchor,
                                 right: rightAnchor,
                                 paddingTop: padding,
                                 paddingLeft: padding*3,
                                 paddingBottom: padding,
                                 paddingRight: padding*3)
    }
    
    fileprivate func configButtonStackViews() {
        let followStack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [followLabel, followButton])
            stack.axis = .vertical
            stack.spacing = 1
            stack.alignment = .center
            return stack
        }()
        //
        let bookmarkStack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [bookmarkLabel, bookmarkButton])
            stack.axis = .vertical
            stack.spacing = 1
            stack.alignment = .center
            return stack
        }()
        //
        let stack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [bookmarkStack, moreDetailsButton, expiresLabel, followStack, likeButton, dislikeButton])
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .fillEqually
            return stack
        }()
        bottomView.addSubview(stack)
        stack.dimension(height: 25)
        stack.centerY(inView: bottomView)
        stack.anchor(left: bottomView.leftAnchor,
                     right: bottomView.rightAnchor,
                     paddingRight: 5)
    }
    
    fileprivate func configCoupon() {
        guard let coupon = coupon else { return }
        let viewModel = CouponViewModel(coupon: coupon)
        provider.text = viewModel.provider
        descriptionCoupon.text = viewModel.description
        expiresLabel.text = "Expires \(viewModel.expiration)"
        providerLogo.sd_setImage(with: viewModel.thumbnail, completed: nil)
        //set images on buttons
        likeButton.setImage(viewModel.likeImage, for: .normal)
        dislikeButton.setImage(viewModel.dislikeImage, for: .normal)
        followButton.setImage(viewModel.followImage, for: .normal)
        bookmarkButton.setImage(viewModel.bookmarkImage, for: .normal)
    }
    
    fileprivate func addTargetToButtons() {
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(dislikeButtonPressed), for: .touchUpInside)
        followButton.addTarget(self, action: #selector(followButtonPressed), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonPressed), for: .touchUpInside)
    }
    
    fileprivate func roundEdges() {
        //bottom
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 10
        bottomView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //top
        titleView.clipsToBounds = true
        titleView.layer.cornerRadius = 10
        titleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}

//MARK: - selectors

extension CouponCell {
    
    @objc func likeButtonPressed() {
        delegate?.likePressed(self)
    }
    
    @objc func dislikeButtonPressed() {
        delegate?.dislikePressed(self)
    }
    
    @objc func followButtonPressed() {
        delegate?.followPressed(self)
    }
    
    @objc func bookmarkButtonPressed() {
        delegate?.bookmarkPressed(self)
    }
    
}
