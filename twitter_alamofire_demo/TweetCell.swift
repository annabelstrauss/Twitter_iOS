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
            print(tweet.id)
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
            
//            favorite(tweet, completion: { (tweet: Tweet?, error: Error?) in
//                if let error = error{
//                    print("there was an error")
//                }
//            })
        }
        else if likeButton.isSelected == true {
            tweet.favorited = false
            likeButton.isSelected = tweet.favorited!
            tweet.favoriteCount -= 1
            likeCountLabel.text = String(tweet.favoriteCount)
        }
    }
    
//    func favorite(_ tweet: Tweet, completion: @escaping (Tweet?, Error?) -> ()) {
//        let urlString = "https://api.twitter.com/1.1/favorites/create.json"
//        let parameters = ["id": tweet.id]
//        request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
//            if response.result.isSuccess,
//                let tweetDictionary = response.result.value as? [String: Any] {
//                let tweet = Tweet(dictionary: tweetDictionary)
//                completion(tweet, nil)
//            } else {
//                completion(nil, response.result.error)
//            }
//        }
//    }
    
    
    
    
    
    
    
}//close class
