//
//  TableViewCell.swift
//  ios Ass3
//
//  Created by 潘潘 on 2022/5/17.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func Edit(_ sender: Any) {
    }
    @IBAction func Delete(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
