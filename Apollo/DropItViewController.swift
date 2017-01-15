//
//  DropItViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-15.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

class DropItViewController: BaseViewController {
    @IBOutlet weak var gameView: DropItView! {
        didSet {
            
            gameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addDrop(recognizer:))))
        }
    }
    
    func addDrop(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            gameView.addDrop()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gameView.animating = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameView.animating = false
    }

}

extension DropItViewController {
    override var name: String {
        return "DropIt"
    }
}
