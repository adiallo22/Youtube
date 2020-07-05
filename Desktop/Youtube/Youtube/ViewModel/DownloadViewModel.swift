//
//  DownloadViewModel.swift
//  Youtube
//
//  Created by Abdul Diallo on 7/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct DownloadService {
    
    static let shared = DownloadService()
    
    func fetchVideos(withInput input: String, andKey key: String, completion: @escaping(NSArray?, Error?) -> Void ) {
        let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(input)&type=video&key=\(key)"
        guard let url = URL.init(string: urlString) else { return }
        let task = URLSession.init(configuration: .default).dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(nil, error)
            } else {
                if let existingdata = data {
                    do {
                        let parse = try JSONSerialization.jsonObject(with: existingdata, options: []) as! [String:Any]
                        let items = parse["items"] as! NSArray
                        completion(items, nil)
                    } catch let error {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
}
