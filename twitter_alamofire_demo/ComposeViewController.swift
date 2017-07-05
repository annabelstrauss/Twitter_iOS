//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Annabel Strauss on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: class {
    func didPostTweet(post: Tweet)
}

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    
    weak var delegate: ComposeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        tweetTextView.becomeFirstResponder()
        
        let profpicURL = User.current?.profilePicURL
        profilePicImageView.af_setImage(withURL: profpicURL!)
        nameLabel.text = User.current?.name
        usernameLabel.text = User.current?.screenName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapPost(_ sender: Any) {
        let tweetText = tweetTextView.text
        
        APIManager.shared.composeTweet(with: tweetText!) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.didPostTweet(post: tweet)
                print("Compose Tweet Success!")
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }//close didTapPost
    


}
