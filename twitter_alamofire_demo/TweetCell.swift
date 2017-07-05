//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet.user.name
            usernameLabel.text = tweet.user.screenName
            dateLabel.text = tweet.createdAtString
            let profpicURL = tweet.user.profilePicURL
            profilePicImageView.af_setImage(withURL: profpicURL!)
            
            retweetButton.isSelected = tweet.retweeted
            likeButton.isSelected = tweet.favorited!
            
            retweetCountLabel.text = String(tweet.retweetCount)
            likeCountLabel.text = String(tweet.favoriteCount)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func didTapReply(_ sender: Any) {
    }
    
    
    @IBAction func didTapRetweet(_ sender: Any) {
        
        //Retweets the tweet
        if retweetButton.isSelected == false {
            tweet.retweeted = true
            retweetButton.isSelected = tweet.retweeted
            tweet.retweetCount += 1
            retweetCountLabel.text = String(tweet.retweetCount)
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }//close if
            
        //Un-retweets the tweet
        else if retweetButton.isSelected == true {
            tweet.retweeted = false
            retweetButton.isSelected = tweet.retweeted
            tweet.retweetCount -= 1
            retweetCountLabel.text = String(tweet.retweetCount)
        }//close else if
    }
    
    
    @IBAction func didTapLike(_ sender: Any) {
        
        //Adds a like
        if likeButton.isSelected == false {
            tweet.favorited = true
            likeButton.isSelected = tweet.favorited!
            tweet.favoriteCount += 1
            likeCountLabel.text = String(tweet.favoriteCount)
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }//close if
         
        //Removes a like
        else if likeButton.isSelected == true {
            tweet.favorited = false
            likeButton.isSelected = tweet.favorited!
            tweet.favoriteCount -= 1
            likeCountLabel.text = String(tweet.favoriteCount)
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error un-favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully un-favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }//close else if
        
    }//close didTapLike
    
    
    
    
    
    
    
    
    
}//close class
