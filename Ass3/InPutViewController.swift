//
//  InPutViewController.swift
//  Ass3
//
//  Created by Bob on 2022/5/19.
//

import UIKit

class InPutViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var accountT: UITextField!
    @IBOutlet weak var categoryT: UITextField!
    @IBOutlet weak var datePick: UIDatePicker!
    
    let category = ["Food", "House", "Transportation", "Entertainment", "Shop"]
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Input"
        
        pickerView.delegate = self
        pickerView.dataSource = self
        // Input bill category into categoryTextField
        categoryT.inputView = pickerView
        categoryT.textAlignment = .center // Center text
        
        accountT.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text else {
            return true
        }

        /// 1.过滤删除事件
        guard !string.isEmpty else {
            return true
        }

        /// 2.检查允许输入的合法字符
        guard "0123456789.".contains(string) else {
            return false
        }

        /// 3.检查总长度限制 (最多输入10位)
        if text.count >= 10 {
            return false
        }

        /// 4.检查小数点后位数限制 (小数点后最多输入2位)
        if let ran = text.range(of: "."), range.location - NSRange(ran, in: text).location > 2 {
            return false
        }

        /// 5.检查首位输入是否为0
        if text == "0", string != "." {
            textField.text = string
            return false
        }

        /// 6.特殊情况检查
        guard string == "." || string == "0" else {
               return true
           }

        /// a.首位小数点替换为0.
        if text.count == 0, string == "." {
            textField.text = "0."
            return false
        }

        /// b.禁止多次输入小数点
        if text.range(of: ".") != nil, string == "." {
            return false
        }

        return true
    }

    
    @IBAction func saveClick(_ sender: Any) {
        if (categoryT.text!.count == 0) {
            // A warning appears: Please enter the category
            let nameAlert = UIAlertController(title: "Alert", message: "Please input the category", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel)
            nameAlert.addAction(ok)
            present(nameAlert, animated: true, completion: nil)
        }
         if (accountT.text!.count == 0) {
            // A warning appears: Please enter the amount of money
            let nameAlert = UIAlertController(title: "Alert", message: "Please input the amount of money", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel)
            nameAlert.addAction(ok)
            present(nameAlert, animated: true, completion: nil)
        }
        
        var tfArray = NSMutableArray(contentsOfFile:NSHomeDirectory() + "/Documents/tfDic.plist")
        if tfArray == nil {
            tfArray = NSMutableArray()
        }
        let dict = ["date": date2String(self.datePick.date), "cagtegory": categoryT.text!, "money": accountT.text!] as [String : Any]
        tfArray?.add(dict)
        let filePath: String = NSHomeDirectory() + "/Documents/tfDic.plist"
        NSArray(array: tfArray!).write(toFile: filePath, atomically: true)
        
        let nameAlert = UIAlertController(title: "Notice", message: "Your bill have been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "sure", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        nameAlert.addAction(okAction)
        present(nameAlert, animated: true, completion: nil)
        
    }
    @IBAction func HomeClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
}


extension InPutViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Return the number of category
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row]
    }
    
    // Make the items in the category selectable
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Pass the category selected by the user to categoryTextField for display
        categoryT.text = category[row]
        categoryT.resignFirstResponder() // Close picker view
    }
}
