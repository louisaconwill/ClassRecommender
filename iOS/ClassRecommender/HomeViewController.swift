//
//  HomeViewController.swift
//  ClassRecommender
//
//  Created by Louisa Conwill on 2/6/16.
//  Copyright © 2016 Louisa Conwill. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Constants.userRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let firstTime = snapshot.value.objectForKey("firstTime") as? String {
                if firstTime == "1" {
                    self.presentViewController((self.storyboard?.instantiateViewControllerWithIdentifier("gettingstarted"))!, animated: true, completion: nil)
                }
                
            }
            
        })
    }
}
