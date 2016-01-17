//
//  LoginViewController.swift
//  tsker
//
//  Created by Radu Lemnaru on 12/06/14.
//  Copyright (c) 2014 Radu Lemnaru. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBLoginViewDelegate {
    
    var fbLoginView:FBLoginView!
    var tskerLabel: UILabel!
    
    var profilePictureView:FBProfilePictureView!
    var nameLabel: UILabel!
    var statusLabel: UILabel!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hanlde UI Label
        
        self.tskerLabel = UILabel(frame: CGRectMake(100, 50, 100, 20))
        self.tskerLabel.text = "TSKER"
        self.tskerLabel.font = UIFont(name: "AvenirNext-Regular", size: 20)
        
        
        // Handle Facebook Login View
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.fbLoginView = FBLoginView(frame: CGRectMake(50, 200, 70, 100))
        self.fbLoginView.delegate = self
        
        // Handle View submission
        self.view.addSubview(self.fbLoginView)
        self.view.addSubview(self.tskerLabel)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func loginViewFetchedUserInfo(loginView: FBLoginView!, user:FBGraphUser!) -> Void{
//        self.profilePictureView.profileID = user.objectID;
//        self.nameLabel.text = user.name;
//    }
//    
//    func loginViewShowingLoggedInUser(loginView: FBLoginView!) -> Void {
//        self.statusLabel.text = "You're logged in as";
//    }

//    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) -> Void {
//        self.profilePictureView.profileID = nil;
//        self.nameLabel.text = "";
//        self.statusLabel.text = "You're not logged in!";
//    }
    
        /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
