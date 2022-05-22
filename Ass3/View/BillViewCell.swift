//
//  BillViewCell.swift
//  Ass3
//
//  Created by Bob on 2022/5/19.
//


import UIKit

class BillViewCell: UITableViewCell {
    
    @IBOutlet weak var delteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var priceL: UILabel!
    @IBOutlet weak var categoryL: UILabel!
    @IBOutlet weak var dateL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
}

