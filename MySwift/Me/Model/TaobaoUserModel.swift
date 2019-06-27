//
//  TaobaoUserModel.swift
//  MySwift
//
//  Created by hechuan on 2019/6/26.
//  Copyright © 2019 hechuan. All rights reserved.
//

import Foundation
import RealmSwift

class RealmTaobaoUserTable: Object , Codable{
    override class func primaryKey() -> String? {
        return "wangwang"
    }
    @objc dynamic var wangwang : String?
    @objc dynamic var wangwangId  = 0
    @objc dynamic var avatar : String?
    @objc dynamic var msg : String?
    @objc dynamic var id  = 0
    @objc dynamic var buyerGoodNum = 0 //buyerTotalNum -  buyerGoodNum 中差评个数
    @objc dynamic var buyerLevel  = 0
    @objc dynamic var buyerScore  = 0
    @objc dynamic var buyerTotalNum  = 0
    @objc dynamic var city : String?
    @objc dynamic var createTs  = 0
    @objc dynamic var createTsStr : String?
    @objc dynamic var finishTs  = 0
    @objc dynamic var finishTsStr : String?
    @objc dynamic var gender : String?
    @objc dynamic var identity  = 0
    @objc dynamic var location : String?
    @objc dynamic var pcFinishTs  = 0
    @objc dynamic var pcPullTs  = 0
    @objc dynamic var pcRetryTime  = 0
    @objc dynamic var pullTs  = 0
    @objc dynamic var pullTsStr : String?
    @objc dynamic var realName : String?
    @objc dynamic var realNameStatus  = 0
    @objc dynamic var receivedRate : String?
    @objc dynamic var retryTime  = 0
    @objc dynamic var searchCount  = 0
    @objc dynamic var sellerGoodNum  = 0
    @objc dynamic var sellerLevel  = 0
    @objc dynamic var sellerScore  = 0
    @objc dynamic var sellerTotalNum  = 0
    @objc dynamic var sentRate : String?
    @objc dynamic var status  = 0
    @objc dynamic var statusStr : String?
    @objc dynamic var tag : String?
    @objc dynamic var tagCat : String?
    @objc dynamic var taoling : String?
    @objc dynamic var tblevel  = 0
    @objc dynamic var type : String?
    @objc dynamic var userId  = 0
    @objc dynamic var vipInfo : String?
    @objc dynamic var vipInfoLevel  = 0
    @objc dynamic var vipLevel  = 0
    @objc dynamic var weekCreditAverage : String?
    @objc dynamic var wwCreated  = 0
    @objc dynamic var wwcreatedStr : String?
    
  
   
}

