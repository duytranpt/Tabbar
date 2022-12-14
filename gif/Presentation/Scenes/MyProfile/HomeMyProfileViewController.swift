//
//  HomeMyProfileViewController.swift
//  gif
//
//  Created by Duy Tran on 14/12/2022.
//

import UIKit

class HomeMyProfileViewController: BaseViewController {

    @IBOutlet weak var navibarHight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setHeader(title: "My Profile", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navibarHight.constant = self.navigationBarView!.height
        self.showRightButtonWithImg(img: "icLogout") {
            print("Logout")
        }
    }
    


}
