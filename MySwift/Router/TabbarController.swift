//
//  TabbarController.swift
//  MySwift
//
//  Created by 何川 on 2019/3/29.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.black
        tabBar.barTintColor = UIColor.white
        self.addController(childVC: HomeViewController(), childTitle: "首页", imageName: "tabbar_1", selectImageName: "tabbar_select_1")

        self.addController(childVC: CenterLeftViewController(), childTitle: "视频", imageName: "tabbar_2", selectImageName: "tabbar_select_2")

        self.addController(childVC: CenterRightViewController(), childTitle: "关于", imageName: "tabbar_3", selectImageName: "tabbar_select_3")

        self.addController(childVC: MeViewController(), childTitle: "我的", imageName: "tabbar_4", selectImageName: "tabbar_select_4")
        
    }
    
    private func addController(childVC:UIViewController,childTitle:String,imageName:String,selectImageName:String){
        let navcontroller = UINavigationController(rootViewController: childVC)
        navcontroller.navigationBar.tintColor = UIColor.black //字体颜色
        navcontroller.navigationBar.barTintColor = UIColor.white //背景颜色
        let attDict:NSDictionary = [NSAttributedString.Key.foregroundColor:UIColor.black,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 17)]
        navcontroller.navigationBar.titleTextAttributes = attDict as? [NSAttributedString.Key : Any]
        childVC.title = childTitle
        childVC.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        self.addChildViewController(navcontroller)
        
        
    }

  
}
