//
//  FeedVC.swift
//  TopPic
//
//  Created by Chad Fegley on 7/19/17.
//  Copyright © 2017 Chad Fegley. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageAdd: CircleView!
    
    var posts = [Post]()
    
    var imagePicker: UIImagePickerController!
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = true 
        
        imagePicker.delegate = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                
                for snap in snapshot {
                    
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, Any> {
                        
                        let key = snap.key
                        
                        let post = Post(postKey: key, postData: postDict)
                        
                        self.posts.append(post)
                        
                    }
                    
                }
                
            }
            
            self.tableView.reloadData()
            
        })

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell{
            
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                
                cell.configureCell(post: post, img: img)
                
                return cell
                
            } else {
                
                cell.configureCell(post: post, img: nil)
                
                return cell
                
            }
            
        } else {
            
            return PostCell()
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            imageAdd.image = image
            
        } else {
            
            print("EXPOZURE: A valid image was not selected")
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func signOutButtTap(_ sender: Any) {
        
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        
        print("ID removed from Keychain \(keychainResult)")
        
        try! Auth.auth().signOut()
        
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        
        print("ID removed from Keychain \(keychainResult)")
        
        try! Auth.auth().signOut()
        
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
    }
    
    @IBAction func chooseImageTapped(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
}














