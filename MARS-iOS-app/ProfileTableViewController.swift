//
//  ProfileTableViewController.swift
//  MARS-iOS-app
//
//  Created by William Thornton on 3/23/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit
import Alamofire

class ProfileTableViewController: UITableViewController{
    
    var stuff = [DemoModel]()
    var first = ""
    var last = ""
    var email = ""
    var netId = ""
    var emplyId = ""
    var payRate = "0"
    var job = ""
    var department = ""
    var tit = ""
    var titleCode = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MarsApi.assistant().map { asst in
            self.first = asst.firstName
            self.last = asst.lastName
            self.netId = asst.netId
            self.emplyId = asst.employeeId
            self.payRate = String(asst.rate)
            self.job = asst.job
            self.department = asst.department
            self.tit = asst.title
            self.titleCode = asst.titleCode
            self.email = asst.email

            let picture1 = UIImage(named: "Email")!
            let model1 = DemoModel(titled: self.email, data: "Email", pic: picture1)
            let picture2 = UIImage(named: "Info")!
            let model2 = DemoModel(titled: self.netId, data: "Net Id", pic: picture2)
            let model3 = DemoModel(titled: self.emplyId, data: "Employee Id", pic: picture2)
            let picture4 = UIImage(named: "Pay")!
            let model4 = DemoModel(titled: String(self.payRate), data: "Pay Rate", pic: picture4)
            let picture5 = UIImage(named: "Details")!
            let model5 = DemoModel(titled: self.job, data: "Job", pic: picture5)
            let model6 = DemoModel(titled: self.department, data: "Department", pic: picture5)
            let model7 = DemoModel(titled: self.tit, data: "Title", pic: picture5)
            let model8 = DemoModel(titled: self.titleCode, data: "Title Code", pic: picture5)
            let name = self.first + " " + self.last
            let picture9 = UIImage(named: "User")!
            let model9 = DemoModel(titled: name, data: "Name", pic: picture9)
            self.stuff += [model9, model1, model2, model3, model4, model5, model6, model7, model8]

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.stuff.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Demo Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.stuff[indexPath.row].title
        cell.detailTextLabel?.text = self.stuff[indexPath.row].subtitle
        cell.imageView?.image = self.stuff[indexPath.row].picture
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
 


}
