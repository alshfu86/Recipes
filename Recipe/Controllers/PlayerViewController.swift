//
//  PlayerViewController.swift
//
//  Created by alsh on 10.10.17.
//  Copyright © 2017 wsoft. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import FirebaseDatabase
import JSSAlertView


class PlayerViewController: UIViewController,YTPlayerViewDelegate{

    //Outlets
   
   
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var aboutTextView: UITextView!
    
    //Variables
    var about = ""
    var categoryIndex  = ""
    var recipeIndex  = ""
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    var urlPath = ""
    @IBOutlet weak var player: YTPlayerView!
    
    
    @IBOutlet weak var removeButton: UIButton!
    
    

    override func viewDidLoad() {
        aboutTextView.layer.cornerRadius=8.0
        aboutTextView.layer.borderWidth=1.0
        super.viewDidLoad()
        activityIndicator.startAnimating()
        player.delegate = self
        player.load(withVideoId: urlPath)
        aboutTextView.text = about
        self.perform(#selector(PlayerViewController.scrollToTop), with: nil, afterDelay: 0.5)


        NotificationCenter.default.addObserver(self, selector: #selector(PlayerViewController.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        //buttomPaneHeightCostraits.constant = UIScreen.main.bounds.height / 2.0
    }
    
    
    
    @objc func orientationChanged(){
        //buttomPaneHeightCostraits.constant = UIScreen.main.bounds.height / 2.0
        self.view.layoutIfNeeded()
    }
    
    
    
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        activityIndicator.stopAnimating()
    }
    
    @IBAction func backButtomDidTap(_ sender: UIButton) {
        back()
    }
    
    
    @objc func scrollToTop(){
        aboutTextView.setContentOffset(CGPoint.zero, animated: true)
    
    }
    
    
    func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    @IBAction func removeButton(_ sender: UIButton) {
        let alertview = JSSAlertView().show(self,title: "REDERA",text: "Är Du säkert att du vill radera Recip",buttonText: "OK",cancelButtonText: "Cancel" )
        alertview.addAction(myCallback)

    }

    func myCallback() {
        let ref = Database.database().reference().child("data").child(categoryIndex).child("category").child(recipeIndex)
        ref.removeValue()
        back()
    }
    func myCancelCallback() {
        // this'll run if cancel is pressed after the alert is dismissed
    }
    

    
}
