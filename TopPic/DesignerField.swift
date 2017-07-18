//
//  DesignerField.swift
//  TopPic
//
//  Created by Chad Fegley on 7/18/17.
//  Copyright © 2017 Chad Fegley. All rights reserved.
//

import UIKit

class DesignerField: UITextField {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.2).cgColor
        
        layer.borderWidth = 1
        
        layer.cornerRadius = 2.0
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.insetBy(dx: 10, dy: 5)
        
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.insetBy(dx: 10, dy: 5)
        
    }

}
