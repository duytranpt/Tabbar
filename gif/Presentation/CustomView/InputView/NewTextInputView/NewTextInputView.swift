//
//  NewTextInputView.swift
//  gif
//
//  Created by Duy Tran on 10/01/2023.
//

import UIKit

@IBDesignable
class NewTextInputView: BaseView {
    
    // Outlet:
    @IBOutlet weak var vTextField: UITextField!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    //
    @IBInspectable var isRequired: Bool = false {
        didSet {
            self.setTitle(str: Title)
        }
    }
    
    @IBInspectable var Title: String = "" {
        didSet {
            self.setTitle(str: Title)
        }
    }
    
    var max_length = 0
    var mustUppercase = false
    var typeInput: InputType?
    
    enum InputType: Int {
        case INPUT_TYPE_NAME
        case INPUT_TYPE_NOTE
        case INPUT_TYPE_EMAIL
        case INPUT_TYPE_PHONE
        case INPUT_TYPE_NUMBER
        case INPUT_TYPE_EXPIRYDATE
        case INPUT_TYPE_ISSUINGDATE
    }
    
    var type: InputType = .INPUT_TYPE_NAME
    @IBInspectable
    var MainType: Int = 0 {
        didSet {
            self.type = InputType(rawValue: MainType) ?? .INPUT_TYPE_NAME
            self.updateView()
        }
    }
        
    override func commonInit() {
        let nib = UINib(nibName: "NewTextInputView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        self.vTextField?.delegate = self
    }
    
    private func updateView() {
        switch type {
        case .INPUT_TYPE_NAME:
            self.typeInput = .INPUT_TYPE_NAME
        case .INPUT_TYPE_NOTE:
            self.typeInput = .INPUT_TYPE_NOTE
        case .INPUT_TYPE_EMAIL:
            self.typeInput = .INPUT_TYPE_EMAIL
        case .INPUT_TYPE_PHONE:
            self.typeInput = .INPUT_TYPE_PHONE
        case .INPUT_TYPE_NUMBER:
            self.typeInput = .INPUT_TYPE_NUMBER
        case .INPUT_TYPE_EXPIRYDATE:
            self.typeInput = .INPUT_TYPE_EXPIRYDATE
        case .INPUT_TYPE_ISSUINGDATE:
            self.typeInput = .INPUT_TYPE_ISSUINGDATE
            
        }
        
        self.validateCharater()
    }
    
    private func validateCharater() {
        switch typeInput {
        case .INPUT_TYPE_NUMBER:
            max_length = 10
            vTextField!.keyboardType = .numberPad
            print("đây nè: \(max_length)")
        case .INPUT_TYPE_NAME:
            break
        case .INPUT_TYPE_EMAIL:
            max_length = 256
            vTextField!.keyboardType = .emailAddress
        case .INPUT_TYPE_EXPIRYDATE:
            max_length = 5
            vTextField!.keyboardType = .numberPad
        default:
            break
        }
    }
    
    private func setTitle(str: String?) {
        self.titleLbl?.font = .fontMedium(13)
        let titleStr = isRequired ? "\(str!)*" : str
        let string = NSMutableAttributedString(string: titleStr!)
        if isRequired {
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("919191"), range: NSRange(location: 0, length: titleStr!.count - 1))
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("FF5C22"), range: NSRange(location: titleStr!.count - 1, length: 1))
        } else {
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("919191"), range: NSRange(location: 0, length: titleStr!.count))
        }
        self.titleLbl.attributedText = string
    }
    
  
}

extension NewTextInputView: UITextFieldDelegate {
        
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let str: String
        if let text = textField.text, let swiftRange = Range(range, in: text) {
            str = text.replacingCharacters(in: swiftRange, with: string)
        } else {
            str = string
        }
    
        if self.max_length > 0 {
            if str.count > self.max_length {
                return false
            }
        }
        
        if typeInput == .INPUT_TYPE_NAME {
            textField.text = self.remove_special_char(str)
            if (!self.mustUppercase) {
                textField.text = textField.text?.uppercased();
            }
            DispatchQueue.main.async {
                textField.selectedTextRange = textField.textRange(from: textField.endOfDocument, to: textField.endOfDocument)!
               }
            return false
        }
        
        if typeInput == .INPUT_TYPE_EMAIL {
            textField.text = self.disagreeChar(str, type: .INPUT_TYPE_EMAIL)
            return false
        }
        
        if typeInput == .INPUT_TYPE_NUMBER {
            
        }
        
        if typeInput == .INPUT_TYPE_EXPIRYDATE {
            
        }
        
        return true
    }
}

extension NewTextInputView {
    
    func validateIssuingDate(_ str: String) -> Bool {
        if str.count > 0 {
            
        }
        
        if str.count > 1 {
            let strNumber: String = (str as NSString).substring(to: 2)
            if Int(strNumber) ?? 0 > 12 {
                return false
            }
        }
        
        if str.count >= 4 {
            let range = [str .components(separatedBy: "/")]
            let yearNow = getYear()
            let year = range[1]
            
            if year.count > 0 {
                let yearNumber: String = (year[0] as NSString).substring(to: 1)
                if  Int(yearNumber)! > yearNow/10  {
                    return false
                }
            }
            
            if year.count > 1 {
                let yearNumber: String = (year[0] as NSString).substring(to: 2)
                if  Int(yearNumber)! > yearNow || Int(yearNumber)! < yearNow - 31 {
                    return false
                }

            }
        }
        
        return true
    }
    
    func disagreeChar(_ str: String, type: InputType) -> String {
        let unfilteredString = bo_dau_Tieng_Viet(str)
        var notAllowedChars: CharacterSet?
        switch type {
        case .INPUT_TYPE_NOTE:
            break
        case .INPUT_TYPE_NAME:
            break
        case .INPUT_TYPE_EMAIL:
            
        notAllowedChars = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_.-@").inverted
            
        case .INPUT_TYPE_PHONE:
            break
        case .INPUT_TYPE_NUMBER:
            break
        case .INPUT_TYPE_EXPIRYDATE:
            break
        case .INPUT_TYPE_ISSUINGDATE:
            break
        }
        
        let resultString = unfilteredString!.components(separatedBy: notAllowedChars!).joined(separator: " ")
        let trimmedString = trimSpace(resultString)
        return trimmedString ?? ""
    }
    
    func bo_dau_Tieng_Viet(_ str: String?) -> String? {
        var vn = str?.replacingOccurrences(of: "đ", with: "d")
        vn = vn?.replacingOccurrences(of: "Đ", with: "D")
        let data = vn?.data(using: .ascii, allowLossyConversion: true)
        var en: String? = nil
        if (data != nil) {
            en = String(data: data!, encoding: .ascii)
        }
        return en
    }
    
    func remove_special_char(_ str: String) -> String {
        
        let unfilteredString = bo_dau_Tieng_Viet(str)
        let notAllowedChars = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").inverted
        let resultString = unfilteredString!.components(separatedBy: notAllowedChars).joined(separator: " ")
        let trimmedString = trimSpace(resultString)
        
        return trimmedString ?? ""
       
    }
    
    func trimSpace(_ str: String?) -> String? {
        var trimmedString = str
        while (trimmedString as NSString?)?.range(of: "  ").location != NSNotFound {
            trimmedString = trimmedString?.replacingOccurrences(of: "  ", with: " ")
        }
        return trimmedString
    }
    
    func validateEmail() -> Bool? {
        if !(self.vTextField?.text?.isValidEmail)! {
            return false
        }
        return true
    }
    
    func setPlaceholder(_ Placeholder: String!) {
        self.vTextField!.attributedPlaceholder = NSAttributedString(string: "\(Placeholder!)",attributes: [NSAttributedString.Key.foregroundColor: UIColor.cgRGB(rgb: "234 234 234")])
    }
    
    func getYear() -> Int {
        let year = Calendar.current.component(.year, from: Date())
        return year % 100
    }
}
