//
//  BillViewController.swift
//  ios Ass3
//
//  Created by 潘潘 on 2022/5/17.
//

import UIKit
struct expend{
    var data: String
    var category: String
    var amount: Double
}

class BillViewController: UIViewController {
    var expends = [
        expend(data: "May 17", category: "food", amount: 15.5),
        expend(data: "May 18", category: "bag", amount: 155),
        expend(data: "May 19", category: "transport", amount: 5.5)
    ]

    @IBOutlet weak var BillTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension BillViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BillTableView.dequeueReusableCell(withIdentifier: "Billcell") as! TableViewCell
        cell.dataLabel.text = expends[indexPath.row].data
        cell.categoryLabel.text = expends[indexPath.row].category
        cell.amountLabel.text = String(expends[indexPath.row].amount)
        return cell
    }
    
    
}
extension BillViewController: UITableViewDelegate{
    
}
