//
//  HomeModel.swift
//  MySwift
//
//  Created by hechuan on 2019/5/16.
//  Copyright © 2019 hechuan. All rights reserved.


import UIKit

public class MContentModel: NSObject {
    @objc var content:    String?
    @objc var updatetime:    String?
    @objc var hashId:    String?
    @objc var unixtime:    String?
    
   convenience init(dict:[String:Any]) {
        self.init()
        setValuesForKeys(dict)
        
    }
    public override init() {
        super.init()
    }
    
    public override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("UndefinedKey \(key) \(value.debugDescription)")
    }
}


class HomeModel: NSObject {
    @objc var error_code: Int = 0
    @objc var reason:    String?
    @objc var result: Array<MContentModel>?
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "result" {
            var mutarr = [MContentModel]()
            if let arrdict = value as? Array<[String:Any]> {
                for dict in arrdict {
                    let contentmodel = MContentModel(dict: dict)
                    mutarr.append(contentmodel)
                }
            }
            result = mutarr
            return
        }
        super.setValue(value, forKey: key)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("UndefinedKey \(key) \(value.debugDescription)")
        
    }
    
}

