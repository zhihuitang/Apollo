//
//  TimerViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2016-12-28.
//  Copyright © 2016 Zhihui Tang. All rights reserved.
//

import UIKit

class TimerViewController: BaseViewController {

    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonReset: UIButton!
    let timeInterval = 0.1
    
    @IBOutlet weak var timeLabel: UILabel!
    weak var weakSelf: TimerViewController? {
        get {
            return self
        }
    }

    weak var timer = Timer()
    var isPlaying = false
    var counter = 0.0 {
        didSet {
            self.timeLabel.text = String(format: "%02.2f", counter)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //timer.invalidate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func timerStart(_ sender: UIButton) {
        if(isPlaying) {
            return
        }
        buttonStart.isEnabled = false
        buttonPause.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @IBAction func timePause(_ sender: UIButton) {
        
        buttonStart.isEnabled = true
        buttonPause.isEnabled = false
        
        timer?.invalidate()
        isPlaying = false
    }

    @IBAction func timeReset(_ sender: UIButton) {
        buttonStart.isEnabled = true
        buttonPause.isEnabled = false
        
        timer?.invalidate()
        isPlaying = false
        counter = 0.0
    }
    
    
    public func UpdateTimer() {
        weakSelf?.counter = (weakSelf?.counter)! + timeInterval
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

extension TimerViewController {
    override var name: String {
        return "Timer Demo"
    }
}
