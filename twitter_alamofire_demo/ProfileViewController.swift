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
    @IBOutlet weak var backgroundPicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var tweetsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var user: User!
    var followingCount: Int = 0
    var followersCount: Int = 0
    var userTweets: [Tweet] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user == nil {
            user = User.current
        }
        
        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        tweetsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 100
        
        nameLabel.text = user.name
        usernameLabel.text = user.screenName
        followingCount = user.friendsCount
        followersCount = user.followersCount
        followingCountLabel.text = String(followingCount)
        followersCountLabel.text = String(followersCount)
        let profpicURL = user.profilePicURL
        profilePicImageView.af_setImage(withURL: profpicURL!)
        let backgroundPicURL = user.backgroundPicURL
        backgroundPicImageView.af_setImage(withURL: backgroundPicURL!)
        
        //make profile pic circular
        profilePicImageView.layer.cornerRadius = profilePicImageView.frame.size.width / 2;
        profilePicImageView.clipsToBounds = true;
        
        // Initialize a UIRefreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tweetsTableView.insertSubview(refreshControl, at: 0)
        
        activityIndicator.startAnimating() //starts the spinny wheel in center of screen
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tweetsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func fetchUserTweets() {
        APIManager.shared.getUserTweets(user!) { (tweets, error) in
            if let tweets = tweets {
                self.userTweets = tweets
                self.tweetsTableView.reloadData()
            } else if let error = error {
                print("Error getting user's tweets: " + error.localizedDescription)
            }
        }
        
        // Tell the refreshControl to stop spinning
        self.refreshControl.endRefreshing()
        //Tell the activityIndicator to stop spinning
        self.activityIndicator.stopAnimating()
        
    }//close fetchTweets
    
    //===============PULL TO REFRESH===============
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        activityIndicator.startAnimating() //starts the spinny wheel in center of screen
        fetchUserTweets()
    }
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    

}//close class
