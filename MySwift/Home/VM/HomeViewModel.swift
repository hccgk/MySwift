//
//  HomeViewModel.swift
//  MySwift
//
//  Created by hechuan on 2019/5/9.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit
import Alamofire


class HomeViewModel: NSObject {
    var  baseurl  = "http://api.avatardata.cn/"
    let avidaKey = "6e279196f942470c91f90b1debb55e5e"
    

    func requestJoker(size:NSInteger,number:NSInteger) {// -> [homeModel]
        let testurlstring = "http://api.avatardata.cn/Joke/QueryJokeByTime?key=6e279196f942470c91f90b1debb55e5e&page=2&rows=10&sort=asc&time=1418745237"

        var request = URLRequest(url: URL(string: testurlstring)!)
//        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(request).responseJSON { (response) in
            print("response:" + response.description)
            
            switch response.result {
            case .success(let json):
                let dict = json as! Dictionary<String,Any>
                let hm = homeModel(dict: dict)
                print("response:\(dict) \(hm.result?.count)" )
                break
            case .failure(_):
                break
            default:
                break
            }
        }
    }

    ///获取笑话信息
    ///http://api.avatardata.cn/Joke/QueryJokeByTime

 
    
    
    
}
