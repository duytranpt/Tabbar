//
//  OTPVC.swift
//  gif
//
//  Created by Duy Tran on 17/01/2023.
//

import UIKit

class OTPVC: BaseViewController {

    
    @IBOutlet weak var OtpView: OTPStackView!
    @IBOutlet weak var validateOtpLbl: UILabel!
    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLbl: DTLabel!
    
    var phoneNumber: NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setHeader(title: "Xác thực mã OTP", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navbarHeight.constant = self.navigationBarView!.height
        
        let fullString: NSString = "Vui lòng nhập mã xác thực được gửi về số điện thoại %@ của  Quý khách".localized(phoneNumber)
        let arrHightLight: [NSString] = [phoneNumber]
        titleLbl.formatText(fullString: fullString, boldPartOfString: arrHightLight
                            , font: .fontRegular(15), boldFont: .fontBold(15), color: .cgRGB(rgb: "144 144 144"), underLine: false)
        
    }
    
    func showAlertWithText(_ text: String) {
        validateOtpLbl.isHidden = false
        validateOtpLbl.text = text
    }

    @IBAction func resendOTP(_ sender: Any) {
        
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        if OtpView.getOTP() == "" || OtpView.getOTP().count < 6 {
            self.showAlertWithText("Mã OTP cần đủ 6 kí tự, quý khách vui lòng kiểm tra lại")
            return
        }
        
        if OtpView.getOTP() != "000000" {
            self.showAlertWithText("Mã OTP không đúng, vui lòng nhập lại")
            return
        }
        
        validateOtpLbl.isHidden = true
        let storyBoard = UIStoryboard(name: "HomeMyProfileViewController", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeMyProfileVC") as! HomeMyProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

