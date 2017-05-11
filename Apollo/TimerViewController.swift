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
    let TOKEN_REFRESH_PERIOD:Double = 30
    let key = "timer_count"

    var scheduledTimer: Timer?
    
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
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var btnScheduledTimer: UIButton!
    
    @IBAction func btnScheduledTimerClicked(_ sender: Any) {
        
        let userDefault = UserDefaults.standard
        userDefault.set(0, forKey: key)

        btnScheduledTimer.setTitle(Date().description, for: .normal)
        scheduledTimer?.invalidate()
        scheduledTimer = Timer.scheduledTimer(timeInterval: TOKEN_REFRESH_PERIOD,
                                     target: self,
                                     selector: #selector(self.refreshToken),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func refreshToken() {
        let now = Date()
        let userDefault = UserDefaults.standard
        var count = 1
        if let value = userDefault.value(forKey: key) as? Int {
            count = value + 1
        }
        userDefault.set(count, forKey: key)
        
        let text = "[\(count)]updated at \(now.description)"
        labelTimer.text = text
        print("Timer.scheduledTimer test: \(text)")
    }

}

extension TimerViewController {
    override var name: String {
        return "Timer Demo"
    }
}
