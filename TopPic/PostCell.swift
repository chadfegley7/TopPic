//
//  PostCell.swift
//  TopPic
//
//  Created by Chad Fegley on 7/19/17.
//  Copyright © 2017 Chad Fegley. All rights reserved.
//

import UIKit
import Firebase

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

    func configureCell(post: Post, img: UIImage? = nil) {
        
        self.post = post
        
        self.captionText.text = post.caption
        
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil {
            
            self.imgPost.image = img
            
        } else {
                
            let ref = Storage.storage().reference(forURL: post.imageUrl)
                
            ref.getData(maxSize: 2 * 1024 * 1024, completion: {(data, error) in
                
                if error != nil {
                    
                    print("EXPOZURE: Unable to download image from Firebase storage")
                    
                } else {
                    
                    print("EXPOZURE: Image downloaded from Firebase storage")
                    
                    if let imgData = data {
                        
                        if let img = UIImage(data: imgData) {
                            
                            self.imgPost.image = img
                            
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                            
                        }
                        
                    }
                    
                }
                
            })
            
        }
        
    }
    
    
    
    
    
    
    
    
    
}
