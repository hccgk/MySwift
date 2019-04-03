//
//  CenterRightViewController.swift
//  MySwift
//
//  Created by 何川 on 2019/3/29.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit
import SnapKit
class CenterRightViewController: UIViewController {

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
    @objc  func jumpTodo(){
        self.navigationController?.pushViewController(NextViewController(), animated: true)
    }
    
    private func makeUI(){
//        let btnNext = UIButton.init(frame: CGRect.init(x: 10, y: appnavHeight+10, width: 100, height: 44))
        let btnNext = UIButton.init()
        btnNext.backgroundColor = UIColor.blue
        btnNext.setTitle("点我去下一个", for: .normal)
        btnNext.addTarget(self
            , action: #selector(jumpTodo), for: .touchUpInside)
        self.view.addSubview(btnNext)
        btnNext.snp.makeConstraints { (make) in
            make.left.equalTo(100)
            make.width.equalTo(200)
            make.height.equalTo(44)
            make.top.equalTo(appnavHeight + 10)
        }
        btnNext.titleLabel?.adjustsFontSizeToFitWidth = true

        
        
//        btnNext.addTarget(self, action: #selector(jumpTodo), for: .touchUpInside)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
