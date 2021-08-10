//
//  ProductTableViewCell.swift
//  AisleConnectTest
//
//  Created by 黃昌齊 on 2021/8/10.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
