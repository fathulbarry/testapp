//
//  NormalTableViewCell.swift
//  TestApp
//
//  Created by Prijo on 4/5/21.
//  Copyright © 2021 Tawk. All rights reserved.
//

import UIKit

class NormalTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
