//
//  HomeViewController.swift
//  ClassRecommender
//
//  Created by Louisa Conwill on 2/6/16.
//  Copyright © 2016 Louisa Conwill. All rights reserved.
//

import UIKit
import LFReversibleTinderView

class HomeViewController: UIViewController, MDCSwipeToChooseDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = MDCSwipeToChooseViewOptions()
                 options.delegate = self
                 options.likedText = "Keep"
                 options.likedColor = UIColor.blackColor()
                 options.nopeText = "Delete"
        
                 let mdcview = MDCSwipeToChooseView(frame:self.view.bounds, options: options)
        
                 self.view.addSubview(mdcview) //adds swiping object to view
        
        Constants.userRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let firstTime = snapshot.value.objectForKey("firstTime") as? String {
                if firstTime == "1" {
                    self.presentViewController((self.storyboard?.instantiateViewControllerWithIdentifier("gettingstarted"))!, animated: true, completion: nil)
                }
                
            }
            
        })
    }
}
