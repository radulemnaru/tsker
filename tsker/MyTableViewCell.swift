//
//  MyTableViewCell.swift
//  tsker
//
//  Created by Radu Lemnaru on 06/06/14.
//  Copyright (c) 2014 Radu Lemnaru. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    let medOrange:UIColor = UIColor(red: 0.973, green: 0.388, blue: 0.173, alpha: 1)
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = medOrange
        self.textColor = UIColor.whiteColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.font = UIFont(name: "AvenirNext-Regular", size: 14)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
