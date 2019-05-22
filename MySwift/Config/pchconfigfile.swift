//
//  pchconfigfile.swift
//  MySwift
//
//  Created by 何川 on 2019/3/29.
//  Copyright © 2019 hechuan. All rights reserved.
//

//import Foundation
import UIKit
//屏幕宽高
let appWidth = UIScreen.main.bounds.width
let appHeight =  UIScreen.main.bounds.height
//状态栏高度
let statusBarHeight = UIApplication.shared.statusBarFrame.height;
//导航栏高度
let appnavHeight = (statusBarHeight + 44.0)
//tabbar高度
let apptabBarHeight : CGFloat = (statusBarHeight == 44.0 ? 83.0 : 49.0)

//底部的安全距离
let appbottomSafeAreaHeight = (apptabBarHeight - 49.0)


