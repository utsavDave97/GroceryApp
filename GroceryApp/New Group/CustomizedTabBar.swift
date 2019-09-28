//
//  CustomizedTabBar.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-27.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit
@IBDesignable
class CustomizedTabBar: UITabBar
{
    private var shapeLayer: CALayer?

    //Only override draw() if you perform custom drawing.
    //An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect)
    {
        self.createShape()
    }
    
    private func createShape()
    {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createCurvedPath()
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        if let oldShape = self.shapeLayer
        {
            self.layer.replaceSublayer(oldShape, with: shapeLayer)
        }
        else
        {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    func createCurvedPath() -> CGPath
    {
        let height: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        //Start top left
        path.move(to: CGPoint(x: 0, y: 0))
        
        //The beginning of the trough
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0))
        
        //First curve down
        path.addCurve(to: CGPoint(x: centerWidth, y: height), controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height))
        
        //Second curve up
        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0), controlPoint1: CGPoint(x: centerWidth + 35, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
        
        //Complete the rect
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }

}
