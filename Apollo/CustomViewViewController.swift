//
//  CustomViewViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2016-12-16.
//  Copyright © 2016 Zhihui Tang. All rights reserved.
//

import UIKit

class CustomViewViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
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
    @IBAction func draw(_ sender: Any) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 80, y: 50))
        path.addLine(to: CGPoint(x: 140, y: 150))
        path.addLine(to: CGPoint(x: 10, y: 150))
        path.close()
        
        //        UIColor.green.setFill()
        //        UIColor.red.setFill()
        path.lineWidth = 3.0
        path.fill()
        path.stroke()

    }

}



extension CustomViewViewController {
    override func getDemoDescription() -> String {
        return "Demo"
    }
    
    override func getDemoName() -> String {
        return "Custom View"
    }
}
