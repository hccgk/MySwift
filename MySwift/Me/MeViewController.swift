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
        print(self.view.backgroundColor)//efeff4系统tableview默认颜色
        self.view.addSubview(self.tableview)
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
    func setupData() {
        self.dataArray = ["登录","查号"]
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
            loginAction()
        case 1:
            lookId()
        default:
          print(index.description)
            
        }
    }
    func lookId(){
        
    }
    func loginAction(){
        //http://damimi.dianshangbaike.com/LoginUI/doLogin
        //userName=ByteAndBit&password=521125&remember=false
        let urllogin = URL.init(string: "http://damimi.dianshangbaike.com/LoginUI/doLogin")!
        Alamofire.request(urllogin, method: .post, parameters: ["userName":"ByteAndBit","password":"521125","remember":"false"], encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
            switch data.result {
            case .success(let json ):
               
                let dict = json as! Dictionary<String,Any>
                
                let model = DamimiUserModel.init(dict: dict)
                
                let realm = try! Realm()
                let dmodel = DamimiItem()
                dmodel.userId = model.res?.userId ?? 0
                dmodel.idhexString = model.res?.idString
                dmodel.created = model.res?.created ?? 0
                dmodel.expiredAt = model.res?.expiredAt ?? 0
               
                try! realm.write {
                    realm.add(dmodel)

                }
                let toast = Toast(text: "登录成功")
                toast.show()

            case .failure(_):
                let toast = Toast(text: "失败")
                toast.show()
            }
            

            
        }
    }
}
