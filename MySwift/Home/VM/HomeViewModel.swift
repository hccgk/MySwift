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
    var viewmodel : homeModel?
    let baseurl  = "http://api.avatardata.cn/"
    let avidaKey = "6e279196f942470c91f90b1debb55e5e"

    ///获取笑话信息
    ///http://api.avatardata.cn/Joke/QueryJokeByTime
    ///实例"http://api.avatardata.cn/Joke/QueryJokeByTime?key=6e279196f942470c91f90b1debb55e5e&page=2&rows=10&sort=desc&time=1418745237"

    func requestJoker(size:NSInteger,number:NSInteger) {
        
        //key  pags row sort time
        
        let reurl = baseurl + "Joke/QueryJokeByTime?sort=desc&key=\(avidaKey)&page=\(number)&rows=\(size)&time=\(Date.init().timeStamp)"
        var request = URLRequest(url: URL(string: reurl)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                let dict = json as! Dictionary<String,Any>
                let hm = homeModel(dict: dict)
                self.viewmodel = hm
                break
            case .failure(_):
                break
            
            }
        }
    }

  

 
    
    
    
}
