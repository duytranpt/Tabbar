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
    
    //Validate view:
    @IBOutlet weak var validateCardLbl: UILabel!
    @IBOutlet weak var validateNameLbl: UILabel!
    @IBOutlet weak var validateDateLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .rgbColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        PopupView.roundCorners(radius: 20, corners: [.topLeft, .topRight])
        line.backgroundColor = .cgRGBA(rgba: "132 130 129, 0.3")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.PopupView.y = self.view.height
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.PopupView.y = self.view.height - self.PopupView.height
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.PopupView.y = self.view.height - self.PopupView.height
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.PopupView.y = self.view.height
        }
        self.dismiss(animated: true)
        
    }
        
    @IBAction func confirmBtn(_ sender: Any) {
//        self.validateCardLbl.isHidden = false
//        self.validateNameLbl.isHidden = false
//        self.validateDateLbl.isHidden = false
        
        
        
        
        let storyBoard = UIStoryboard(name: "ContactViewController", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "newContactVC") as! ContactViewController
        self.navigationController?.present(vc, animated: true)
        
    }
}
