//
//  CourseSwipeView.swift
//  ClassRecommender
//
//  Created by Louisa Conwill on 2/7/16.
//  Copyright © 2016 Louisa Conwill. All rights reserved.
//

import UIKit
import LFReversibleTinderView

class CourseSwipeView: MDCSwipeToChooseView {

    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var coursedescription: UITextView!
    
    class func instantiateFromNib() -> CourseSwipeView {
        return UINib(nibName: "CourseSwipeView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CourseSwipeView
    }
    
    
}
