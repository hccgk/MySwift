//
//  CardFlowLayout.swift
//  MySwift
//
//  Created by hechuan on 2019/6/11.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit
let ZoomFactor:CGFloat = 0.11

class CardFlowLayout: UICollectionViewFlowLayout {
    //允许更新位置, 这个如果不写,一个循环内卡片越来越小,最后等循环结束开始下个循环时,cell重置大小
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElements(in: rect)
        var visibleRect = CGRect.init()
        visibleRect.origin = self.collectionView?.contentOffset ?? CGPoint.init(x: 0, y: 0)
        visibleRect.size = self.collectionView?.bounds.size ?? CGSize.init()
        
        for (_,value) in array!.enumerated() {
            let attributes = value
            let distance = visibleRect.midX - attributes.center.x
            let normalizedDistance = abs(distance/self.itemSize.width)
            let zoom = 1 - normalizedDistance*ZoomFactor
            attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0)
            attributes.zIndex = 1
            
        }
        return array
        
    }

  
    
    
 
}
