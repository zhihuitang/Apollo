//
//  RotationCell.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-08-01.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import Foundation
import UIKit

let rotationReuseIdentifier = "rotation_cell"

class RotationCell: UICollectionViewCell {
    
    let textLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //textLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        textLabel.frame = self.bounds
    }
}
