//
//  SignInVC.swift
//  TopPic
//
//  Created by Chad Fegley on 7/16/17.
//  Copyright © 2017 Chad Fegley. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookButtTapped(_ sender: Any) {
        
        let loginManager = LoginManager()
        
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
                
            case .failed(let error):
                
                print(error)
                
            case .cancelled:
                
                print("User cancelled login.")
                
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                
                self.firebaseAuth(credential)
                
            }
            
        }
        
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if (error != nil) {
                
                print("Unable to sign in with Firebase")
                
            } else {
                
                print("Sucessful sign in with Firebase")
                
            }
            
        }
        
    }

}

