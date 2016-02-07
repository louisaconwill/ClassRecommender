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
    
    // Example data--change to actual course list later :)
    let data = ["56b583bac596c22e9c37afd0", "56b583bac596c22e9c37afd1"]
    var currentCourse = 0

    override func viewDidLoad() {
        
      /*  Constants.userRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let firstTime = snapshot.value.objectForKey("firstTime") as? String {
                if firstTime == "1" {
                    self.presentViewController((self.storyboard?.instantiateViewControllerWithIdentifier("gettingstarted"))!, animated: true, completion: nil)
                }
                
            }
            
        })*/
        
        super.viewDidLoad()
        
       getNextView { (view) -> (Void) in
            self.view.addSubview(view)
        }
        

    }
    
    // Sent before a choice is made. Cancel the choice by returning `false`. Otherwise return `true`.
    func view(view: UIView, shouldBeChosenWithDirection: MDCSwipeDirection) -> Bool{
        if (shouldBeChosenWithDirection == MDCSwipeDirection.Left) {
            return true;
        } else {
            // Snap the view back and cancel the choice.
            UIView.animateWithDuration(0.16, animations: { () -> Void in
                view.transform = CGAffineTransformIdentity
                view.center = view.superview!.center
            })
            return false;
        }
    }
    
    // This is called then a user swipes the view fully left or right.
    func view(view: UIView, wasChosenWithDirection: MDCSwipeDirection) -> Void{
        getNextView { (view) -> (Void) in
            self.view.addSubview(view)
        }
        
        if wasChosenWithDirection == MDCSwipeDirection.Left {
            print("Photo deleted!")
        }else{
            print("Photo saved!")
        }
    }
    
    func makeView(course: Course) -> CourseSwipeView {
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "Keep"
        options.likedColor = UIColor.blackColor()
        options.nopeText = "Delete"
        
        let courseswipeview = CourseSwipeView()
        courseswipeview.name.text = course.name
        courseswipeview.title.text = course.title
        courseswipeview.coursedescription.text = course.description
        
        return courseswipeview
        
    }
    
    func getNextView(callback: (CourseSwipeView) -> (Void)) {
        let courseID = data[currentCourse]
        
        
        Constants.coursesRef
            .childByAppendingPath(courseID)
            .observeSingleEventOfType(.Value, withBlock: { snapshot in
                var course = Course()
                let description = snapshot.value.objectForKey("description")
                let name = snapshot.value.objectForKey("name")
                let title = snapshot.value.objectForKey("title")
                
                course.description = description as? String
                course.name = name as? String
                course.title = title as? String
                
                callback(self.makeView(course))
                
        })
        
        currentCourse++
  
}
    
    

}
