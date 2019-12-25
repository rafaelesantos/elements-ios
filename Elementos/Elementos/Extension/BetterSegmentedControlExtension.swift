//
//  BetterSegmentedControlExtension.swift
//  AAACOMP
//
//  Created by Rafael Escaleira on 23/10/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import BetterSegmentedControl

extension BetterSegmentedControl {
    
    func setSegmentedControl(titles: [String], selectedBG: UIColor) {
        
        self.segments = LabelSegment.segments(withTitles: titles, normalBackgroundColor: .secondarySystemBackground, normalFont: UIFont(name: "Avenir-Black", size: 17)!, normalTextColor: .label, selectedBackgroundColor: selectedBG, selectedFont: UIFont(name: "Avenir-Black", size: 17)!, selectedTextColor: UIColor(named: "elements"))
        self.cornerRadius = 22.5
    }
}
