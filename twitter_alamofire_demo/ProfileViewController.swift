//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Annabel Strauss on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import TTTAttributedLabel

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var tweetsTableView: UITableView!
    var user: User!
    var followingCount: Int = 0
    var followersCount: Int = 0
    var userTweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 100
        
        user = User.current!
        nameLabel.text = user.name
        usernameLabel.text = user.screenName
        followingCount = user.friendsCount
        followersCount = user.followersCount
        followingCountLabel.text = String(followingCount)
        followersCountLabel.text = String(followersCount)
        let profpicURL = user.profilePicURL
        profilePicImageView.af_setImage(withURL: profpicURL!)
        
        //make profile pic circular
        profilePicImageView.layer.cornerRadius = profilePicImageView.frame.size.width / 2;
        profilePicImageView.clipsToBounds = true;
        
        fetchUserTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "UserTweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = userTweets[indexPath.row]
        
        return cell
    }
    
    func fetchUserTweets() {
        APIManager.shared.getUserTweets { (tweets, error) in
            if let tweets = tweets {
                self.userTweets = tweets
                self.tweetsTableView.reloadData()
            } else if let error = error {
                print("Error getting user's tweets: " + error.localizedDescription)
            }
        }
        
    }//close fetchTweets
    

    

}//close class
