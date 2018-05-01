//
//  CircleView.swift
//  Git Hub Issues
//
//  Created by terrence lynch on 7/22/17.
//  Copyright © 2017 terrence lynch. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        drawRing(size: 2.5, color: UIColor.green, fillColor: UIColor.clear)
        drawRing(size: 3.0, color: UIColor.red, fillColor: UIColor.clear)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.setNeedsDisplay()
//    }
//
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.layoutSubviews()
//        self.setNeedsDisplay()
//    }
    
    // Attribution: https://stackoverflow.com/questions/29616992/how-do-i-draw-a-circle-in-ios-swift
    
    internal func drawRing(size: CGFloat, color: UIColor, fillColor: UIColor)->()
    {
        let halfSize:CGFloat = min(bounds.size.width/size, bounds.size.height/size)
        let desiredLineWidth:CGFloat = 5    // your desired value
        
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: CGFloat(halfSize - (desiredLineWidth/2)),
                          startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        circlePath.lineWidth = desiredLineWidth
        fillColor.setFill()
        color.setStroke()
        circlePath.stroke()
        circlePath.fill()
        
    }
}







