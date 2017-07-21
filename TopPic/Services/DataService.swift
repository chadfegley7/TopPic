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

let STORAGE_BASE = Storage.storage().reference()



class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = DATA_BASE
    
    private var _REF_POSTS = DATA_BASE.child("posts")
    
    private var _REF_USERS = DATA_BASE.child("users")
    
    private var _REF_IMAGE_STORAGE = STORAGE_BASE.child("post-pics")
    
    var REF_BASE: DatabaseReference {
        
        return _REF_BASE
        
    }
    
    var REF_POSTS: DatabaseReference {
        
        return _REF_POSTS
        
    }
    
    var REF_USERS: DatabaseReference {
        
        return _REF_USERS
        
    }
    
    var REF_IMAGE_STORAGE: StorageReference {
        
        return _REF_IMAGE_STORAGE
        
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
}
