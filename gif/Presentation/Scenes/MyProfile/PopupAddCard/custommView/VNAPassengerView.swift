//
//  VNAPassengerView.swift
//  gif
//
//  Created by Duy Tran on 27/06/2023.
//

import UIKit

class VNAPassengerView: UIView {

    @IBOutlet var contentView: UIView!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit() {
        Bundle.main.loadNibNamed("VNAPassengerView", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
    @IBAction func minusAction(_ sender: Any) {
        print("-")
    }
    
    @IBAction func plusAction(_ sender: Any) {
        print("+")
    }
    
    
    
}
