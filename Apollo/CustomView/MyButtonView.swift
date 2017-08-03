//
//  MyButtonView.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-08-03.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

class MyButtonView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    @IBAction func buttonClicked(_ sender: Any) {
        print("my button clicked")
    }
    
    private func setupView() {
        let container = Bundle.main.loadNibNamed("MyButton", owner: self, options: nil)?.first as! UIView
        container.frame = bounds
        container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(container)

    }
    
    override func awakeFromNib() {
        print("awakeFromNib")
    }

}
