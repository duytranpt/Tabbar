//
//  PopupView.swift
//  gif
//
//  Created by Duy Tran on 15/09/2022.
//

import UIKit

class PopupView: UIView {

    @IBOutlet var contenView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
    }
    
    func setupXib() {
        Bundle.main.loadNibNamed("PopupView", owner: self)
        contenView.fixInView(self)
        contenView.roundCorners(radius: 20, corners: [.topLeft, .topRight])
    }
    
}
