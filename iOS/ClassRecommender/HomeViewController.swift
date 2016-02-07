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
        displayNextView()
        

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
        displayNextView()
        
        if wasChosenWithDirection == MDCSwipeDirection.Left {
            print("Photo deleted!")
        }else{
            print("Photo saved!")
        }
    }
    
    func makeView(course: Course) -> CourseSwipeView {
        
        let options = MDCSwipeOptions()
        options.delegate = self
        
        let courseswipeview = CourseSwipeView.instantiateFromNib()
        courseswipeview.name.text = course.name
        courseswipeview.title.text = course.title
        courseswipeview.coursedescription.text = course.description
        courseswipeview.mdc_swipeToChooseSetup(options)
        
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
        
        currentCourse += 1
    }
    
    func displayNextView() {
        getNextView { (view) -> (Void) in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0.0))
            self.view.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
            self.view.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0))
            self.view.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 0.0))
            
        }
        
    }
    
    

}
