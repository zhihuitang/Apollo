//
//  MainViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2016-12-16.
//  Copyright © 2016 Zhihui Tang. All rights reserved.
//

import UIKit
import SwiftMagic

class MainViewController: UITableViewController {

    struct Storyboard {
        static let demo = "demo"
    }
    
    var demos = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        logger.d("device name:\(UIDevice.current.name)")
        self.navigationItem.title = "Apollo project"
        
        loadData()
    }

    private func loadData() {
        demos.append("Core Location Demo")
        demos.append("Round Image View")
        demos.append("Data Collection")
        demos.append("Alamofire")
        demos.append("CustomView")
        demos.append("Calculator")
        demos.append("FaceIt")
        demos.append("Dispatch")
        demos.append("Timer")
        demos.append("LocalNotification")
        demos.append("Sort")
        demos.append("DropIt")
        demos.append("GPXDemo")
        demos.append("MapDemo")
        demos.append("My Profile")
        demos.append("RxSwift Demo")
        demos.append("Microphone Demo")
        demos.append("RotationLabel View")

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return demos.count
    }

    func getDemoViewController(identifier: String) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: Storyboard.demo, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier )
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let demoAlamo = getDemoViewController(identifier: demos[indexPath.row]) as! DemoView
        cell.textLabel!.text = demoAlamo.name
        cell.detailTextLabel!.text = demoAlamo.classIdentity ?? "not defined"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = getDemoViewController(identifier: demos[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
}

extension MainViewController: SessionDelegate {
    
}
