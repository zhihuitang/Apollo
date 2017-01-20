//
//  MainViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2016-12-16.
//  Copyright © 2016 Zhihui Tang. All rights reserved.
//

import UIKit


class MainViewController: UITableViewController {

    struct Storyboard {
        static let demo = "demo"
    }
    
    var demos = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        print("device name:\(UIDevice.current.name)")
        self.navigationItem.title = "Apollo project"
        
        loadData()
    }

    private func loadData() {
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

    func getDemoViewController(identifier: String) -> BaseViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: Storyboard.demo, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier ) as! BaseViewController
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let demoAlamo = getDemoViewController(identifier: demos[indexPath.row])
        cell.textLabel!.text = demoAlamo.name
        cell.detailTextLabel!.text = demoAlamo.className

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = getDemoViewController(identifier: demos[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: SessionDelegate {
    
}
