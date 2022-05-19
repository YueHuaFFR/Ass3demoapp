import UIKit

class InputBillViewController2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    // Provide a component which is categoryTextField
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
        categoryTextField2.text = category[row]
        categoryTextField2.resignFirstResponder() // Close picker view
    }
    
    @IBOutlet weak var categoryTextField2: UITextField!
    
    @IBOutlet weak var amountTextField2: UITextField!
    
    
    var amt: Int = 0 // The default amount is 0
    // The billing category offered to the user to select
    let category = ["Food", "House", "Transportation", "Entertainment", "Shop"]
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        // Input bill category into categoryTextField
        categoryTextField2.inputView = pickerView
        categoryTextField2.textAlignment = .center // Center text
        
        amountTextField2.delegate = self
        amountTextField2.placeholder = updateAmount()
        
    }
    
    
    @IBAction func clickSave2(_ sender: Any) {
    // If the user doesn't enters the category
        if (categoryTextField2.text!.count == 0) {
            // A warning appears: Please enter the category
            let nameAlert = UIAlertController(title: "Alert", message: "Please input the category", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel)
            nameAlert.addAction(ok)
            present(nameAlert, animated: true, completion: nil)
        }
        else if (amountTextField2.text!.count == 0) {
            // A warning appears: Please enter the amount of money
            let nameAlert = UIAlertController(title: "Alert", message: "Please input the amount of money", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel)
            nameAlert.addAction(ok)
            present(nameAlert, animated: true, completion: nil)
        }
        else if (categoryTextField2.text!.count == 0 && amountTextField2.text!.count == 0) {
            let nameAlert = UIAlertController(title: "Alert", message: "Please input the amount and category", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel)
            nameAlert.addAction(ok)
            present(nameAlert, animated: true, completion: nil)
        }
        else {
            let nameAlert = UIAlertController(title: "Notice", message: "Your bill have been saved", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel)
            nameAlert.addAction(ok)
            present(nameAlert, animated: true, completion: nil)
            // Clear the amount and category after successful saved
            amountTextField2.text = ""
            amt = 0
            categoryTextField2.text = ""
        }
    }
    // Method of amount textfeild
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let digit = Int(string) {
            // Total amount
            amt = amt * 10 + digit
            
            // If the user enters an amount over a billion
            if (amt > 1_000_000_000_00) {
                let nameAlert = UIAlertController(title: "Alert", message: "Please input the amount less that 1 billion", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel)
                nameAlert.addAction(ok)
                present(nameAlert, animated: true, completion: nil)
                
                amountTextField2.text = ""
                amt = 0
            } else {
            amountTextField2.text = updateAmount()
            }
        }
        // User presses backspace
        if string == "" {
            amt = amt / 10
            amountTextField2.text = amt == 0 ? "": updateAmount()
        }
        return false
    }
    
    func updateAmount() -> String? {
        // Convert string to number format
        let formatter = NumberFormatter()
        // Defined currency style format
        formatter.numberStyle = NumberFormatter.Style.currency
        // User starts typing after the decimal point
        let amount = Double(amt / 100) + Double(amt%100) / 100
        // Convert data to currency string
        return formatter.string(from: NSNumber(value: amount))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
