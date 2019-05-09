//
//  homeModel.swift
//  MySwift
//
//  Created by hechuan on 2019/5/9.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit

class contentModel: NSObject {
    @objc var content:    String?
    @objc var updatetime:    String?
    @objc var hashId:    String?
    @objc var unixtime:    String?
    
}


class homeModel: NSObject {
    @objc var error_code: Int = 0
    @objc var reason:    String?
    @objc var result: Array<[String:Any]>?
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("UndefinedKey \(key) \(value.debugDescription)")

    }
  
}

