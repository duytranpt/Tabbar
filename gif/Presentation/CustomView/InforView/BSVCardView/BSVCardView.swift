//
//  BSVCardView.swift
//  gif
//
//  Created by Duy Tran on 03/01/2023.
//

import UIKit

class BSVCardView: BaseView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bsvInputView: UIView!
    
    
    @IBOutlet weak var messLlb: UILabel!
    @IBOutlet weak var displayCardNumberView: UIView!
    @IBOutlet weak var displayNameView: UIView!
    @IBOutlet weak var displayCardRankView: UIView!
    @IBOutlet weak var sperator: NSLayoutConstraint!
    @IBOutlet weak var inforSTV: UIStackView!
    
    override func commonInit() {
        let nib = UINib(nibName: "BSVCardView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        setupUI()
        
    }

    func setupUI() {
        titleLbl.text = "Thông tin tài khoản bông sen vàng"
        titleLbl.textColor = .cgRGB(rgb: "0 104 133")
        titleLbl.font = .fontMedium(15)
        messLlb.text = ""
        messLlb.textColor = .cgRGB(rgb: "196 37 63")
        messLlb.font = .fontMedium(11)
        var demoview: DTTextInputView!
        demoview = DTTextInputView(newInputViewWithTitle: "Số thẻ bông sen vàng", andType: .INPUT_TYPE_NUMBER, andIsRequired: true,confirmBtnLbl: "Xác nhận", andFrame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 59)), callback: { [weak self] in
            guard let wSelf = self else { return }
            guard let bsvNumber = demoview.vTextField?.text!.count else { return }
            
            if bsvNumber >= 10 {
                wSelf.inforSTV.isHidden = false
                wSelf.messLlb.text = ""
                wSelf.displayCardNumberView.isHidden = true
                wSelf.displayNameView.isHidden = false
                wSelf.displayCardRankView.isHidden = false
                wSelf.sperator.constant = 16
                wSelf.height = 201
                wSelf.layoutIfNeeded()
            } else {
                wSelf.inforSTV.isHidden = true
                wSelf.sperator.constant = 24
                wSelf.messLlb.text = "Số tài khoản bsv không đúng"
            }
        })
        demoview.setPlaceholder("Nhập số thẻ bông sen vàng")
        bsvInputView.addSubview(demoview)
    }
    
    func clearAllData() {
        
    }

}
