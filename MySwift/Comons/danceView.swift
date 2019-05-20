//
//  danceView.swift
//  MySwift
//
//  Created by hechuan on 2019/5/17.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit
import CoreGraphics

class danceView: UIView {
    private let circleL = CAShapeLayer.init()
    private let circleM = CAShapeLayer.init()
    private let circleR = CAShapeLayer.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private func setupUI(){
        //默认是半透明色
        self.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        //根据组件的大小平均分配3个小圆球,让小圆球进行上下跳动   绿 蓝 黄 40 30 -40- 30 -40- 30 40 r为15
        //设定最小值,如果小于这个值用最小值 或者不初始化时候用这个值.写个固定的吧!
        //TODO: - 动态计算大小
        if frame == CGRect.zero
        {
            //do add circle
            addCircle()
        }else{
            //do add circle
            addCircle()
        }
        addAnimation()
        
    }
    
    private func addCircle(){
        frame = CGRect.init(x: 0, y: 0, width: 250, height: 100)

        
        circleL.fillColor = UIColor.green.cgColor
        self.layer .addSublayer(circleL)
        let pathLC = UIBezierPath.init(arcCenter: CGPoint.init(x: 55, y: 50), radius: 15, startAngle: 0, endAngle: CGFloat( Double.pi*2.0), clockwise: true)
        circleL.path = pathLC.cgPath
        
        
        circleM.fillColor = UIColor.blue.cgColor
        self.layer .addSublayer(circleM)
        let pathMC = UIBezierPath.init(arcCenter: CGPoint.init(x: 55 + 70, y: 50), radius: 15, startAngle: 0, endAngle: CGFloat( Double.pi*2.0), clockwise: true)
        circleM.path = pathMC.cgPath

        
        circleR.fillColor = UIColor.yellow.cgColor
        self.layer .addSublayer(circleR)
        let pathRC = UIBezierPath.init(arcCenter: CGPoint.init(x: 55 + 70*2, y: 50), radius: 15, startAngle: 0, endAngle: CGFloat( Double.pi*2.0), clockwise: true)
        circleR.path = pathRC.cgPath
        
        
    }
    
    private func addAnimation(){

        let  value1 = NSValue.init(cgPoint: CGPoint.init(x: 0, y: CGFloat( circleL.position.y - 30.0)))
        let  value3 = NSValue.init(cgPoint: CGPoint.init(x: 0, y: CGFloat( circleL.position.y + 30.0)))

        let animation2 = CAKeyframeAnimation.init(keyPath: "position")
        let animation3 = CAKeyframeAnimation.init(keyPath: "position")

        animation2.values = [value1,value3]
        animation3.values = [value3,value1]

        animation2.duration = 0.4
        animation2.repeatCount = MAXFLOAT
        animation2.autoreverses = true
        animation2.fillMode = .forwards
        animation2.timingFunctions = [CAMediaTimingFunction(name: .easeInEaseOut)]

        animation3.duration = 0.4
        animation3.repeatCount = MAXFLOAT
        animation3.autoreverses = true
        animation3.fillMode = .forwards
        animation3.timingFunctions = [CAMediaTimingFunction(name: .easeInEaseOut)]

        circleL.add(animation2, forKey: "position")
        circleM.add(animation3, forKey: "position")
        circleR.add(animation2, forKey: "position")


    }

}
