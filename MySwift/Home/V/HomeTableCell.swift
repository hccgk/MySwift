//
//  HomeTableCell.swift
//  MySwift
//
//  Created by 何川 on 2019/4/2.
//  Copyright © 2019 hechuan. All rights reserved.
//

import UIKit

class HomeTableCell: UITableViewCell {
     var titleLabelm : UILabel?
    var model : MContentModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI()  {
        self.contentView.backgroundColor = UIColor.randomColor
        titleLabelm = UILabel.init()
        self.contentView.addSubview(titleLabelm!)
        titleLabelm?.snp_makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-10)
        })
        titleLabelm?.font = UIFont.systemFont(ofSize: 15)
        titleLabelm?.textColor = UIColor.red
        titleLabelm?.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        titleLabelm?.numberOfLines = 0
    }
    func configModel(model: MContentModel)  {
        titleLabelm?.text = model.content
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
