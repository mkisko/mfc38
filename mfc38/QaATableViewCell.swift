//
//  QaATableViewCell.swift
//  mfc38
//
//  Created by Алексей Усанов on 27.06.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit

class QaATableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
