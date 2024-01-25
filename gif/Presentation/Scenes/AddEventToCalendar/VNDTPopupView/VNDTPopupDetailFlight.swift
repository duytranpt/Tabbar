//
//  VNDTPopupDetailFlight.swift
//  gif
//
//  Created by Duy Tran on 18/01/2024.
//

import UIKit

class VNDTPopupDetailFlight: BaseView {
    
    @IBOutlet weak var yContain: NSLayoutConstraint!
    @IBOutlet weak var vContent: UIView!
    
    override func commonInit() {
        super.commonInit()
        self.inflateView(from: "VNDTPopupDetailFlight", locatedAt: .main)

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setupUI()

    }
    
   
    
    
    func setupUI() {
        self.vContent.y = 1000

        self.vContent.roundCorners(radius:24 ,corners: [.topLeft, .topRight])
        UIView.animate(withDuration: 0.3) {
            self.vContent.y = 64
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.vContent.y = 1000
            self.alpha = 0
        } completion: { _ in
            self.hide()
        }

    }
}
