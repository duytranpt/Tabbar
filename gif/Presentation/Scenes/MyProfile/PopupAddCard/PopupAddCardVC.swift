//
//  PopupAddCardVC.swift
//  gif
//
//  Created by Duy Tran on 09/01/2023.
//

import UIKit

class PopupAddCardVC: BaseViewController {
    
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var popupViewHeight: NSLayoutConstraint!
    @IBOutlet weak var PopupView: UIView!
    
    @IBOutlet weak var hohView: UIStackView!
    @IBOutlet weak var nomineView: UIStackView!
    @IBOutlet weak var otherView: UIStackView!
    
    @IBOutlet weak var vContentHeight: NSLayoutConstraint!
    @IBOutlet weak var vScrollviewContent: DTScrollView!
    @IBOutlet weak var vContent: UIView!
    var currentHeight:CGFloat = 400
    @IBOutlet weak var memberBtn: VNAButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .rgbColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        PopupView.roundCorners(radius: 20, corners: [.topLeft, .topRight])
        popupViewHeight.constant = screenSize.height - 85
        line.backgroundColor = .cgRGBA(rgba: "132 130 129, 0.3")
        memberBtn.isSelected = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.PopupView.y = self.view.height
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.PopupView.y = self.view.height - self.PopupView.height
        }
    }
    
    @IBAction func memberAction(_ sender: VNAButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.PopupView.y = self.view.height - self.PopupView.height
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.PopupView.y = self.view.height
        }
        self.dismiss(animated: true)
        
    }
    
    @IBAction func hohSelected(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hohView.hideAllSubviews(!sender.isSelected)
        self.changeHeight()
    }
    
    @IBAction func nomineAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        nomineView.hideAllSubviews(!sender.isSelected)
        self.changeHeight()
    }
    
    @IBAction func otherAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        otherView.hideAllSubviews(!sender.isSelected)
        self.changeHeight()
    }
    
    
    func changeHeight() {
      
        
    }
}
