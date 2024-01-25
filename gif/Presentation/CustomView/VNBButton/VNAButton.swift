//
//  VNAButton.swift
//  gif
//
//  Created by Duy Tran on 27/06/2023.
//

import UIKit

class VNAButton: UIButton {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var checkBox: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override var isSelected: Bool {
        didSet {
            imgSelected.isHidden = !isSelected
            checkBox.vCornerRadius = 12
            checkBox.layer.borderWidth = isSelected ? 0:1
            checkBox.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    @IBInspectable var Title: String = "" {
        didSet {
            lblTitle.text = Title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit() {
        Bundle.main.loadNibNamed("VNAButton", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
