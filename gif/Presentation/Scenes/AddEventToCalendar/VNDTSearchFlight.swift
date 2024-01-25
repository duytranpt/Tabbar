//
//  VNDTSearchFlight.swift
//  gif
//
//  Created by Duy Tran on 18/01/2024.
//

import UIKit

class VNDTSearchFlight: BaseViewController {

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
    
    func alert(_ title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(vc, animated: true, completion: nil)
    }
}
