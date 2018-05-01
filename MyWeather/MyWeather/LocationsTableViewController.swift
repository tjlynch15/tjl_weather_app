//
//  LocationsTableViewController.swift
//  MyWeather
//
//  Created by terrence lynch on 1/7/18.
//  Copyright © 2018 terrence lynch. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController {

    /// The array of dictionaries that will hold all weather data
    
    //var cities = [String]()
    var cities = ["Chicago, IL", "San Francisco, CA", "Los Angeles, CA", "Big Sky, MT"]
    
    /// The array of dictionaries that will hold all weather
    /// data returned from the network request
    var issues:[String: [String:AnyObject]]?
    
    var dataDictionary = Dictionary<String, Any>()
    
    //var urlString = ""
    let urlString = "https://api.wunderground.com/api/c20aa53f37c0654b/conditions/q/IL/Chicago.json"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        SharedNetworking.sharedInstance.showNetworkIndicator()
//
//        SharedNetworking.sharedInstance.getIssues(url: urlString) { (issues) in
//
//            self.createDictionary(issues: issues! as! [String : [String : AnyObject]])
//
//
//            // The data is available in this closure through the `issues` variable
//
//            // Copy the `issues` to a property of the view controller so that it can
//            // persist beyond the closure block.  The property should
//            // be of the same type as the parameter here (eg [[String: AnyObject]]?)
//
//            // Reload the table.  The tables data source should be the property you copied the
//            // issues to (above). Remember to refresh the table on the main thread
//
//            DispatchQueue.main.async {
//                // Anything in here is executed on the main thread
//                // You should reload your table here.
//
//                self.tableView.reloadData()
//            }
//
//            // For debugging
//            //print(issues as Any)
//
//            SharedNetworking.sharedInstance.hideNetworkIndicator()
//        }
//
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "CityTableViewCell"
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let city = cities[indexPath.row]
        cell.textLabel?.text = city
        //cell.detailTextLabel?.text = player.game
        return cell
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

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        
        guard let dvc = segue.destination as? WeatherViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedIssueCell = sender as? UITableViewCell else {
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedIssueCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let rowNumber = indexPath.row
        
        // set  variable in the second view controller with the data to pass
//        dvc.passedData1 = dictionaryArray
        dvc.passedData2 = cities[rowNumber]
        
    }
    

    
//    func createDictionary(issues: [String: [String:AnyObject]]) {
//
//        let numIssues = issues.count
//        print("numIssues: \(numIssues)")
//
//        print(issues)
//        print()
//
//        print(issues["current_observation"]!["display_location"]!["city"] as! String)
//
//        var issueDictionary: [String:Any] = [:]
//
//        dictionaryArray = [Dictionary<String, Any>]()
//
//        var city = ""
//        var temp = ""
//
//  //      for index in 0..<numIssues {
//
//            // access all objects in array
//
//            if (issues["current_observation"] != nil) {
//
//                city = (issues["current_observation"]!["display_location"]!["city"] as! String)
//
//                temp = (issues["current_observation"]!["temperature_string"] as! String)
//
//                issueDictionary = ["city":city, "temp":temp]
//
//                dictionaryArray.append(issueDictionary)
//
// //           }
//        }
////        print("LocationsTableViewController")
////        print(dictionaryArray)
////        print("dictionaryArray count: \(dictionaryArray.count)")
//    }
    
    
    
    
}
