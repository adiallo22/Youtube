//
//  ViewController.swift
//  Youtube
//
//  Created by Abdul Diallo on 6/9/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Firebase

protocol VideoInfo {
    func passVideoInfo(id: String?)
}

class ViewController: UIViewController {
    
    let customAnimator = CustomAnimate()
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchtf: UITextField!
    
    var videos = [Video]() {
        didSet {
            self.table.reloadData()
        }
    }
    
    var videoDelegate : VideoInfo!

    let key = "AIzaSyC3qzdL9eay1rGH6ap9P7jzGRzLpmno4Vo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.rowHeight = 301
        
    }
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("error signing you out")
        }
    }
    
    @IBAction func searchClicked(_ sender: UIButton) {
        let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(searchtf.text!)&type=video&key=\(String(describing: key))"
        guard let url = URL.init(string: urlString) else { return }
        let task = URLSession.init(configuration: .default).dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let existingdata = data {
                    do {
                        let parse = try JSONSerialization.jsonObject(with: existingdata, options: []) as! [String:Any]
                        let items = parse["items"] as! NSArray
                        for item in items {
                            let vid = item as! [String:Any]
                            //retrieve videoID
                            let id = vid["id"] as! [String:Any]
                            let videoID = id["videoId"] as! String
                            //retrieve title
                            let snippet = vid["snippet"] as! [String:Any]
                            let title = snippet["title"] as! String
                            //retrieve image url
                            let thumbnails = snippet["thumbnails"] as! [String:Any]
                            let def = thumbnails["medium"] as! [String:Any]
                            let imageURL = def["url"] as! String
                            //create a video and append
                            DispatchQueue.main.async {
                                let video = Video(title: title, id: videoID, imageLink: imageURL)
                                self.videos.insert(video, at: 0)
                                //self.table.reloadData()
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
    
}


//MARK: - tableview delegate and data source


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.videoCell) as! VideoTVC
        cell.video = videos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //videoDelegate.passVideoInfo(id: videos[indexPath.row].id)
        performSegue(withIdentifier: Constants.toVideo, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! WatchVideoVC
        guard let path = table.indexPathForSelectedRow?.row else { return }
        destVC.id = videos[path].id
        destVC.videoTitle = videos[path].title
        destVC.transitioningDelegate = self
    }
    
}

//MARK: - transition

extension ViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimator
    }
    
}
