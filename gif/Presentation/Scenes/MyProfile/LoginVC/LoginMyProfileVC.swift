//
//  LoginMyProfileVC.swift
//  gif
//
//  Created by Duy Tran on 19/01/2023.
//

import UIKit
import Charts

class LoginMyProfileVC: BaseViewController {

    @IBOutlet weak var titleLbl: VNDTLabel!
    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    @IBOutlet weak var inputPhoneNumber: NewTextInputView!
    @IBOutlet weak var validatePhoneNumberLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeader(title: "My Profile", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navbarHeight.constant = self.navigationBarView!.height
        
        let fullString: NSString = "Chúng tôi mong muốn mang đến cho Quý khách trải nghiệm khác biệt với Vietnam Airlines"
        let arrHightLight: [NSString] = ["Vietnam Airlines"]
        self.titleLbl.formatText(fullString: fullString, boldPartOfString: arrHightLight, font: .fontRegular(15), boldFont: .fontBold(15), color: .cgRGB(rgb: "144 144 144"), underLine: false)
        
        self.setBackAction {
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        self.view.addAction {
            self.view.endEditing(true)
        }
    }

    func showAlertWithText(_ text: String) {
        validatePhoneNumberLbl.isHidden = false
        validatePhoneNumberLbl.text = text
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        
        if inputPhoneNumber.vTextField.text!.count < 10 {
            self.showAlertWithText("Vui lòng nhập đủ 10 số khi đăng nhập")
            return
        }
        
        if (inputPhoneNumber.vTextField.text?.first != "0") {
            self.showAlertWithText("Số điện thoại phải bắt đầu bằng số 0")
            return
        }
        
        let vc = OTPVC()
        vc.phoneNumber = inputPhoneNumber.vTextField.text! as NSString
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
