//
//  DamimiUserModel.swift
//  MySwift
/*
 count = 0;
 errorCode = 0;
 isOk = 1;
 msg = "";
 needWarnLogin = 0;
 ok = 1;
 pn = 0;
 pnCount = 0;
 ps = 0;
 res =     {
 created = 1561104407759;
 expiredAt = 1561190807759;
 id = 03b254d41a4868f6aac3c84026f712d323ca6f0249c64a06aea3566fd4bd3e8b;
 idString = 03b254d41a4868f6aac3c84026f712d323ca6f0249c64a06aea3566fd4bd3e8b;
 ip = "<null>";
 src = "<null>";
 ucOutScript = "<null>";
 ucSyncLoginScript = "<null>";
 updated = 0;
 userId = 7435692;
 userName = "<null>";
 };
 */
//  Created by hechuan on 2019/6/21.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit
import RealmSwift

class DamimiUserModel: NSObject {
    
    @objc  var isOK = 0
    @objc  var ok = 0
    @objc  var errorCode = 0
    @objc  var res: DamimiUser?
    
    convenience init(dict:[String:Any]) {
        self.init()
        setValuesForKeys(dict)
        
    }

    public override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("UndefinedKey \(key) \(value.debugDescription)")
    }
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "res" {
            let dict = value as! Dictionary<String, Any>
            let model = DamimiUser(dict: dict)
            res = model
            return
        }
        super.setValue(value, forKey: key)
    }
}

class DamimiUser: NSObject {
    @objc  var created = 0
    @objc  var expiredAt = 0
    @objc  var userId = 0
    @objc  var idString:String?

    
    convenience init(dict:[String:Any]) {
        self.init()
        setValuesForKeys(dict)
        
    }
    public override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("UndefinedKey \(key) \(value.debugDescription)")
    }
    
}

class DamimiItem: Object {
    @objc dynamic var created  = 0
    @objc dynamic var expiredAt = 0
    @objc dynamic var userId = 0
    @objc dynamic var idhexString: String?
    
}
