//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by 陈卓娅 on 2/8/17.
//  Copyright © 2017 Sophia Zhuoya Chen. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var picView: UIImageView!
    var post: NSDictionary!

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let photos = post["photos"] as? [NSDictionary] {
            let imageUrlString = photos[0].value(forKeyPath: "original_size.url") as? String
            if let imageUrl = URL(string: imageUrlString!) {
                picView.setImageWith(imageUrl)
            }
        }
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return picView    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
