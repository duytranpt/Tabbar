//
//  PopupView.swift
//  gif
//
//  Created by Duy Tran on 09/01/2023.
//

import UIKit

class PopupContactView: BaseView {
    
    var setDetailAction: (() -> Void)?
    var setDeleteAction: (() -> Void)?
    
    //outlet:
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet var contentView: UIView!
        
    override func commonInit() {
        let nib = UINib(nibName: "PopupContactView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.dropShadow(color: .black, offSet: CGSize(width: -1, height: 1))
        self.sendSubviewToBack(contentView)
    }
    
    @IBAction func DeleteBtnTap(_ sender: Any) {
        if (self.setDeleteAction != nil) {
            self.setDeleteAction!()
        }
    }
    

    @IBAction func DetailBtnTap(_ sender: Any) {
        if (self.setDetailAction != nil) {
            self.setDetailAction!()
        }
    }
}
