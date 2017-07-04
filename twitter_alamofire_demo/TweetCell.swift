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
        if retweetButton.isSelected == false {
            tweet.retweeted = true
            retweetButton.isSelected = tweet.retweeted
            tweet.retweetCount += 1
            retweetCountLabel.text = String(tweet.retweetCount)
        }
        else if retweetButton.isSelected == true {
            tweet.retweeted = false
            retweetButton.isSelected = tweet.retweeted
            tweet.retweetCount -= 1
            retweetCountLabel.text = String(tweet.retweetCount)
        }
    }
    
    
    @IBAction func didTapLike(_ sender: Any) {
        if likeButton.isSelected == false {
            tweet.favorited = true
            likeButton.isSelected = tweet.favorited!
            tweet.favoriteCount += 1
            likeCountLabel.text = String(tweet.favoriteCount)
        }
        else if likeButton.isSelected == true {
            tweet.favorited = false
            likeButton.isSelected = tweet.favorited!
            tweet.favoriteCount -= 1
            likeCountLabel.text = String(tweet.favoriteCount)
        }
    }
    
    
    
    
    
    
    
    
}//close class
