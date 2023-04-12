//
//  AppleWalletVC.swift
//  gif
//
//  Created by Duy Tran on 12/01/2023.
//

import UIKit
import PassKit

class AppleWalletVC: BaseViewController {
    
    
    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addWalletButton()
        
        self.setHeader(title: "AppleWalletVC", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navbarHeight.constant = self.navigationBarView!.height
        self.view.backgroundColor = .orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let widthCard = screenSize.width - 40
        let heightCard = 212*widthCard/335
        
        guard let newCard = VNAValueView(initCardValue: CGRect(x: 15, y: 100, width: widthCard + 10, height: heightCard + 10), withShadow: true) else { return }
        self.view.addSubview(newCard)

    }
    
    private func addWalletButton() {
        let passButton = PKAddPassButton(addPassButtonStyle: PKAddPassButtonStyle.black)
        passButton.frame = CGRect(x:  (UIScreen.main.bounds.width-280)/2, y: 150, width: 280, height: 60)
        passButton.addTarget(self, action: #selector(passButtonAction), for: .touchUpInside)
        view.addSubview(passButton)
        
    }
    
    @objc func passButtonAction() {
        print("add to wallet")
    }
}
