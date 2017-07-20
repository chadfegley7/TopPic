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
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: DesignerField!
    
    @IBOutlet weak var passField: DesignerField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            
            performSegue(withIdentifier: "goToFeed", sender: nil)
            
        }
        
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
                
                if let user = user {
                    
                    let userData = ["provider": credential.provider]
                    
                    self.completeSignIn(id: user.uid, userData: userData)
                    
                }
                
            }
            
        }
        
    }

    @IBAction func signInTouched(_ sender: Any) {
        
        if let email = emailField.text, let pwd = passField.text {
            
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                
                if error == nil {
                    
                    print("User authenticated with Firebase");
                    
                    if let user = user {
                        
                        let userData = ["provider": user.providerID]
                        
                        self.completeSignIn(id: user.uid, userData: userData)

                        
                    }
                } else {
                    
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        
                        if error != nil {
                            
                            print("Unable to authenticate with Firebase, try again")
                            
                        } else {
                            
                            print("Successfully created/authenticated user with Firebase")
                            
                            if let user = user {
                                
                                let userData = ["provider": user.providerID]
                                
                                self.completeSignIn(id: user.uid, userData: userData)
                                
                            }
                        }
                        
                    })
                    
                }
                
            })
        
        }
    
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        
        print("User data saved to keychain \(keychainResult)")
        
        performSegue(withIdentifier: "goToFeed", sender: nil)
        
    }

}















