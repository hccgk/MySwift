//
//  CenterRightViewController.swift
//  MySwift
//
//  Created by 何川 on 2019/3/29.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation
import RealmSwift

class CenterRightViewController: UIViewController {
    
    let BtnCollectionViewCellInder = "BtnCollectionViewCell"
    var mCollectionView: UICollectionView?
    let mDataArr = ["定位开启","结束运行定位","展示速度数据","坐标信息图","跳转界面","分享"]  //不维护按钮状态,只弹框显示结果
    var locationManager:CLLocationManager!


   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *){
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//            _scrollview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
        }
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        self.makeUI()

    }
   
   
    
    private func makeUI(){
       
        let layout = UICollectionViewFlowLayout.init()
//        -20 - item -15- item -15- item - 20
        layout.itemSize = CGSize(width: (appWidth-40-30)/3.0, height: 44)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 10, bottom: 20, right: 20)
        
        mCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: appnavHeight, width: appWidth, height: appHeight - appnavHeight - apptabBarHeight), collectionViewLayout: layout)
        mCollectionView?.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        mCollectionView?.delegate = self
        mCollectionView?.dataSource = self
        mCollectionView?.showsVerticalScrollIndicator = false
        mCollectionView?.register(BtnCollectionViewCell.self, forCellWithReuseIdentifier: BtnCollectionViewCellInder)
        self.view.addSubview(mCollectionView!)
        
    }
   
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//MARK: - 动画
    /*
     let buttonWithTag = self.view.viewWithTag(10001)
     buttonWithTag?.snp.updateConstraints({(make) in
     make.centerX.equalToSuperview().offset(-100)
     make.centerY.equalToSuperview().offset(-100)
     })
     UIView.animate(withDuration: 2, animations: {
     self.view.layoutIfNeeded()
     }) { (complete) in
     self.navigationController?.pushViewController(NextViewController(), animated: true)
     }
     */
}

//MARK: - UICollectionViewDataSource
extension CenterRightViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BtnCollectionViewCellInder, for: indexPath) as! BtnCollectionViewCell
        
        cell.mTextLabel.text = mDataArr[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            startLocation()
        case 1:
            stopLocation()
        case 2:
            speedShow()
        case 3:
            locationMap()
        case 4:
            jumpTodo()
        case 5:
            shareToSys()
        default:
            nothing()
        }
    }
    
    //MARK: - Actions
    
    ///开启定位
    private func startLocation(){
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 2
        
        if #available(iOS 8.0, *) {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }else{
            print("没有定位权限并引导用户去定位")
        }
        
    }
    ///结束定位与后台的运行
    private func stopLocation(){
        
    }
    ///速度显示
    private func speedShow(){
        
    }
    
    ///途径地点地图显示
    private func locationMap(){
        
    }
    ///跳转页面
    @objc  func jumpTodo(){
        self.navigationController?.pushViewController(NextViewController(), animated: true)
    }
    
    
    ///default
    private func nothing(){
    }
    
    ///share功能开发
    private func shareToSys(){
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        //        let items = [URL(string: "https://www.apple.com")!]
        let itemsimage = [image!]
        
        let ac = UIActivityViewController(activityItems: itemsimage, applicationActivities: nil)
        present(ac, animated: true)
        
    }
    
}

extension CenterRightViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            let locationInfo = locations.last!
            // 存储到realm db
//            locationInfo.speed
        }
    }
}
