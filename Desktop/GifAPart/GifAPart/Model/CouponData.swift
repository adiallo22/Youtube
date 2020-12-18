//
//  ToBeParsed.swift
//  GifAPart
//
//  Created by Abdul Diallo on 8/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct Coups : Codable {
    
    struct Deal : Codable {
        var description : String
        var exp_date : String
        var deal_id : Double
        
        struct Retailer : Codable {
            var display_name : String
            struct Thumbnail : Codable {
                var display_picture_thumbnail_url : String
                var display_picture_profile_image : String
            }
            var retailer_display_picture : Thumbnail
        }
        
        var retailer : Retailer
        
    }
    
    var deals:[Deal]
    
}
