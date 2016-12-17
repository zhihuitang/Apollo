//
//  BaseViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2016-12-16.
//  Copyright © 2016 Zhihui Tang. All rights reserved.
//

import UIKit

var instanceCount = 0

class BaseViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instanceCount = instanceCount + 1
    }
    
    deinit {
        instanceCount = instanceCount - 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.name
        // Do any additional setup after loading the view.
        print("\(self.className) count: \(instanceCount)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


protocol DemoView {
    var name: String { get }
}


extension BaseViewController: DemoView {
    internal var name: String {
        get {
            return "Base"
        }
        
    }
}
