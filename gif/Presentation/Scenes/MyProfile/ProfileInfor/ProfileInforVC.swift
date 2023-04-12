//
//  ProfileInforVC.swift
//  gif
//
//  Created by Duy Tran on 30/12/2022.
//

import UIKit

class ProfileInforVC: BaseViewController {

    @IBOutlet weak var mainViewContent: InforView!
    @IBOutlet weak var scrollView: DTScrollView!
    @IBOutlet weak var navbarHeight: NSLayoutConstraint!

    let dataModel = UserDefaults.getInfor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setHeader(title: "Thông tin tài khoản", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navbarHeight.constant = self.navigationBarView!.height
        self.mainViewContent.mainView = self.view
        self.mainViewContent.navC = self.navigationBarView?.navC
        self.hideAllButton()
        if dataModel?.registered == 1 {
            self.mainViewContent.fillData(data: dataModel!)
        }
    }
    
}
