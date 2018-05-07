//
//  ProgressView.swift
//  Go Ask A Duck
//
//  Created by terrence lynch on 8/5/17.
//  Copyright © 2017 terrence lynch. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    //
    // MARK: - Initialization
    //
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.black
        self.alpha = 0.4
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //
    // MARK: - Lifecycle
    //
    
    override func didMoveToSuperview() {
        
        if superview != nil {
            
            print("didMoveToSuperview")
            
            frame = superview!.frame
            
            let square = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            square.backgroundColor = UIColor.gray
            square.layer.cornerRadius = 10
            square.center = (superview?.center)!
            square.isUserInteractionEnabled = true
            square.alpha = 1.0
            self.addSubview(square)
            
            let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            
            activityIndicator.center = CGPoint(x: square.frame.size.width / 2,
                                               y: square.frame.size.height / 2);
            square.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            
        }
    }
    
}














