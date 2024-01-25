//
//  AddEventVC.swift
//  gif
//
//  Created by Duy Tran on 04/01/2023.
//

import UIKit
import EventKit
import EventKitUI

class AddEventVC: BaseViewController {
    
    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeader(title: "Tìm kiếm chuyến bay", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navbarHeight.constant = self.navigationBarView!.height
    }
    
    @IBAction func showPopupAction(_ sender: Any) {
        let vndtPopup = VNDTPopupDetailFlight(frame: CGRect(x: 0, y: 0, width: self.screenSize.width, height: self.screenSize.height))
        vndtPopup.show()
    }
    
}
