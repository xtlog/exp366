//
//  CustomTableViewCell.swift
//  ex366
//
//  Created by x5 on 15/11/18.
//  Copyright © 2015年 sxnic. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var explain: UILabel!
    
    @IBOutlet weak var credate: UILabel!
    
    @IBOutlet weak var customView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置头像是圆形显示
        titleImage.layer.masksToBounds = true
        titleImage.layer.cornerRadius = titleImage.frame.size.width/2
        //设置cell是有圆角边框显示
        customView.layer.masksToBounds = true
        customView.layer.cornerRadius = 10
        
        
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
