//
//  VNAInputView.swift
//  gif
//
//  Created by Duy Tran on 29/08/2022.
//

import UIKit

class VNAInputView: UIView {
    
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var InputTF: UITextField!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        Bundle.main.loadNibNamed("VNAInputView", owner: self)
        contentView.fixInView(self)
        self.addSubview(contentView)
        
        TitleLbl.text = ""
        TitleLbl.textColor = .rgbColor(red: 144, green: 144, blue: 144, alpha: 1)
        TitleLbl.font = .systemFont(ofSize: 13, weight: .medium)
        
        InputTF.textColor = .rgbColor(red: 47, green: 47, blue: 47, alpha: 1)
        InputTF.text = ""
        InputTF.font = .systemFont(ofSize: 17, weight: .medium)
        
        Button.setTitle("", for: .normal)
        
    }
    
    public func setupInput(title: String, type: INPUT_TEXTFIELD_TYPE, isRe: Bool) {
        
    }
    
}
