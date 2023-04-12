//
//  CheckPhoneNumber.swift
//  gif
//
//  Created by Duy Tran on 23/12/2022.
//

import UIKit

class CheckPhoneNumber: BaseViewController {

    @IBOutlet weak var number2: UITextField!
    
    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    @IBOutlet weak var number1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setHeader(title: "Lấy danh bạ", subTitle: "", Type: .ONE_LINE_SIMPLE)
        navbarHeight.constant = self.navigationBarView!.height
        
    }
    
    @IBAction func check(_ sender: Any) {
        if checkPhoneNumber(sdt1: number1.text ?? "", sdt2: number2.text ?? "") {
            self.view.backgroundColor = .orange
        } else {
            self.showNewAlertOkay(withMessage: "Phone number not match") { }
        }
    }
    
    func checkPhoneNumber(sdt1: String, sdt2: String) -> Bool {

        let phoneNumber1 = sdt1.trim()!.reversed()
        let phoneNumber2 = sdt2.trim()!.reversed()
        
        let arrSdt1 = Array(phoneNumber1)
        let arrSdt2 = Array(phoneNumber2)
        var cout = 0
        if sdt1.count <= sdt2.count {
            print(arrSdt1)
            print(arrSdt2)
            for i in 0...sdt1.count-1 {
                if arrSdt1[i] == arrSdt2[i] {
                    cout += 1
                }
            }
        }
        
        if cout > 8 {
            return true
        }
        
        return false
    }
}
