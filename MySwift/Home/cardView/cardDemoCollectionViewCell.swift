//
//  cardDemoCollectionViewCell.swift
//  MySwift
//
//  Created by hechuan on 2019/6/6.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit

class cardDemoCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.randomColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
