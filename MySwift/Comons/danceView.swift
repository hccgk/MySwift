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
    private let circleL = CALayer.init()
    private let circleM = CALayer.init()
    private let circleR = CALayer.init()
    
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
        
        
    }
    
    private func addCircle(){
        frame = CGRect.init(x: 0, y: 0, width: 160, height: 100)
//        circleL.bounds
    }

}
