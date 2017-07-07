//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Annabel Strauss on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

protocol ComposeViewControllerDelegate: class {
    func didPostTweet(post: Tweet)
}

//========== THIS IS TO CONVERT HEX COLORS TO RGB ========== 
extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextView: RSKPlaceholderTextView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var countdownLabel: UILabel!
    
    weak var delegate: ComposeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
        
        //rounded edges for share button
        shareButton.layer.cornerRadius = 8; // this value vary as per your desire
        shareButton.clipsToBounds = true;
        
        let profpicURL = User.current?.profilePicURL
        profilePicImageView.af_setImage(withURL: profpicURL!)
        nameLabel.text = User.current?.name
        usernameLabel.text = User.current?.screenName
        
        //this is for keyboard auto layout
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        //make profile pic circular
        profilePicImageView.layer.cornerRadius = profilePicImageView.frame.size.width / 2;
        profilePicImageView.clipsToBounds = true;
    
        //set color of the share button
        shareButton.backgroundColor = UIColor(hex:0x44A2FF)
    }
    
    //========== COUNTS DOWN CHARACTERS (max 140) ==========
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLength = tweetTextView.text.characters.count + text.characters.count - range.length
        if(newLength <= 140){
            shareButton.backgroundColor = UIColor(hex:0x44A2FF)
            shareButton.isEnabled = true
            self.countdownLabel.text = "\(140 - newLength)"
            return true
        }else{
            shareButton.isEnabled = false
            shareButton.backgroundColor = UIColor(hex:0xB0E2FF)
            return false
        }
    }
    
    //========== FOR KEYBOARD AUTO LAYOUT ==========
    func keyboardWillShow(notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        print(keyboardHeight)
        buttonBottomConstraint.constant = keyboardHeight + 10
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
