//
//  DealService.swift
//  GifAPart
//
//  Created by Abdul Diallo on 8/11/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct DealService {
    
    static let shared = DealService()
    
    func fetchDeals(withEndpoint endpoint: String, completion: @escaping(Result<[Coupon], ServerError>) -> Void) {
        
        guard let url = URL.init(string: endpoint) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.serverError))
            } else {
                if let data = data {
                    guard let coupons = self.parseJSON(withData: data) else { return }
                    DispatchQueue.main.async {
                        completion(.success(coupons))
                    }
                }
            }
        }.resume()
        
    }
    
    func actionOnDeal(type: ActionType, of: String, completion: @escaping(Result<Any, ServerError>)->Void) {
        guard let url = URL.init(string: of) else {
            completion(.failure(.badURL))
            return
        }
        var request = URLRequest.init(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var params : [String:Bool] = [:]
        switch type {
        case .like:
            params = ["liked":true]
        case .dislike:
            params = ["disliked":true]
        case .follow:
            params = ["followed":true]
        case .bookmark:
            params = ["bookmarked":true]
        }
        guard let body = try? JSONEncoder().encode(params) else {
            completion(.failure(.failureEncoding))
            return
        }
        request.httpBody = body
        URLSession.shared.dataTask(with: request, completionHandler: { (data, resp, err) in
            if err != nil {
                completion(.failure(.serverError))
            } else {
                DispatchQueue.main.async {
                    completion(.success(data!))
                }
            }
        }).resume()
    }
    
}

//MARK: - parser.

extension DealService {
    
    func parseJSON(withData data: Data) -> [Coupon]? {
        var coupons : [Coupon] = []
        do {
            guard let dataDecoded = try? JSONDecoder().decode(Coups.self, from: data) else { return nil }
            for deal in dataDecoded.deals {
                print(deal.deal_id)
                let description = deal.description
                let exp_date = deal.exp_date
                let retailer = deal.retailer.display_name
                let deal_id = deal.deal_id
                let thumbnail = deal.retailer.retailer_display_picture.display_picture_profile_image
                let coupon = Coupon.init(description: description,
                                         exp_date: exp_date,
                                         display_name: retailer,
                                         deal_id: deal_id,
                                         thumbnail: thumbnail)
                coupons.append(coupon)
            }
        }
        return coupons
    }
    
}
