//
//  PromoFeauture.swift
//  GifAPart
//
//  Created by Abdul Diallo on 8/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

private let padding = CGFloat(10)

class PromoFeauture : UIView {
    
    //MARK: - properties
    
    private var promoView : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        return view
    }()
    
    private var couponAndDealsFrame : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0xF0EF94)
        return view
    }()
    
    private var logoImage : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "Giftapart logo®")
        view.contentMode = .scaleAspectFill
        view.dimension(height: 32, width: 32)
        return view
    }()
    
    private var dashedFrame : UIView = {
        let view = UIView()
        return view
    }()
    
    private var couponTitle : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0xEE2F4D)
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "COUPONS & DEALS"
        return label
    }()
    
    //MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers and configurations

extension PromoFeauture {
    
    fileprivate func configUI() {
        //anchor promoview
        addSubview(promoView)
        promoView.anchor(top: topAnchor,
                         left: leftAnchor,
                         right: rightAnchor,
                         paddingLeft: padding*2,
                         paddingBottom: padding,
                         paddingRight: padding*2)
        let height = (Double(UIApplication.shared.windows.first!.layer.frame.height) * 0.54) - Double(110 + padding*10)
        promoView.addLineDashedStroke(width: UIApplication.shared.windows.first!.layer.frame.width - (padding*4),
                                      height: CGFloat(height),
                                      pattern: [4,4], borderWidth: 2)
        //anchor couponAndDealsFrame
        addSubview(couponAndDealsFrame)
        couponAndDealsFrame.anchor(top: promoView.bottomAnchor,
                                   left: leftAnchor,
                                   bottom: bottomAnchor,
                                   right: rightAnchor,
                                   paddingTop: padding)
        couponAndDealsFrame.dimension(height: 110)
        //
        couponAndDealsFrame.addSubview(dashedFrame)
        dashedFrame.anchor(top: couponAndDealsFrame.topAnchor,
                           left: couponAndDealsFrame.leftAnchor,
                           bottom: couponAndDealsFrame.bottomAnchor,
                           right: couponAndDealsFrame.rightAnchor,
                           paddingTop: padding*2,
                           paddingLeft: padding*2,
                           paddingBottom: padding*2,
                           paddingRight: padding*2)
        dashedFrame.addLineDashedStroke(width: UIApplication.shared.windows.first!.layer.frame.width - (padding*4),
                                        height: 70,
                                        pattern: [10,6], borderWidth: 4)
        //
        let stack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [logoImage, couponTitle])
            stack.axis = .horizontal
            stack.alignment = .center
            stack.spacing = 15
            return stack
        }()
        couponAndDealsFrame.addSubview(stack)
        stack.centerY(inView: couponAndDealsFrame)
        stack.centerX(inView: couponAndDealsFrame)
    }
    
}
