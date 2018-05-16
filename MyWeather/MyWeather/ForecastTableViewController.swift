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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        self.refreshControl?.addTarget(self, action: #selector(ForecastTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        print("urlString1: \(urlString)")
        
        self.urlString = "https://api.wunderground.com/api/c20aa53f37c0654b/forecast10day/q/\(LocationViewController.newState)/\(LocationViewController.newCity).json"
        
        print()
        print("urlString2: \(self.urlString)")
        
        SharedNetworking.sharedInstance.showNetworkIndicator()
        
        SharedNetworking.sharedInstance.getIssues(url: urlString) { (issues) in
            
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
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        print("handleRefresh")
        print(urlString)
        
        
        SharedNetworking.sharedInstance.showNetworkIndicator()
        
        SharedNetworking.sharedInstance.getIssues(url: urlString) { (issues) in
            
            self.urlString = "https://api.wunderground.com/api/c20aa53f37c0654b/forecast10day/q/\(LocationViewController.newState)/\(LocationViewController.newCity).json"
            
            print()
            print("urlString3: \(self.urlString)")
            
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
                refreshControl.endRefreshing()
                
            }
            SharedNetworking.sharedInstance.hideNetworkIndicator()
        }
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
        
        
        downloadImage(iconPath: (forecastDictionaryArray[indexPath.row]["iconURL"])!) { (thumbImage) in
            cell.iconImageView.image = thumbImage
        }
        
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
        
        //print(issues)
        
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
            
            let iconURL = forecastDay[index]["icon_url"] as! String
            
            
//            print()
//            print("day: \(index)")
//            print("weekday: \(day )")
//            print("lowTempF: \(lowTempF )")
//            print("highTempF: \(highTempF )")
//            print("iconURL: \(iconURL)")
            
            
            let dict = ["day":day, "lowTempF":lowTempF, "highTempF":highTempF, "iconURL":iconURL]
            
            
            forecastDictionaryArray.append(dict)
        }
        //print(forecastDictionaryArray)
        
    }
    
    // Attribution: - https://stackoverflow.com/questions/39813497/swift-3-display-image-from-url
    
    func downloadImage(iconPath: String, completion: @escaping (UIImage) -> Void) {
        
        var image = UIImage()
        
        
        var url = iconPath
        if (!url.contains("https")) {
            url.insert("s", at: url.index(url.startIndex, offsetBy: 4))
        }
        let newIconPath = url
        print(newIconPath)
        
        let iconURL = URL(string: newIconPath)
        print("icon url: \(String(describing: iconURL))")
        
        
        // Creating a session object with the default configuration.
        let session = URLSession(configuration: .default)
        
        
        // Define a download task. The download task will download the contents of the URL as a Data object.
        let downloadPicTask = session.dataTask(with: iconURL!) { (data, response, error) in
            // The download has finished.
            if let e = error {
                
                self.connectionFailed()
                
                print("Error downloading picture: \(e)")
                
            } else {
                
                if let res = response as? HTTPURLResponse {
                    print("Downloaded picture with response code \(res.statusCode)")
                    if let imageData = data {
                        
                        // convert data into an image
                        image = UIImage(data: imageData)!
                        
                        DispatchQueue.main.async {
                            completion(image)
                        }
                    }
                    else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code")
                }
            }
        }
        
        downloadPicTask.resume()
    }
    
    func connectionFailed(){
        
        let alert:UIAlertController = UIAlertController(title: "Error", message: "Connection Failed", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}




