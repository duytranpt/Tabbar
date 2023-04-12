//
//  DTTextInputView.swift
//  gif
//
//  Created by Duy Tran on 03/01/2023.
//

import UIKit

class DTTextInputView: UIView {
    
    enum InputType: Int {
        case INPUT_TYPE_NOTE
        case INPUT_TYPE_NAME
        case INPUT_TYPE_NAME_VI
        case INPUT_TYPE_EMAIL
        case INPUT_TYPE_PHONE
        case INPUT_TYPE_NUMBER
        case INPUT_TYPE_EXPIRYDATE
        case INPUT_TYPE_ISSUINGDATE
    }
    
    var titleLabel: UILabel?
    var vTextField: UITextField?
    var showHidePasswordButton: UIButton?
    var separatorView: UIView?
    var selfPadding: CGFloat = 0.0
    var typeInput: InputType?
    var max_length = 0
    var validCharacters: String?
    
    var mustUppercase = false
    
    var widthh:Double!
    var heightt:Double!
    
    init?(newInputViewWithTitle title: String?, andType: InputType, andIsRequired: Bool, andFrame: CGRect) {
        
        super.init(frame: andFrame)
        let width = andFrame.size.width
        let height = frame.size.height
        self.backgroundColor = .white
        typeInput = andType
        selfPadding = 14
        self.titleLabel = UILabel(frame: CGRect(x: 14, y: 10, width: width - 28, height: height/2 - 11))
        self.titleLabel?.font = .fontMedium(13)
        let titleStr = andIsRequired ? "\(title!)*" : title
        let string = NSMutableAttributedString(string: titleStr!)
        
        if andIsRequired {
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("919191"), range: NSRange(location: 0, length: titleStr!.count - 1))
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("FF5C22"), range: NSRange(location: titleStr!.count - 1, length: 1))
        } else {
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("919191"), range: NSRange(location: 0, length: titleStr!.count))
        }
        
        self.titleLabel?.attributedText = string
        self.titleLabel?.numberOfLines = 0
        self.addSubview(self.titleLabel!)
        
        self.vTextField = UITextField(frame: CGRect(x: 14, y: height/2 - 1, width: width - 28, height: height/2 - 5))
        self.vTextField?.textColor = .black
        self.vTextField?.font = .fontMedium(17)
        self.vTextField?.delegate = self
        self.addSubview(vTextField!)
        
        self.separatorView = UIView(frame: CGRect(x: 14, y: height-1, width: width-28, height: 1))
        self.separatorView?.backgroundColor = .colorFromHex("CACACA")
        
        self.addSubview(separatorView!)
        
        let bt = UIButton(frame: andFrame)
        self.addSubview(bt)
        self.sendSubviewToBack(bt)
        let wSelf = self
        
        bt.addAction {
            if wSelf.vTextField!.isFirstResponder {
                wSelf.vTextField!.resignFirstResponder()
            } else {
                wSelf.vTextField!.becomeFirstResponder()
            }
        }
        
        self.validateCharater()
    }
    
    init?(newInputViewWithTitle title: String?, andType: InputType, andIsRequired: Bool, confirmBtnLbl: String, andFrame: CGRect, callback: @escaping () -> Void) {
        
        super.init(frame: andFrame)
        let width = andFrame.size.width
        let height = frame.size.height
        self.backgroundColor = .white
        typeInput = andType
        selfPadding = 14
        self.titleLabel = UILabel(frame: CGRect(x: 14, y: 10, width: width - 28, height: height/2 - 11))
        self.titleLabel?.font = .fontMedium(13)
        let titleStr = andIsRequired ? "\(title!)*" : title
        let string = NSMutableAttributedString(string: titleStr!)
        
        if andIsRequired {
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("919191"), range: NSRange(location: 0, length: titleStr!.count - 1))
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("FF5C22"), range: NSRange(location: titleStr!.count - 1, length: 1))
        } else {
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("919191"), range: NSRange(location: 0, length: titleStr!.count))
        }
        
        self.titleLabel?.attributedText = string
        self.titleLabel?.numberOfLines = 0
        self.addSubview(self.titleLabel!)
        
        self.vTextField = UITextField(frame: CGRect(x: 14, y: height/2 - 1, width: width - 28, height: height/2 - 5))
        self.vTextField?.textColor = .black
        self.vTextField?.font = .fontMedium(17)
        self.vTextField?.delegate = self
        self.addSubview(vTextField!)
        
        self.separatorView = UIView(frame: CGRect(x: 14, y: height-1, width: width-28, height: 1))
        self.separatorView?.backgroundColor = .colorFromHex("CACACA")
        
        self.addSubview(separatorView!)
        
        let bt = UIButton(frame: andFrame)
        self.addSubview(bt)
        self.sendSubviewToBack(bt)
        let wSelf = self
        
        let confirmBtn = VNBButton(initConfirmBtn: confirmBtnLbl, andFrame: CGRect(x: self.xRight - 77 - 14, y: self.y + 20, width: 77, height: 24))
        self.addSubview(confirmBtn)

        confirmBtn.addAction {
            callback()
        }
        
        bt.addAction {
            if wSelf.vTextField!.isFirstResponder {
                wSelf.vTextField!.resignFirstResponder()
            } else {
                wSelf.vTextField!.becomeFirstResponder()
            }
        }
        
        self.validateCharater()
    }

    private func validateCharater() {
        switch typeInput {
        case .INPUT_TYPE_NUMBER:
            max_length = 10
            vTextField!.keyboardType = .numberPad
        case .INPUT_TYPE_NAME:
            break
        case .INPUT_TYPE_EMAIL:
            max_length = 256
            vTextField!.keyboardType = .emailAddress
        default:
            break
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func layoutSubviews() {
        widthh = frame.size.width
        heightt = frame.size.height
       
        super.layoutSubviews()
    }
    
    func setUpView(title: String?, andType: InputType, andIsRequired: Bool) {

        self.layoutSubviews()
        self.backgroundColor = .white
        typeInput = andType
        selfPadding = 14
        self.titleLabel = UILabel(frame: CGRect(x: 14, y: 10, width: widthh - 28, height: heightt/2 - 11))
        self.titleLabel?.font = .fontMedium(13)
        let titleStr = andIsRequired ? "\(title!)*" : title
        let string = NSMutableAttributedString(string: titleStr!)
        
        if andIsRequired {
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("919191"), range: NSRange(location: 0, length: titleStr!.count - 1))
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("FF5C22"), range: NSRange(location: titleStr!.count - 1, length: 1))
        } else {
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("919191"), range: NSRange(location: 0, length: titleStr!.count))
        }
        
        self.titleLabel?.attributedText = string
        self.titleLabel?.numberOfLines = 0
        self.addSubview(self.titleLabel!)
        
        self.vTextField = UITextField(frame: CGRect(x: 14, y: heightt/2 - 1, width: widthh - 28, height: heightt/2 - 5))
        self.vTextField?.textColor = .black
        self.vTextField?.font = .fontMedium(17)
        self.vTextField?.delegate = self
        self.addSubview(vTextField!)
        
        self.separatorView = UIView(frame: CGRect(x: 14, y: heightt-1, width: widthh-28, height: 1))
        self.separatorView?.backgroundColor = .colorFromHex("CACACA")
        self.addSubview(separatorView!)
        
        let bt = UIButton(frame: frame)
        self.addSubview(bt)
        self.bringSubviewToFront(bt)
        let wSelf = self
        
        bt.addAction {
            if wSelf.vTextField!.isFirstResponder {
                wSelf.vTextField!.resignFirstResponder()
            } else {
                wSelf.vTextField!.becomeFirstResponder()
            }
        }
        self.validateCharater()
    }
    
    
}

extension DTTextInputView: UITextFieldDelegate {
        
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
        
        if typeInput == .INPUT_TYPE_NAME_VI {
           
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
        
        if typeInput == .INPUT_TYPE_EXPIRYDATE {
            
        }
        
        return true
    }
}

extension DTTextInputView {
    
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
        case .INPUT_TYPE_NAME_VI:
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
