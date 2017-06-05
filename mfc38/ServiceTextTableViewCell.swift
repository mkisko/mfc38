//
//  ServiceTextTableViewCell.swift
//  mfc38
//
//  Created by Алексей Усанов on 3/6/17.
//  Copyright © 2017 Алексей Усанов. All rights reserved.
//

import UIKit

class ServiceTextTableViewCell: UITableViewCell {

    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var TextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
