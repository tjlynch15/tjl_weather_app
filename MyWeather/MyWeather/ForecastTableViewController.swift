//
//  ForecastTableViewController.swift
//  MyWeather
//
//  Created by terrence lynch on 5/6/18.
//  Copyright © 2018 terrence lynch. All rights reserved.
//

import UIKit

class ForecastTableViewController: UITableViewController {
    
    
    /// The array of dictionaries that will hold all weather
    /// data returned from the network request
    var issues:[String: [String:AnyObject]]?
    
    //var dataDictionary = Dictionary<String, Any>()
    
    var forecastDictionaryArray =  [Dictionary<String, String>]()
    
    var urlString = "https://api.wunderground.com/api/c20aa53f37c0654b/forecast10day/q/IL/Glencoe.json"
    
    //let urlString = "https://api.wunderground.com/api/c20aa53f37c0654b/forecast10day/q/\(LocationViewController.newState)/\(LocationViewController.newCity)"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        print("urlString1: \(urlString)")
        
        SharedNetworking.sharedInstance.showNetworkIndicator()
        
        SharedNetworking.sharedInstance.getIssues(url: urlString) { (issues) in
            
            self.urlString = "https://api.wunderground.com/api/c20aa53f37c0654b/forecast10day/q/\(LocationViewController.newState)/\(LocationViewController.newCity)"
            
            print()
            print("urlString2: \(self.urlString)")
            
            self.createDictionary(issues: issues! as! [String : [String : AnyObject]])
            //print("HI \(String(describing: self.forecastDictionaryArray))")
            
            // The data is available in this closure through the `issues` variable
            
            // Copy the `issues` to a property of the view controller so that it can
            // persist beyond the closure block.  The property should
            // be of the same type as the parameter here (eg [[String: AnyObject]]?)
            
            // Reload the table.  The tables data source should be the property you copied the
            // issues to (above). Remember to refresh the table on the main thread
            
            DispatchQueue.main.async {
                // Anything in here is executed on the main thread
                // You should reload your table here.
                
                self.tableView.reloadData()
            }
        }
        
        // For debugging
        //print(issues as Any)
        
        SharedNetworking.sharedInstance.hideNetworkIndicator()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        return forecastDictionaryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ForecastTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ForecastTableViewCell  else {fatalError("The dequeued cell is not an instance of ForecastTableViewCell")
        }
        
        //print("city: \(LocationViewController.newCity)")
        cell.dayLabel?.text = forecastDictionaryArray[indexPath.row]["day"]
        cell.highLabel?.text = forecastDictionaryArray[indexPath.row]["highTempF"]
        cell.lowLabel?.text = forecastDictionaryArray[indexPath.row]["lowTempF"]
        
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func createDictionary(issues: [String: [String: AnyObject]]) {
        
        let numIssues = issues.count
        print("numIssues: \(numIssues)")
        
        let forecastDay = (issues["forecast"]!["simpleforecast"]!["forecastday"] as! [AnyObject])
        //print("forecastDay: \(forecastDay)")
        print()
        
        forecastDictionaryArray =  [Dictionary<String, String>]()
        
        var day = ""
        var lowTempF = ""
        var highTempF = ""
        
        for index in 0...9 {
            
            let date = forecastDay[index]["date"] as! [String:Any]?
            day = date!["weekday"] as! String
            
            let lowTemp = forecastDay[index]["low"] as! [String:Any]?
            lowTempF = lowTemp!["fahrenheit"] as! String
            
            let highTemp = forecastDay[index]["high"] as! [String:Any]?
            highTempF = highTemp!["fahrenheit"] as! String
            
//            print()
//            print("day: \(index)")
//            print("weekday: \(day )")
//            print("lowTempF: \(lowTempF )")
//            print("highTempF: \(highTempF )")
            
            let dict = ["day":day, "lowTempF":lowTempF, "highTempF":highTempF]
//            print(dict)
            
            forecastDictionaryArray.append(dict)
        }
        
    }
}




