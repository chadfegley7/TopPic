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

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func signOutTapped(_ sender: Any) {
        
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        
        print("ID removed from Keychain \(keychainResult)")
        
        try! Auth.auth().signOut()
        
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
    }
    
}
