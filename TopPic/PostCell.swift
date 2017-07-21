//
//  PostCell.swift
//  TopPic
//
//  Created by Chad Fegley on 7/19/17.
//  Copyright © 2017 Chad Fegley. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var imgPost: UIImageView!
    
    @IBOutlet weak var captionText: UITextView!
    
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(post: Post) {
        
        self.post = post
        
        self.captionText.text = post.caption
        
        self.likesLbl.text = "\(post.likes)"
        
    }
    
    
    
    
    
    
    
    
    
}
