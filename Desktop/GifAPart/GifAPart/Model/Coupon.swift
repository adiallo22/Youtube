//
//  Coupon.swift
//  GifAPart
//
//  Created by Abdul Diallo on 8/11/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct Coupon : Codable {
    
    var description : String
    var exp_date : String
    var display_name : String
    var deal_id : Double
    var thumbnail : String
    var isLiked : Bool = false
    var isDisiked : Bool = false
    var isBookmarked : Bool = false
    var isFollowed : Bool = false
    
}

//MARK: - ActionType

enum ActionType {
    
    case like
    case dislike
    case follow
    case bookmark
    
}
