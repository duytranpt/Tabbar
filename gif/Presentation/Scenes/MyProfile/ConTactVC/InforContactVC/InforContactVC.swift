//
//  InforContactVC.swift
//  gif
//
//  Created by Duy Tran on 05/01/2023.
//

import UIKit

class InforContactVC: BaseViewController {

    @IBOutlet weak var mainViewContent: InforView!
    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    
    var paxData: ResponseListPax! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setHeader(title: "Thông tin hành khách", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navbarHeight.constant = self.navigationBarView!.height
        self.mainViewContent.mainView = self.view
        self.mainViewContent.navC = self.navigationBarView?.navC
        self.hideAllButton()
        mainViewContent.secondSV.isHidden = true
        mainViewContent.phoneNumberView.isHidden = false
        mainViewContent.clearAllContentBtn.isHidden = true
        mainViewContent.privacyPolicyView.isHidden = true
        mainViewContent.btnDocView.isHidden = false
        mainViewContent.lastSV.isHidden = true
        
        if paxData != nil {
            self.mainViewContent.fillPaxData(data: paxData)
        }
        
    }
    

    

}
