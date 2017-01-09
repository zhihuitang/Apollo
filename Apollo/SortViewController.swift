//
//  SortViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-07.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit
import Darwin


class SortViewController: BaseViewController, SortView, UITextFieldDelegate {

    @IBOutlet weak var textFieldSize: UITextField!
    @IBOutlet weak var histogramView: HistogramView!
    var sortMethod: SortMethod = BubbleSort()
    weak var weakSelf: SortViewController?
    var histogrameSize: Int? {
        didSet{
            self.histogramView.barCount = histogrameSize!
        }
    }
    let barHeight = 100
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        weakSelf = self
    }
    
    @IBOutlet weak var textCount: UITextField!
    
    var data: [Int] = [] {
        didSet {
            updateHistogram()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldSize.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldSize.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reset(_ sender: UIButton) {
        if let number = Int(textCount.text!) {
            histogrameSize = number
        }
    }
    @IBAction func sortButtonTapped(_ sender: UIButton) {
        DispatchQueue.global().async {
            let _ = self.sortMethod.sort(items: self.histogramView.rawData, sortView: self)
        }
    }
    
    func barUpdated(index: Int, value: Int) {
        DispatchQueue.main.async {
            self.histogramView?.update(index: index, value: value)
        }
    }
    func sortFinish(result: Array<Int>) {
        DispatchQueue.main.async {
            self.data = result
        }
        print("sort finish")
    }
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        print("tapped: \(sender.titleForSegment(at: sender.selectedSegmentIndex)!)")
        if let type = sender.titleForSegment(at: sender.selectedSegmentIndex), let sortType = SortTypeEnum(rawValue: type) {
            
            sortMethod = SortFactory.create(type: sortType)
        }
    }

    private func updateHistogram() {
        histogramView.rawData = data
    }

}

extension SortViewController {
    override var name: String {
        get {
            return "Sort Algorithm"
        }
    }
}
