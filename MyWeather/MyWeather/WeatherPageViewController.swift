//
//  WeatherPageViewController.swift
//  MyWeather
//
//  Created by terrence lynch on 5/6/18.
//  Copyright © 2018 terrence lynch. All rights reserved.
//

import UIKit

class WeatherPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var viewControllerList: [UIViewController] = {
        
        //let sb = storyboard
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "Location View Controller")
        let vc2 = sb.instantiateViewController(withIdentifier: "Forecast Table View Controller")
        
        return [vc1, vc2]
    } ()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.dataSource = self
        
        if let firstViewController = viewControllerList.first {
            
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
    }
    
   
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard nextIndex >= 0 else {return nil}
        
        guard viewControllerList.count > nextIndex else {return nil}
        
        return viewControllerList[nextIndex]
        
    }

//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//         return viewControllerList.count
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
    
}
