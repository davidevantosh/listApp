//
//  CircleView.swift
//  listApp
//
//  Created by David Tosh on 30/12/16.
//  Copyright © 2016 Solo. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    var loadTheme: Bool = {
        Style.loadTheme()
        Style.switchTheme()
        return true
    }()
 
    override func layoutSubviews() {
        
        Style.loadTheme()
        
        layer.cornerRadius = self.frame.width / 2
        layer.borderWidth = 0.5
        layer.borderColor = Style.roundImageColor.cgColor
            clipsToBounds = true

        }
}
