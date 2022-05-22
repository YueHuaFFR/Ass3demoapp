import UIKit

class UpdateViewController: UIViewController, UITextFieldDelegate  {
    
    
    @IBOutlet weak var datePick: UIDatePicker!
    @IBOutlet weak var categoryT: UITextField!
    @IBOutlet weak var accountT: UITextField!
    
    var dict: NSDictionary = [:]
    
    let category = ["Food", "House", "Transportation", "Entertainment", "Shop"]
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Update"
        
        pickerView.delegate = self
        pickerView.dataSource = self
        // Input bill category into categoryTextField
        categoryT.inputView = pickerView
        categoryT.textAlignment = .center // Center text
        
        accountT.delegate = self
        
        categoryT.text = (dict["cagtegory"] as! String)
        accountT.text = (dict["money"] as! String)
        let tempDate = dict["date"] as! String
        datePick.date = stringConvertDate(string: tempDate)
    }
    
    func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        
        let tfArray = NSMutableArray(contentsOfFile:NSHomeDirectory() + "/Documents/tfDic.plist")
        
        var i = 0
        while i < tfArray!.count {
            let model = tfArray![i] as! NSDictionary
            let modeldate = model["date"] as! String
            let dictdate = dict["date"] as! String
            if modeldate == dictdate {
                let dict = ["date": date2String(self.datePick.date), "cagtegory": categoryT.text!, "money": accountT.text!] as [String : Any]
                tfArray?.replaceObject(at: i, with: dict)
            }
            i += 1
        }
        
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


extension UpdateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

