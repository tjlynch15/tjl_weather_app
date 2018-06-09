//
//  ScrollViewController.swift
//  MyWeather
//
//  Created by terrence lynch on 5/6/18.
//  Copyright © 2018 terrence lynch. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    
    /// Scroll view holding the boxes
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set the scrollview's delegate to this view controller.  For clarity, we
        // will conform to the protocol in an extension
        scrollView.delegate = self as UIScrollViewDelegate
        
        // Make the scrollview easier to see
        scrollView.backgroundColor = .gray
        
        
        // How big is the scrollable content (not the size you
        // see on the screen)
        scrollView.contentSize = CGSize(width: 1000, height: scrollView.frame.height)
        
        // Put a box at the end of the scrollview
        let boxOne = UIView(frame: CGRect(x: 100, y: scrollView.frame.midX,  width: 100, height: 100))
        
        let swiftColor = UIColor(red: 215/255.0, green: 131/255.0, blue: 255/255.0, alpha: 1)
        boxOne.backgroundColor = swiftColor
       
        
        // Add the box to the view...careful of which view you
        // add it to...
        scrollView.addSubview(boxOne)
        
        
        
        // Put a box at the end of the scrollview
        let boxTwo = UIView(frame: CGRect(x: 900,y: 150, width: 50, height: 50))
        boxTwo.backgroundColor = UIColor.green
        
        // Add the box to the view...careful of which view you
        // add it to...
        scrollView.addSubview(boxTwo)
        
        
        
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

    
}



/// Tell ViewController to conform to the `UIScrollViewDelegate` and implement
/// some functions to receive updates on the scrolling status
///
extension MyViewController: UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Scroll view is scrolling: \(scrollView.contentOffset)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Done scrolling")
    }
    
    
}

