//
//  BillViewController.swift
//  Ass3
//
//  Created by Bob on 2022/5/19.
//

import UIKit

class BillViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var datasource: [NSDictionary] = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Input"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"BillViewCell", bundle:nil),
                    forCellReuseIdentifier:"BillViewCell")
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getData()
    }
    
    func getData() {
        // 本地获取数据
         let tfArray = NSArray(contentsOfFile:NSHomeDirectory() + "/Documents/tfDic.plist") as? [NSDictionary]
        if tfArray == nil { return }
        self.datasource = tfArray!
         tableView.reloadData()
    }
}

extension BillViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BillViewCell = tableView.dequeueReusableCell(withIdentifier: "BillViewCell")
                    as! BillViewCell
        cell.selectionStyle = .none
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(editBtn), for: .touchUpInside)
        cell.delteBtn.addTarget(self, action: #selector(deleteBtn), for: .touchUpInside)
        let model = datasource[indexPath.row]
        cell.categoryL.text = (model["cagtegory"] as! String)
        cell.dateL.text = (model["date"] as! String)
        cell.priceL.text = (model["money"] as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    @objc private func editBtn(btn: UIButton) {
        let storyboard = UIStoryboard(name: "UpdateViewController", bundle:nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        destinationVC.dict = datasource[btn.tag]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc private func deleteBtn(btn: UIButton) {
        var tfArray = NSArray(contentsOfFile:NSHomeDirectory() + "/Documents/tfDic.plist") as! [NSDictionary]
        tfArray.remove(at: btn.tag)
        datasource.remove(at: btn.tag)
        tableView.reloadData()
        let filePath: String = NSHomeDirectory() + "/Documents/tfDic.plist"
        NSArray(array: tfArray).write(toFile: filePath, atomically: true)
    }
}

