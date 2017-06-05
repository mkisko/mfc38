//
//  OfficeTableViewCell.swift
//  mfc38
//
//  Created by Алексей Усанов on 24.06.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit

class OfficeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
