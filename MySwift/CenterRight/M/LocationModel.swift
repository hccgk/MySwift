//
//  LocationModel.swift
//  MySwift
//
//  Created by hechuan on 2019/5/22.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit
import RealmSwift

class LocationModel: Object {
    @objc dynamic var speed = 0.00
    @objc  dynamic var longitude = 0.00 //经度
    @objc dynamic var latitude = 0.00 //维度
    @objc dynamic var timestamp = Date() //时间
    
//    override init() {
//        super.init()
//    }
}

