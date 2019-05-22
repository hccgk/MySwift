//
//  BtnCollectionViewCell.swift
//  MySwift
//
//  Created by hechuan on 2019/5/22.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit

class BtnCollectionViewCell: UICollectionViewCell {
    var mTextLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mTextLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        mTextLabel.font = UIFont.systemFont(ofSize: 12)
        mTextLabel.numberOfLines = 0
        mTextLabel.textAlignment = NSTextAlignment.center
        mTextLabel.layer.masksToBounds = true
        mTextLabel.layer.cornerRadius = 22
        mTextLabel.layer.borderColor = UIColor.init(white: 0.85, alpha: 1).cgColor
        mTextLabel.layer.borderWidth = 1
        self.contentView.addSubview(mTextLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
