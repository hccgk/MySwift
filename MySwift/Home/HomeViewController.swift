//
//  HomeViewController.swift
//  MySwift
//
//  Created by 何川 on 2019/3/29.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeUI()
        
    }
    private func makeUI(){
        self.view .addSubview(self.tableView!)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "testmyswifttableviewcellID"
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        cell.textLabel?.text = "第几个cell  ---\(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row,indexPath.section)
        
    }
    lazy var tableView : UITableView? = {
     let temptableview = UITableView (frame: CGRect.init(x: 0, y: appnavHeight, width: appWidth, height: (CGFloat(appHeight) - CGFloat(appnavHeight) - CGFloat(apptabBarHeight))), style: .plain)
        temptableview.showsVerticalScrollIndicator = false
        temptableview.showsHorizontalScrollIndicator = false
//        temptableview.backgroundColor = UIColor.blue
        temptableview.separatorStyle = .none
        temptableview.delegate = self
        temptableview.dataSource = self
       
        
        return temptableview
    }()
}
