//
//  TypeServiceTableViewCell.swift
//  mfc38
//
//  Created by Алексей Усанов on 21.12.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit

class TypeServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
