//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by 陈卓娅 on 1/31/17.
//  Copyright © 2017 Sophia Zhuoya Chen. All rights reserved.
//

import UIKit
import AFNetworking


class PhotosViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var feedView: UITableView!
    var posts: [NSDictionary] = []
    var refreshControl : UIRefreshControl!
    //let CellIdentifier = "PhotoCell", HeaderViewIdentifier = "TableViewHeaderView"

    

    override func viewDidLoad() {
        super.viewDidLoad()
        feedView.delegate = self
        feedView.dataSource = self
        feedView.rowHeight = 240
        
        //feedView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        //feedView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotosViewController.onPullRefresh), for: UIControlEvents.valueChanged)
        feedView.insertSubview(refreshControl, at: 0)
        

        // Do any additional setup after loading the view.
        
        
    }
    
    func loadData() {
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        //print("responseDictionary: \(responseDictionary)")
                        
                        // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                        // This is how we get the 'response' field
                        let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                        
                        self.posts = responseFieldDictionary["posts"] as! [NSDictionary]
                        
                        self.feedView.reloadData()
                        
                        
                        // This is where you will store the returned array of posts in your posts property
                        // self.feeds = responseFieldDictionary["posts"] as! [NSDictionary]
                    }
                }
        });
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        
        let post = posts[indexPath.row]
        if let photos = post.value(forKeyPath: "photos") as? [NSDictionary] {
            // photos is NOT nil, go ahead and access element 0 and run the code in the curly braces
            let imageUrlString = photos[0].value(forKeyPath: "original_size.url") as? String
            if let imageUrl = URL(string: imageUrlString!) {
                // URL(string: imageUrlString!) is NOT nil, go ahead and unwrap it and assign it to imageUrl and run the code in the curly braces
                cell.picView.setImageWith(imageUrl)
                let trail = post["trail"] as! NSArray
                let zero  = trail[0] as! NSDictionary
                let blog = zero["blog"] as! NSDictionary
                
                let user = blog["name"]
                cell.userLabel.text = user as? String
                
                let avatar = "https://api.tumblr.com/v2/blog/\(cell.userLabel.text!).tumblr.com/avatar"
                if let avatarUrl = URL(string: avatar) {
                    cell.avatarView.setImageWith(avatarUrl)
                }
                
                
            } else {
                // URL(string: imageUrlString!) is nil. Good thing we didn't try to unwrap it!
                cell.picView.image = nil
            }

        } else {
            // photos is nil. Good thing we didn't try to unwrap it!
            cell.picView.image = nil
            
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        
        // Configure YourCustomCell using the outlets that you've defined.
        
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        feedView.deselectRow(at: indexPath, animated:true)
    }
    
    func onPullRefresh() {
        self.loadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = feedView.indexPath(for: cell)
        let post = posts[indexPath!.row]
        let PhotoDetailsViewController = segue.destination as! PhotoDetailsViewController
        PhotoDetailsViewController.post = post
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
