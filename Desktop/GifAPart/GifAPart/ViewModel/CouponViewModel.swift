//
//  CouponViewModel.swift
//  GifAPart
//
//  Created by Abdul Diallo on 8/11/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit.UIImage

struct CouponViewModel {
    
    private let coupon : Coupon
    
    var description : String {
        return coupon.description
    }
    
    var provider : String {
        return coupon.display_name.uppercased()
    }
    
    var expiration : String {
        let exp = coupon.exp_date
        let index = exp.index(exp.startIndex, offsetBy: 10)
        return String(exp.prefix(upTo: index))
    }
    
    var thumbnail : URL? {
        guard let url = URL.init(string: coupon.thumbnail) else { return nil }
        return url
    }
    
    var likeImage : UIImage {
        return coupon.isLiked ? #imageLiteral(resourceName: "Icon-Like-On") : #imageLiteral(resourceName: "Icon-Like-Off")
    }
    
    var dislikeImage : UIImage {
        return coupon.isDisiked ? #imageLiteral(resourceName: "Icon-Dislike-On") : #imageLiteral(resourceName: "Icon-Dislike-Off")
    }
    
    var followImage : UIImage {
        return coupon.isFollowed ? #imageLiteral(resourceName: "Icon-Following-On") : #imageLiteral(resourceName: "Icon-Following-Off")
    }
    
    var bookmarkImage : UIImage {
        return coupon.isBookmarked ? #imageLiteral(resourceName: "Icon-Bookmark-On") : #imageLiteral(resourceName: "Icon-Bookmark-Off")
    }
    
    init(coupon: Coupon) {
        self.coupon = coupon
    }
    
}
