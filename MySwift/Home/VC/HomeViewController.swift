//
//  HomeViewController.swift
//  MySwift
//
//  Created by 何川 on 2019/3/29.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit
import PKHUD

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    var homeData : HomeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.makeUI()
        loadData()
    }
    private func makeUI(){
        self.view .addSubview(self.tableView!)
    }

    private func loadData(){
        let cview = danceView.init(frame: CGRect.zero)
        PKHUD.sharedHUD.contentView = cview
        PKHUD.sharedHUD.show()
        
        homeData.requestJoker(size: 20, number: 1) { (state) in
            if state
            {
                self.tableView?.reloadData()
            }
            PKHUD.sharedHUD.hide(afterDelay: 3)
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeData.viewmodel?.result?.count ?? 0;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "testmyswifttableviewcellID"
        let cell = HomeTableCell(style: .default, reuseIdentifier: cellID)
        cell.selectionStyle = .none
        let model : MContentModel  = homeData.viewmodel?.result?[indexPath.row] ?? MContentModel()
        cell.configModel(model: model)
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44;
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row,indexPath.section)
        
    }
    lazy var tableView : UITableView? = {
     let temptableview = UITableView (frame: CGRect.init(x: 0, y: appnavHeight, width: appWidth, height: (CGFloat(appHeight) - CGFloat(appnavHeight) - CGFloat(apptabBarHeight))), style: .plain)
        temptableview.showsVerticalScrollIndicator = false
        temptableview.showsHorizontalScrollIndicator = false
        temptableview.separatorStyle = .none
        temptableview.delegate = self
        temptableview.dataSource = self
        temptableview.register(HomeTableCell.self, forCellReuseIdentifier: "testmyswifttableviewcellID")
        temptableview.estimatedRowHeight = 100
        temptableview.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        return temptableview
    }()
}
