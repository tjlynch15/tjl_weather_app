//
//  WeatherViewController.swift
//  MyWeather
//
//  Created by terrence lynch on 2/19/18.
//  Copyright © 2018 terrence lynch. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var passedData2: String?
    
    var issues:[String: [String:AnyObject]]?
    var issueDictionary: [String:Any] = [:]
    var locationArray = [String]()
    
    var cityString: String?
    
    
    let button1 = UIButton(type: UIButtonType.system)
    let button2 = UIButton(type: UIButtonType.system)
    let label2 = UILabel()
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var cityImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        print("passedData2: \(String(describing: passedData2))")
        locationArray = passedData2!.components(separatedBy: ", ")
        print(locationArray[0])
        print(locationArray[1])
        locationArray[0] = locationArray[0].replacingOccurrences(of: " ", with: "%20")
        print(locationArray[0])
        
        let urlString = "https://api.wunderground.com/api/c20aa53f37c0654b/conditions/q/\(locationArray[1])/\(locationArray[0]).json"
        print(urlString)
        
        cityString = locationArray[0].replacingOccurrences(of: "%20", with: " ")
        
        cityLabel.text = cityString
        
        if (cityString == "Chicago") {
            cityImage.image = #imageLiteral(resourceName: "chicago")
        }
        else if (cityString == "Big Sky") {
            cityImage.image = #imageLiteral(resourceName: "big_sky")
        }
        else if (cityString == "Los Angeles") {
            cityImage.image = #imageLiteral(resourceName: "los_angeles")
        }
        if (cityString == "San Francisco") {
            cityImage.image = #imageLiteral(resourceName: "san_francisco")
        }
        
        
        
        // Do any additional setup after loading the view.
        
        button1.frame = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 200, height: 200)
        button1.layer.cornerRadius = 0.5 * button1.bounds.size.width
        button1.clipsToBounds = true
        button1.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        //button1.setTitle("Hi", for: .normal)
        button1.setTitleColor(UIColor.white.withAlphaComponent(1.0), for: .normal)
        button1.layer.borderWidth = 2
        button1.layer.borderColor = UIColor.white.cgColor
        button1.center = self.view.center
        
        button1.tag = 1
        //button2.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
        button1.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        button1.isHidden = true
        button1.isEnabled = false
        view.addSubview(button1)
        
    
        button2.frame = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 200, height: 200)
        button2.layer.cornerRadius = 0.5 * button2.bounds.size.width
        button2.clipsToBounds = true
        button2.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        button2.setTitleColor(UIColor.white.withAlphaComponent(1.0), for: .normal)
        button2.layer.borderWidth = 2
        button2.layer.borderColor = UIColor.white.cgColor
        button2.center = self.view.center
        
        button2.tag = 2
        //button2.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
        button2.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        button2.isHidden = false
        button2.isEnabled = true
        view.addSubview(button2)
        
        
//        label2.frame = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 100, height: 100)
//        label2.center = self.button1.center
//        label2.textAlignment = .center
//        label2.text = "Temp"
//        label2.backgroundColor = UIColor.clear
//        label2.textColor = UIColor.white
//        view.addSubview(label2)
        
        
        
        
        
        
        SharedNetworking.sharedInstance.showNetworkIndicator()
        
        SharedNetworking.sharedInstance.getIssues(url: urlString) { (issues) in
            
            self.createDictionary(issues: issues! as! [String : [String : AnyObject]])
            print("HI \(self.issueDictionary)")
            
            // The data is available in this closure through the `issues` variable
            
            // Copy the `issues` to a property of the view controller so that it can
            // persist beyond the closure block.  The property should
            // be of the same type as the parameter here (eg [[String: AnyObject]]?)
            
            // Reload the table.  The tables data source should be the property you copied the
            // issues to (above). Remember to refresh the table on the main thread
            
            DispatchQueue.main.async {
                // Anything in here is executed on the main thread
                // You should reload your table here.
                
                //self.iconLabel.text = self.issueDictionary["icon"] as? String
                
                self.button2.setTitle(self.issueDictionary["temp"] as? String, for: .normal)
                
                self.downloadImage(iconPath: self.issueDictionary["icon_url"] as! String) { (thumbImage) in
                    self.iconImage.image = thumbImage
                }
            }
            
            // For debugging
            //print(issues as Any)
            
            SharedNetworking.sharedInstance.hideNetworkIndicator()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @objc func buttonTapped(sender: UIButton!) {
        
        let buttonIndex = sender.tag
        
        if (buttonIndex == 1) {
            print("button \(buttonIndex)")
            self.flip1()
        }
        else if (buttonIndex == 2) {
            print("button \(buttonIndex)")
            self.flip2()
        }
        else{
            print("Error")
        }
    }
    
    
    @objc func flip1() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]

        UIView.transition(with: button1, duration: 1.0, options: transitionOptions, animations: {
            self.button1.isHidden = true
            self.button1.isEnabled = false
           
            
        })

        UIView.transition(with: button2, duration: 1.0, options: transitionOptions, animations: {
            self.button2.isHidden = false
            self.button2.isEnabled = true
            
            self.button2.setTitle(self.issueDictionary["temp"] as? String, for: .normal)
            print(self.button2.titleLabel?.text ?? "0")
            
        })
    }
  
    
    @objc func flip2() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: button2, duration: 1.0, options: transitionOptions, animations: {
            self.button2.isHidden = true
            self.button2.isEnabled = false
            
        })
        
        UIView.transition(with: button1, duration: 1.0, options: transitionOptions, animations: {
            self.button1.isHidden = false
            self.button1.isEnabled = true
            
            self.button1.setTitle(self.issueDictionary["weather"] as? String, for: .normal)
            self.button1.titleLabel?.font = UIFont.init(name: "Helvetica", size: 20.0)
            //self.button1.setTitle(self.issueDictionary["icon"] as? String, for: .normal)
            print(self.button1.titleLabel?.text ?? "0")
            
        })
    }
    
    
    
    func createDictionary(issues: [String: [String:AnyObject]]) {
        
        let numIssues = issues.count
        print("numIssues: \(numIssues)")
        
        //print(issues)
        
        print()
        print(issues["current_observation"]!["display_location"]!["city"] as! String)
        print(issues["current_observation"]!["icon"] as! String)
        print(issues["current_observation"]!["icon_url"] as! String)
        print(issues["current_observation"]!["weather"] as! String)
        
        issueDictionary = [String:Any]()
        
        var city = ""
        var temp = ""
        var icon = ""
        var icon_url = ""
        var weather = ""
        
        if (issues["current_observation"] != nil) {
            
            city = (issues["current_observation"]!["display_location"]!["city"] as! String)
            temp = (issues["current_observation"]!["temperature_string"] as! String)
            icon = (issues["current_observation"]!["icon"] as! String)
            icon_url = (issues["current_observation"]!["icon_url"] as! String)
            weather = (issues["current_observation"]!["weather"] as! String)
            
            //icon_url = "http://icons.wxug.com/i/c/i/" + icon + ".gif"
            //print(icon_url)
            
            issueDictionary = ["city":city, "temp":temp, "icon":icon, "icon_url":icon_url, "weather":weather]
            
        }
        //        print("LocationsTableViewController")
        //        print(issueDictionary)
        //        print("issueDictionary count: \(issueDictionary.count)")
        //        print("issueDictionary city: \(issueDictionary["city"] ?? "null")")
        //        print("issueDictionary temp: \(issueDictionary["temp"] ?? "null")")
        
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
