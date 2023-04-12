//
//  AddNewContactVC.swift
//  gif
//
//  Created by Duy Tran on 06/01/2023.
//

import UIKit

class AddNewContactVC: BaseViewController {

    @IBOutlet weak var mainViewContent: InforView!
    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setHeader(title: "Thêm hồ sơ", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navbarHeight.constant = self.navigationBarView!.height
        self.mainViewContent.mainView = self.view
        self.mainViewContent.navC = self.navigationBarView?.navC
        mainViewContent.secondSV.isHidden = true
        mainViewContent.phoneNumberView.isHidden = false
        mainViewContent.clearAllContentBtn.isHidden = true
        mainViewContent.privacyPolicyView.isHidden = true
        mainViewContent.btnDocView.isHidden = false
        mainViewContent.lastSV.isHidden = true
        self.hideAllButton()
        
        mainViewContent.setConfirmAction = { [weak self] in
            guard let wSelf = self else { return }
            print(wSelf.mainViewContent.paxData())
//            UserDefaults.addPax(wSelf.mainViewContent.paxData())
            wSelf.mainViewContent.checkNil()
        }
    }
    
}
