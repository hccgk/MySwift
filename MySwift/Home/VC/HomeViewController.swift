//
//  HomeViewController.swift
//  MySwift
//
//  Created by 何川 on 2019/3/29.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit
import PKHUD
import MJRefresh

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    var homeData : HomeViewModel = HomeViewModel()
    var page : NSInteger = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        self.makeUI()
//        loadData()
        self.tableView?.mj_header.beginRefreshing()
    }
    private func makeUI(){
        self.view .addSubview(self.tableView!)
    }
   @objc private func loadNewData(){
        let cview = danceView.init(frame: CGRect.zero)
        PKHUD.sharedHUD.contentView = cview
        PKHUD.sharedHUD.show()
        page = 1
        homeData.requestJoker(size: 10, number: page) { (state) in
            if state
            {
                self.tableView?.reloadData()
                self.tableView?.mj_header.endRefreshing()
            }
            PKHUD.sharedHUD.hide()
        }
    }
   @objc private func loadMoreData(){
        let cview = danceView.init(frame: CGRect.zero)
        PKHUD.sharedHUD.contentView = cview
        PKHUD.sharedHUD.show()
        page = page + 1
        weak var weakSelf = self

        homeData.requestJoker(size: 10, number: page) {  (state) in
            if state
            {
                self.tableView?.reloadData()
                if  weakSelf?.homeData.viewmodel?.result?.count ?? 0 < weakSelf?.page ?? 10  * 10
                {
                    self.tableView?.mj_footer.resetNoMoreData()

                }else {
                    self.tableView?.mj_footer.endRefreshing()

                }
            }
            PKHUD.sharedHUD.hide()
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
        let header = MJRefreshNormalHeader()
        temptableview.mj_header = header
        header.setRefreshingTarget(self, refreshingAction: Selector(("loadNewData")))
        let footer = MJRefreshAutoNormalFooter()
        temptableview.mj_footer = footer
        footer.setRefreshingTarget(self, refreshingAction: Selector(("loadMoreData")))
        return temptableview
    }()
}
