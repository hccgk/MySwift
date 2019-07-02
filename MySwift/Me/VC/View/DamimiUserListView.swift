//
//  DamimiUserListView.swift
//  MySwift
//  用户名,剩余次数
//  Created by hechuan on 2019/7/1.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import Toaster


protocol DamimiuserSelectDelegate {
     func DidselectItem(item:DamimiItem)
}
protocol TaobaouserSelectDelegate {
    func whichWangWang(name:String)
}
extension  DamimiUserListView:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var  cell:UITableViewCell? = nil
        cell = dequeueReusableCell(withIdentifier: "celldamiminame")
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "celldamiminame")
        }
        cell?.textLabel?.text = self.dataArray[indexPath.row]["title"]
        guard let type = self.viewtype else { return cell! }
        if type == "mm"{
            cell?.detailTextLabel?.text = "剩余:" + self.dataArray[indexPath.row]["sub"]! + "次"

        }else{
            cell?.detailTextLabel?.text =  self.dataArray[indexPath.row]["sub"]!

        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let type = self.viewtype else { return  }
        if type == "mm"{
            let item = self.userArray[indexPath.row]
            selectdelegate?.DidselectItem(item: item)
        }else{
            if let tname = self.dataArray[indexPath.row]["title"] {
                tbselectdelegate?.whichWangWang(name: tname)
            }
        }
       
        
        
        
       
    }
    
}


class DamimiUserListView: UITableView {
    
    
    var viewtype:String?
    
    var dataArray = Array<Dictionary<String, String>>()
    var userArray = Array<DamimiItem>()

    var selectdelegate:DamimiuserSelectDelegate?
    var tbselectdelegate: TaobaouserSelectDelegate?
    
    func loadData() {
        //这里没有注册,因为如果注册了,那么就不会走init cell 方法
        //        self.register(UITableViewCell.self, forCellReuseIdentifier: "celldamiminame")
        //读取数据库,然后放入一个dataarray中
        self.dataSource = self
        self.delegate = self
        let realm = try! Realm()
        
            let res = realm.objects(DamimiItem.self)
            for item in res{
                let dict = ["title":item.userName ?? "","sub":item.haveTimes.description ]
                self.dataArray.append(dict)
                self.userArray.append(item)
            }
            self.reloadData()
       
    }
    
    func loadTbData() {
        //这里没有注册,因为如果注册了,那么就不会走init cell 方法
        //        self.register(UITableViewCell.self, forCellReuseIdentifier: "celldamiminame")
        //读取数据库,然后放入一个dataarray中
        self.dataSource = self
        self.delegate = self
        
        let urllogin = URL.init(string: "http://damimi.dianshangbaike.com/NetflowMission/getWwList")!
        let realmw = try! Realm()
        
        let adminusername = UserDefaults.standard.object(forKey: "damimiusernameNow") ?? ""
        let puppies = realmw.objects(RealmTaobaoUserTable.self).filter("howsSearched = '\(adminusername)'")
        
        let queue = DispatchQueue(label: "com.hhh.queue", qos: .default, attributes: .concurrent)
        let mgroup = DispatchGroup.init()
        for item in puppies {
            let name = item.wangwang!
            let dict = ["title":item.wangwang ?? "","sub":item.msg ?? "" ]
            self.dataArray.append(dict)
            
            queue.async(group: mgroup) {
                mgroup.enter()
                Alamofire.request(urllogin, method: .get, parameters: ["wangwang":name], encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
                    switch data.result {
                    case .success(let json ):
                        let modeltaobao = item
                        let dict = json as! Dictionary<String,Any>
                        if let existence = dict["msg"] {
                            let rea = try! Realm()
                            try! rea.write {
                                //对应field的写入
                                modeltaobao.setValue((existence as! String), forKeyPath: "msg")
                            }
                        }
                        
                        mgroup.leave()
                    case .failure(_):
                        let toast = Toast(text: "失败")
                        toast.show()
                    }
                }
            }
           
        }
        mgroup.notify(queue: queue){
            DispatchQueue.main.async(execute: {
                self.reloadData()

            })

        }
       
        

    }
    
}

