//
//  DTHeaderView.swift
//  gif
//
//  Created Duy Tran on 14/03/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: View
class DTHeaderView: BaseView {
    var gradientView: CAGradientLayer?
    @IBOutlet var vMain: UIView!
    
    // MARK: IBOutlet
    
    // MARK: View lifecycle
    override func commonInit() {
        super.commonInit()
        self.inflateView(from: "DTHeaderView", locatedAt: .main)
        self.setupView()
    }
    
    // MARK: SetupUI
    private func setupView() {

    }
    
    // MARK: IBAction
    @IBAction func leftAction(_ sender: Any) {
        print("leftAction")
    }
    
    @IBAction func rightAction(_ sender: Any) {
        print("rightAction")
    }
    
}

extension DTHeaderView {
    // MARK: @objc

}

