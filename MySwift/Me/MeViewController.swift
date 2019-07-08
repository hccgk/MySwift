//
//  MeViewController.swift
//  MySwift
//
//  Created by 何川 on 2019/3/29.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import Toaster
import Foundation

let  MeconntrolleCellInd =  "MeconntrolleCell"

class MeViewController: UIViewController {
    
    private var dataArray = NSMutableArray()
    private lazy var tableview:UITableView = {
     let vie = UITableView.init(frame: CGRect.init(x: 0, y: appnavHeight + 15, width: appWidth, height: appHeight -  appnavHeight - apptabBarHeight - 15), style: .grouped)
        vie.register(UITableViewCell.self, forCellReuseIdentifier: MeconntrolleCellInd)

     return vie
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    

    func setupUI() {
        self.view.backgroundColor = self.tableview.backgroundColor
        self.view.addSubview(self.tableview)
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
    func setupData() {
        
        self.dataArray = ["大咪咪查号"]
        self.tableview.reloadData()
    }
   
    

}

extension MeViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MeconntrolleCellInd)
        cell?.textLabel?.text = self.dataArray[indexPath.row] as? String
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionWithIndex(index:indexPath.row)
    }
}

extension MeViewController {
    func actionWithIndex(index:Int) {
        switch index {
        case 0:
            turnto()

//            lookId()
//        case 1:
//            lookaround()
//        case 2:
//            turnto()
        default:
          print(index.description)
            
        }
    }
    func turnto(){
        let vc = TaobaoUserVC()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func  lookaround(){
        let urllogin = URL.init(string: "http://damimi.dianshangbaike.com/NetflowMission/getWwList")!
        let realmw = try! Realm()
        let puppies = realmw.objects(RealmTaobaoUserTable.self)
//        realmw.beginWrite()
        for item in puppies {
            let name = item.wangwang!
            DispatchQueue(label: "background").async {
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

                        
                    case .failure(_):
                        let toast = Toast(text: "失败")
                        toast.show()
                    }
                }
            }
        }
       
        
    }
    func lookId(){
        //从系统剪切板进行查找,如果没有发出一个提示
        /// 调试阶段直接查hccgk
        let urllogin = URL.init(string: "http://damimi.dianshangbaike.com/GongjuUI/publishTXMWWRateInfo")!
        Alamofire.request(urllogin, method: .post, parameters: ["wangwang":"ldh7799","isCanUsePoint":"false"], encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
            switch data.result {
            case .success(let json ):
                
                let dict = json as! Dictionary<String,Any>
                
                print(dict)
                let toast = Toast(text: "剩余查询次数\(String(describing: dict["count"]))")
                toast.show()
                
                self.lookDetailArray()
                
            case .failure(_):
                let toast = Toast(text: "失败")
                toast.show()
            }
        }
    
    }
    func lookDetailArray(){

        
        let urllogin = URL.init(string: "http://damimi.dianshangbaike.com/Gongjuui/getAllTXMWWRateInfo")!
        let timeNow = NSDate.init()
        Alamofire.request(urllogin, method: .post, parameters: ["wangwang":"","status":"0","startDate":"1560960000000","endDate":Int(timeNow.timeIntervalSince1970*1000).description,"pn":"1","ps":"20"], encoding: URLEncoding.default, headers:nil).responseJSON { (data) in
//            5741
//            5000
            switch data.result{
            case .success(let json):
                let resdict = json as! Dictionary<String,Any>
                print(resdict)
                let object = resdict["res"]
                let arrdict = object as? Array<Any>
                for item in arrdict ?? [] {
                    let jdata = try? JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                    let jsonDecoder = JSONDecoder()
//                    let modelObject = try? jsonDecoder.decode(TaobaoUserModel.self, from: jdata ?? Data.init())
                    let modelObject = try? jsonDecoder.decode(RealmTaobaoUserTable.self, from: jdata ?? Data.init())
//                    self.userarrays?.append(modelObject!)
                    let realm = try! Realm()
                    

                    try! realm.write {
                        realm.add(modelObject!, update: true)
                    }
                }
            case .failure(_):
                let toast = Toast(text: "fail")
                toast.show()
            }
            
            
        }
    }
   
}
//MARK: - 当前支持的接口
//http://damimi.dianshangbaike.com/NetflowMission/getWxList?page=1&limit=10
// 查询查过的列表  get

//post
//wangwang: hccgk
//isCanUsePoint: false
//http://damimi.dianshangbaike.com/GongjuUI/publishTXMWWRateInfo
//response
//{"needWarnLogin":false,"isOk":true,"pn":0,"ps":0,"count":49,"pnCount":0,"msg":"成功发布1条，失败0条。稍后后台自动开始查询。","errorCode":0,"res":[],"ok":true}  几次的操作

/*
 get 查询账号是否有降权
 
 http://damimi.dianshangbaike.com/NetflowMission/getWwList?wangwang=ymw170801
 response
 {
 "count":0,
 "msg":"3~5",//降权
 "code":0,
 "data":[
 {
 "id":3927442,
 "lastReportTs":1559097330782,
 "wangwang":"ymw170801",
 "reportCount":1,
 "createTs":1559097330782,
 "lastMonthReportCount":1,
 "remark":null,
 "xujia":0,
 "pitu":0,
 "qiaozha":1,
 "paodan":0,
 "pianzi":0,
 "chaping":0,
 "taoke":0,
 "createStr":"2019-05-29 10:35:30",
 "createTsStr":"2019-05-29 10:35:30",
 "lastReportTsStr":"2019-05-29 10:35:30"
 }
 ]
 }
 
 {"count":0,"msg":"tip:账号太白，存在风险","code":0,"data":[]} 白不白
 */
/*
 post
 http://damimi.dianshangbaike.com/Gongjuui/getAllTXMWWRateInfo
 参数
 wangwang=&status=0&startDate=1560873600000&endDate=1561564799000&pn=1&ps=20
 
 wangwang:
 status: 0
 startDate: 1560873600000
 endDate: 1561564799000
 pn: 1
 ps: 20
 
 response:
 {"needWarnLogin":false,"isOk":true,"pn":1,"ps":20,"count":1,"pnCount":1,"msg":null,"errorCode":0,"res":[{"id":17345199,"searchCount":0,"tag":null,"tagCat":null,"pullTs":1561537048099,"finishTs":1561537052818,"status":4,"createTs":1561537043913,"userId":7435692,"wangwang":"hccgk","vipLevel":0,"type":"C","buyerTotalNum":1110,"buyerScore":1110,"buyerGoodNum":1110,"buyerLevel":8,"sellerTotalNum":7,"sellerScore":7,"sellerGoodNum":7,"sellerLevel":1,"location":"北京","city":"北京","wwCreated":1210728527000,"weekCreditAverage":"1.91","vipInfo":"vip4","sentRate":"100.00%","receivedRate":"100%","retryTime":1,"wangwangId":105045412,"pcPullTs":1561537047725,"pcFinishTs":1561537052995,"gender":"M","tblevel":0,"identity":21,"avatar":"http://img06.taobaocdn.com/tfscom/img.taobaocdn.com/sns_logo/T1oZZNXf4gXXb1upjX.jpg_120x120.jpg","pcRetryTime":1,"createTsStr":"2019-06-26 16:17:23","statusStr":"已完成","pullTsStr":"2019-06-26 16:17:28","vipInfoLevel":4,"taoling":"11","finishTsStr":"2019-06-26 16:17:32","wwcreatedStr":"2008-05-14","realName":"店铺实名","realNameStatus":1}],"ok":true}
 */

/*
 get
 http://damimi.dianshangbaike.com/Gongjuui/getTXMWWInfoById?infoid=17345199
 参数 :infoid=17345199
 response:
 {"id":17345199,"searchCount":1,"tag":null,"tagCat":null,"pullTs":1561537048099,"finishTs":1561537052818,"status":4,"createTs":1561537043913,"userId":7435692,"wangwang":"hccgk","vipLevel":0,"type":"C","buyerTotalNum":1110,"buyerScore":1110,"buyerGoodNum":1110,"buyerLevel":8,"sellerTotalNum":7,"sellerScore":7,"sellerGoodNum":7,"sellerLevel":1,"location":"北京","city":"北京","wwCreated":1210728527000,"weekCreditAverage":"1.91","vipInfo":"vip4","sentRate":"100.00%","receivedRate":"100%","retryTime":1,"wangwangId":105045412,"pcPullTs":1561537047725,"pcFinishTs":1561537052995,"gender":"M","tblevel":0,"identity":21,"avatar":"http://img06.taobaocdn.com/tfscom/img.taobaocdn.com/sns_logo/T1oZZNXf4gXXb1upjX.jpg_120x120.jpg","pcRetryTime":1,"createTsStr":"2019-06-26 16:17:23","statusStr":"已完成","pullTsStr":"2019-06-26 16:17:28","vipInfoLevel":4,"taoling":"11","finishTsStr":"2019-06-26 16:17:32","wwcreatedStr":"2008-05-14","realName":"店铺实名","realNameStatus":1}
 */

/*
// header
 request
// POST /Gongjuui/getAllTXMWWRateInfo HTTP/1.1
// Host: damimi.dianshangbaike.com
// Connection: keep-alive
// Content-Length: 75
// Accept: application/json, text/javascript, **; q=0.01
//Origin: http://damimi.dianshangbaike.com
//X-Requested-With: XMLHttpRequest
//User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36
//Content-Type: application/x-www-form-urlencoded;utf-8
//Referer: http://damimi.dianshangbaike.com/gongjuui/wwRateInfo
//Accept-Encoding: gzip, deflate
//Accept-Language: zh-CN,zh;q=0.9
//Cookie: _invite_=7421678; _invite_ts_=1560755306750; __51cke__=; Hm_lvt_7e13550e5ac5afb49c564d0b3831e362=1560755308,1561536355; PLAY_SESSION="c14c7b0bedafe88682c2199fee19841300b01bdb-_sid_=80814c92a3647fc33e2142cc9b0a3f3118155e4d3b2f4ed1b278ba2e67e25ec4"; _sid_=80814c92a3647fc33e2142cc9b0a3f3118155e4d3b2f4ed1b278ba2e67e25ec4; __tins__20047719=%7B%22sid%22%3A%201561536354809%2C%20%22vd%22%3A%205%2C%20%22expires%22%3A%201561538569488%7D; __51laig__=5; Hm_lpvt_7e13550e5ac5afb49c564d0b3831e362=1561536770

 respose
 HTTP/1.1 200 OK
 Server: nginx/1.12.2
 Date: Wed, 26 Jun 2019 08:17:29 GMT
 Content-Type: application/json;charset=utf-8
 Content-Length: 930
 Connection: keep-alive
 Cache-Control: no-cache
 Set-Cookie: PLAY_FLASH=""; Expires=Thu, 01-Jan-1970 00:00:10 GMT; Path=/
 Set-Cookie: PLAY_ERRORS=""; Expires=Thu, 01-Jan-1970 00:00:10 GMT; Path=/
 Set-Cookie: PLAY_SESSION="c14c7b0bedafe88682c2199fee19841300b01bdb-_sid_=80814c92a3647fc33e2142cc9b0a3f3118155e4d3b2f4ed1b278ba2e67e25ec4"; Version=1; Path=/

 */
