//
//  ServerError.swift
//  GifAPart
//
//  Created by Abdul Diallo on 8/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

enum ServerError : Error {
    
    case badURL
    case failureEncoding
    case serverError
    case parsingFailure
    
    var description : String {
        switch self {
        case .badURL:
            return "FAILURE CONSTRUCTING URL FROM THE GIVEN ENDPOINT."
        case .failureEncoding:
            return "FAILURE ENCODING URL REQUEST BODY."
        case .serverError:
            return "FAILURE GETTING RESPONSE FROM THE SERVER."
        case .parsingFailure:
            return "FAILURE PARSING THE DATA."
        }
    }
    
}
