//
//  ListTableViewCell.swift
//  AisleConnectTest
//
//  Created by 黃昌齊 on 2021/8/4.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var bookCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
