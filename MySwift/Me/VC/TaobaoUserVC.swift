//
//  TaobaoUserVC.swift
//  MySwift
//
//  Created by hechuan on 2019/6/28.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import Toaster
import PKHUD

class TaobaoUserVC: UIViewController {
    let Margin = 15
    var oldtbname:String?
    private var infoTextView:UITextView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupUI()
        loadData()
    }
    func loadData(){
        // 读取
    }
    func setupUI() {
        //1.信息view
        infoTextView = UITextView()
        self.view.addSubview(infoTextView!)
        infoTextView!.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        infoTextView!.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(appnavHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo((appHeight-appnavHeight-appbottomSafeAreaHeight)/2)
        })
        //2.功能按钮view
        let btntitlearr = ["已查","查号","切账号","登录"]
        let topMargin = appnavHeight + (appHeight-appnavHeight-appbottomSafeAreaHeight)/2 + 50
        for (index,value) in btntitlearr.enumerated() {
            let btn = UIButton()
            btn.setTitle(value, for: .normal)
            self.view.addSubview(btn)
            btn.backgroundColor = UIColor.init(white: 0.65, alpha: 1)
            btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
                make.top.equalToSuperview().offset(topMargin + CGFloat(index * 60))
                make.height.equalTo(44)
            }
            btn.tag = 1000 + index
            btn.addTarget(self, action: #selector(ActionWithTagId(btn:)), for:.touchUpInside )
        }
        
        let rightbtn = UIBarButtonItem.init(title: "刷新", style: .done, target: self, action: #selector(refreshID))
        self.navigationItem.setRightBarButton(rightbtn, animated: true)
        
    }
    @objc func refreshID(){
        
        if let tname = self.oldtbname {
            self.searchtbuserWithName(name: tname)
        }

    }
    @objc func ActionWithTagId(btn:UIButton)  {
        switch btn.tag {
        case 1000:
            lookedTbuser()
            
        case 1001:
            searchTBuser()
        case 1002:
            changUserPopView()
        case 1003:
            loginPopView()
        default:
            print("default")
        }
    }
    //MARK: - 遍历数据库已经查询过的数据
    func lookedTbuser(){
        let daview = DamimiUserListView.init(frame: CGRect(x: 0, y: 0, width: appWidth - 40, height: 300), style: .plain)
        PKHUD.sharedHUD.contentView = daview
        daview.loadTbData()
        daview.viewtype = "tb"
        daview.tbselectdelegate = self
        PKHUD.sharedHUD.show()
    }
    
    //MARK: - ///查号主方法
    func searchtbuserWithName(name:String) {
       
        let urllogin = URL.init(string: "http://damimi.dianshangbaike.com/GongjuUI/publishTXMWWRateInfo")!
        Alamofire.request(urllogin, method: .post, parameters: ["wangwang":name,"isCanUsePoint":"false"], encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
            switch data.result {
            case .success(let json ):
                
                let dict = json as! Dictionary<String,Any>
                //大咪咪user
                let adminusername = UserDefaults.standard.object(forKey: "damimiusernameNow") ?? ""
                let realm = try! Realm()
                let daarr = realm.objects(DamimiItem.self).filter("userName = '\(adminusername)'")
                if let ditem = daarr.first {
                    try? realm.write {
                        ditem.setValue(dict["count"], forKeyPath: "haveTimes")
                    }
                }
               
            
                let toast = Toast(text: "剩余查询次数\(String(describing: dict["count"]))")
                toast.show()
                
                self.lookDetailArray(tbname:name)
                
            case .failure(_):
                let toast = Toast(text: "失败")
                toast.show()
            }
        }
    }
    //MARK: - ///查号子方法
    func lookDetailArray(tbname:String){
        
        
        let urllogin = URL.init(string: "http://damimi.dianshangbaike.com/Gongjuui/getAllTXMWWRateInfo")!
        let timeNow = NSDate.init()
        let strstartdate = Int64(timeNow.addingTimeInterval(-24*60*60*10).timeIntervalSince1970 * 1000).description
        Alamofire.request(urllogin, method: .post, parameters: ["wangwang":"","status":"0","startDate":strstartdate,"endDate":Int(timeNow.timeIntervalSince1970*1000).description,"pn":"1","ps":"100"], encoding: URLEncoding.default, headers:nil).responseJSON { (data) in
            switch data.result{
            case .success(let json):
                let resdict = json as! Dictionary<String,Any>

                let object = resdict["res"]
                let arrdict = object as? Array<Any>
                for item in arrdict ?? [] {
                    let jdata = try? JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                    let jsonDecoder = JSONDecoder()
                    let modelObject = try? jsonDecoder.decode(RealmTaobaoUserTable.self, from: jdata ?? Data.init())
                    let adminusername = UserDefaults.standard.object(forKey: "damimiusernameNow") ?? ""
                    modelObject?.howsSearched = adminusername as? String
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(modelObject!, update: true)
                    }
                }
                self.requestInfoTaobaouser(name:tbname)
            case .failure(_):
                let toast = Toast(text: "fail")
                toast.show()
            }
            
            
        }
        
    }
    func requestInfoTaobaouser(name:String){
        let urllogin = URL.init(string: "http://damimi.dianshangbaike.com/NetflowMission/getWwList")!
        Alamofire.request(urllogin, method: .get, parameters: ["wangwang":name], encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
            switch data.result {
            case .success(let json ):

                let realm = try! Realm()
                let taoarr = realm.objects(RealmTaobaoUserTable.self).filter("wangwang = '\(name)'")
                if let item = taoarr.first {
                    let dict = json as! Dictionary<String,Any>
                    if let existence = dict["msg"] {
                        try? realm.write {
                            //对应field的写入
                            item.setValue((existence as! String), forKeyPath: "msg")
                            self.updateFindTBuserInfoWithName(tbname:name)

                        }
                    }
                }
               
                
                
            case .failure(_):
                let toast = Toast(text: "失败")
                toast.show()
            }
        }
        

    }
    

     func updateFindTBuserInfoWithName(tbname:String){
        print("---")
        //然后从数据库获取对应的userinfo
        let realm = try! Realm()
        let objarr = realm.objects(RealmTaobaoUserTable.self).filter("wangwang = '\(tbname)'")
        if let item = objarr.first {
            let adminusername = UserDefaults.standard.object(forKey: "damimiusernameNow") ?? ""
            let daarr = realm.objects(DamimiItem.self).filter("userName = '\(adminusername)'")
            if let daitem = daarr.first {
                let result = readdamimiuser(name: daitem.userName ?? "")
                var itype :String?
                if item.type ?? "" == "C" {
                    itype = "买家"
                }else{
                    itype = "卖家-淘宝店主"
                }
                var sexstr = ""
                if (item.gender == "F"){
                    sexstr = "女"
                }else {
                    sexstr = "男"
                }
                
                self.infoTextView?.text = "账户名称:\(result.name) \n失效时间:\(result.dateStr) \n剩余次数:\(result.times)\n-----------------------------------\n" + "淘宝用户名:\(tbname) \n账号类型:\(itype ?? "")  \n买家信用:\(item.buyerScore.description)点 \n性别:\(sexstr) \n淘龄:\(item.taoling ?? "") \n注册时间:\(item.wwcreatedStr ?? "") \n周信用点数:\(item.weekCreditAverage ?? "")\n是否实名:\(item.realName ?? "未实名") \nvip信息:\(item.vipInfo ?? "") \n中差评:\(item.buyerGoodNum - item.buyerScore) \n降权或者建议内容:\(item.msg ?? "无") "
                
            }
        }

    }
    ///查号入口
    func searchTBuser()  {
        let alertvc = UIAlertController.init(title: "淘宝用户名", message: nil, preferredStyle: .alert)
        alertvc.addTextField { (nametf) in
            nametf.placeholder = "taobo user name"
        }
        let canncel = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel) { (action) in
            alertvc.dismiss(animated: true, completion: nil)
        }
        let ok = UIAlertAction.init(title: "查询", style: .default) { (action) in
            alertvc.dismiss(animated: true, completion: nil)
            let tbusername = alertvc.textFields?.first!
            self.oldtbname = tbusername?.text
            self.searchtbuserWithName(name: tbusername?.text ?? "")
        }
        
        alertvc.addAction(canncel)
        alertvc.addAction(ok)
        self.present(alertvc, animated: true, completion: nil)
    }
    
   

    ///切换登录账号 使用pop一个tbv来进行操作
    func changUserPopView(){
        let daview = DamimiUserListView.init(frame: CGRect(x: 0, y: 0, width: appWidth - 40, height: 300), style: .plain)
        PKHUD.sharedHUD.contentView = daview
        daview.loadData()
        daview.viewtype = "mm"
        daview.selectdelegate = self
        PKHUD.sharedHUD.show()
        
    }
    ///登录操作
    func loginPopView()  {
        let alertvc = UIAlertController.init(title: "大咪咪的账户信息", message: "用户名和密码", preferredStyle: .alert)
        alertvc.addTextField { (nametf) in
            nametf.placeholder = "placename"
        }
        alertvc.addTextField { (passtf) in
            passtf.placeholder = "pasplaceholder"
            passtf.isSecureTextEntry = true
        }
        let canncel = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel) { (action) in
            alertvc.dismiss(animated: true, completion: nil)
        }
        let ok = UIAlertAction.init(title: "登录", style: .default) { (action) in
            alertvc.dismiss(animated: true, completion: nil)
            let tfname = alertvc.textFields?.first!
            let tfpas = alertvc.textFields?.last!
            self.loginWithName(name: tfname?.text ?? "", pass: tfpas?.text ?? "")
            
        }
        alertvc.addAction(canncel)
        alertvc.addAction(ok)
        self.present(alertvc, animated: true, completion: nil)
        
    }
    
    ///私有登录方法
    private func loginWithName(name:String,pass:String){
        print("日志:沙盒路径----- " + NSHomeDirectory())
        self.oldtbname = name
        let urllogin = URL.init(string: "http://damimi.dianshangbaike.com/LoginUI/doLogin")!
      
        Alamofire.request(urllogin, method: .post, parameters: ["userName":name,"password":pass,"remember":"false"], encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
            switch data.result {
            case .success(let json ):
                
                let dict = json as! Dictionary<String,Any>
                //使用手写方法引入model,,,优化方案,使用struct结构swift4之后支持的原生模型方法就会省去很多事情
                let model = DamimiUserModel.init(dict: dict)
                
                let realm = try! Realm()
                let daarr = realm.objects(DamimiItem.self).filter("userName = '\(name)'")
                var dmodel : DamimiItem?
                if let item = daarr.first {
                    try? realm.write {
                        item.setValue(pass, forKeyPath: "pass")
                        item.setValue(model.res?.expiredAt ?? 0, forKeyPath: "expiredAt")
                    
                    }

                }else{
                    dmodel = DamimiItem()
                    dmodel!.userId = model.res?.userId ?? 0
                    dmodel!.idhexString = model.res?.idString
                    dmodel!.created = model.res?.created ?? 0
                    dmodel!.expiredAt = model.res?.expiredAt ?? 0
                    dmodel!.userName = name
                    dmodel!.pass = pass
                    try? realm.write {
                        realm.add(dmodel!, update: true)
                    }
                }

                
               
                self.updataView(name:name)
                let toast = Toast(text: "登录成功")
                toast.show()
                UserDefaults.standard.set(name, forKey: "damimiusernameNow")
                UserDefaults.standard.synchronize()
                
            case .failure(_):
                let toast = Toast(text: "失败")
                toast.show()
            }
            
            
            
        }
    }
    
    func updataView(name:String){
        
        let result = readdamimiuser(name: name)

        self.infoTextView?.text = "账户名称:\(result.name) \n失效时间:\(result.dateStr) \n剩余次数:\(result.times)\n-----------------------------------\n"
    }
    
    //读数据库方法
    func readdamimiuser(name:String) -> (name:String,dateStr:String,times:String) {
        let realm = try! Realm()
        let objarr = realm.objects(DamimiItem.self).filter("userName = '\(name)'")
        let item = objarr.first!
        let exdate = Date.init(timeIntervalSince1970: TimeInterval(item.expiredAt/1000))
        let dateStr = DateFormatter.localizedString(from: exdate, dateStyle: DateFormatter.Style.medium, timeStyle: .medium)
        return  (name,dateStr,item.haveTimes.description)
    }
    
}

extension  TaobaoUserVC: DamimiuserSelectDelegate {
    func DidselectItem(item: DamimiItem) {
        loginWithName(name: item.userName!, pass: item.pass!)
        PKHUD.sharedHUD.hide()
    }
}

extension TaobaoUserVC:TaobaouserSelectDelegate{
    func whichWangWang(name: String) {
        updateFindTBuserInfoWithName(tbname: name)
        PKHUD.sharedHUD.hide()

    }
}
