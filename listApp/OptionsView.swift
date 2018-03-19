//
//  OptionsView.swift
//  listApp
//
//  Created by David Tosh on 4/06/17.
//  Copyright © 2017 Solo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func image() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
       guard let context = UIGraphicsGetCurrentContext()
            else {
                return UIImage()
        }
        
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func imageTwo() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        guard let context = UIGraphicsGetCurrentContext()
            else {
                return UIImage()
        }
        
        layer.render(in: context)
        let imageTwo = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
        return imageTwo!
    }

    
        
}
