//
//  CourseSwipeView.swift
//  ClassRecommender
//
//  Created by Louisa Conwill on 2/7/16.
//  Copyright © 2016 Louisa Conwill. All rights reserved.
//

import UIKit
import LFReversibleTinderView

class CourseSwipeView: UIView {

    
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var coursedescription: UITextView!
    
    init() {
        super.init(frame: CGRectZero)
        NSBundle.mainBundle().loadNibNamed("CourseSwipeView", owner: self, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    
}
