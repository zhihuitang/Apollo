//
//  SortViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-07.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit
import Darwin

let barSize = 50
let barHeight = 100

class SortViewController: BaseViewController {

    @IBOutlet weak var histogramView: HistogramView!
    var sortMethod = BubbleSort()
    
    var data: [Int] = [] {
        didSet {
            updateHistogram()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        data = generate(size: barSize, range: barHeight)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reset(_ sender: UIButton) {
        data = generate(size: barSize, range: barHeight)
    }
    @IBAction func sortButtonTapped(_ sender: UIButton) {
        weak var weakSelf = self
        DispatchQueue.global().async {
            let _ = self.sortMethod.sort(items: self.data) { (index,value) in
                DispatchQueue.main.async {
                    weakSelf?.histogramView.update(index: index, value: value)
                }
            }
        }
    }

    private func updateHistogram() {
        histogramView.rawData = data
    }
    
    private func generate(size length: Int, range: Int) -> [Int] {
        var result: [Int] = []
        for _ in 1..<length {
            result.append(Int(arc4random_uniform(UInt32(range))))
        }
        return result
    }

}

extension SortViewController {
    override var name: String {
        get {
            return "Sort Algorithm"
        }
    }
}
