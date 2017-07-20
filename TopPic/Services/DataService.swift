//
//  DataService.swift
//  TopPic
//
//  Created by Chad Fegley on 7/20/17.
//  Copyright © 2017 Chad Fegley. All rights reserved.
//

import Foundation
import Firebase

let DATA_BASE =  Database.database().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = DATA_BASE
    
    private var _REF_POSTS = DATA_BASE.child("posts")
    
    private var _REF_USERS = DATA_BASE.child("users")
    
    var REF_BASE: DatabaseReference {
        
        return _REF_BASE
        
    }
    
    var REF_POSTS: DatabaseReference {
        
        return _REF_POSTS
        
    }
    
    var REF_USERS: DatabaseReference {
        
        return _REF_USERS
        
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
}
