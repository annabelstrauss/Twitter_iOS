//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String?
    var screenName: String?
    var followersCount: Int? //number of people FOLLOWING the current user
    var friendsCount: Int? //number of people that the current user FOLLOWS
    var id: Int64
    var profilePicString: String?
    var profilePicURL: URL?
    var favCount: Int?
    
    // For user persistance
    var dictionary: [String: Any]?
    private static var _current: User?
    
    /*
    * Create a static computed property, current, that updates the stored _current 
    * property as well as saves and retrieves the current user UserDefaults.
    * ==== FOR PERSISTED USER ====
    */
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }//close "current" computed property
    
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        followersCount = dictionary["followers_count"] as? Int
        friendsCount = dictionary["friends_count"] as? Int
        id = dictionary["id"] as! Int64
        profilePicString = dictionary["profile_image_url_https"] as? String
        profilePicURL = URL(string: profilePicString!)
        favCount = dictionary["favourites_count"] as? Int

    }
    
    
    
    
}//close class
