//
//  PhotoCell.swift
//  Tumblr
//
//  Created by 陈卓娅 on 1/31/17.
//  Copyright © 2017 Sophia Zhuoya Chen. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = self.avatarView.frame.width/2
        avatarView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        avatarView.layer.borderWidth = 1;
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
