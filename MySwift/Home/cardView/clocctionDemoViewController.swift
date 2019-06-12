//
//  clocctionDemoViewController.swift
//  MySwift
//  卡片view,左右滑动,然后底部有pagecontrore
//  Created by hechuan on 2019/6/6.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit

let cardDemoCollectionViewCellInd = "cardDemoCollectionViewCell"
let itemW = (appWidth-34*2)
let left:CGFloat = Spacing + bandage
let bandage:CGFloat = 14
let Spacing:CGFloat = 20.0
class clocctionDemoViewController: UIViewController {
    var pageControl:CardPageControl?
    lazy var mainView : UICollectionView = {
        let layout = CardFlowLayout.init()
        layout.itemSize = CGSize(width: itemW, height: 411)
        layout.minimumLineSpacing = Spacing
//        layout.minimumInteritemSpacing = 34
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 34)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        let viewe =  UICollectionView.init(frame: CGRect.init(x: 0, y: 72 + appnavHeight, width: appWidth, height: 411+30), collectionViewLayout: layout)
        viewe.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        viewe.delegate = self
        viewe.dataSource = self
        viewe.showsHorizontalScrollIndicator = false
        viewe.register(cardDemoCollectionViewCell.self, forCellWithReuseIdentifier: cardDemoCollectionViewCellInd)
        return viewe
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    
}

extension clocctionDemoViewController :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardDemoCollectionViewCellInd, for: indexPath)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isScrollEnabled = true
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollView.isScrollEnabled = false
        let OffsetIndex = scrollView.contentOffset.x / (itemW + left * 2)
        let index = Int(OffsetIndex)
        var selectedIndex = 0
        var offset:CGPoint?
        
        if targetContentOffset.pointee.x > 0 {// 向左
            if Int(OffsetIndex*100)%100 > 50 || abs(velocity.x) > 0.7
            {
                offset = CGPoint.init(x: (itemW + Spacing) * CGFloat(index + 1)  , y: 0.0)
                selectedIndex = index + 1
            }else {
                offset = CGPoint.init(x: (itemW + Spacing) * CGFloat(index )  , y: 0.0)
                selectedIndex = index
            }
        }else{//向右
            if Int(OffsetIndex*100)%100 > 50 || abs(velocity.x) > 0.7
            {
                offset = CGPoint.init(x: (itemW + Spacing) * CGFloat(index) , y: 0.0)
                selectedIndex = index
            }else {
                offset = CGPoint.init(x: (itemW + Spacing) * CGFloat(index + 1) , y: 0.0)
                selectedIndex = index + 1
            }
        }
        self.pageControl?.currentPage = selectedIndex
        targetContentOffset.pointee = offset ?? CGPoint.init()
    }
    
   
}

extension clocctionDemoViewController {
    func setupUI() {
        self.view.addSubview(mainView)
        addPageControl()
    }
    
    func addPageControl()  {
        let pageControl = CardPageControl.init(frame: CGRect.init(x: 0, y: 72 + appnavHeight + 411+30, width: appWidth, height: 20))
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl = pageControl
        self.view.addSubview(pageControl)
    }
    
    func setupData()  {
        self.pageControl?.numberOfPages = 3
        self.pageControl?.currentPage = 0

    }
}
