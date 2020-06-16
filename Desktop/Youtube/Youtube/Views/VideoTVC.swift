//
//  VideoTVC.swift
//  Youtube
//
//  Created by Abdul Diallo on 6/9/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class VideoTVC: UITableViewCell {

    @IBOutlet weak var imageOfVideo: UIImageView!
    @IBOutlet weak var titleOfVideo: UILabel!
    var id : String!
    
    var video : Video! {
        didSet {
            config()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageOfVideo.layer.cornerRadius = 30
        self.imageOfVideo.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config() {
        guard let image = downloadImageURL(with: video.imageLink) else { return }
        imageOfVideo.image = image
        titleOfVideo.text = video.title
    }
    
    func downloadImageURL(with : String) -> UIImage? {
        if let url = URL.init(string: with) {
            do {
                let data = try Data(contentsOf: url)
                return UIImage.init(data: data)
            } catch let error {
                print(error.localizedDescription)
            }

        }
        return nil
    }

}
