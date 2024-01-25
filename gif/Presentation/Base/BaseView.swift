//
//  BaseView.swift
//  gif
//
//  Created by Duy Tran on 14/12/2022.
//

import UIKit

class BaseView: UIView, NibView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        
    }
}

extension BaseView {
    func appWindow() -> UIWindow? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let windowDelegate = windowScene.delegate as? SceneDelegate {
            return windowDelegate.window
        }
        
        return nil
    }
    
    func show() {
        let wd = self.appWindow()
        if (self.superview == nil){
            wd?.addSubview(self)
            wd?.bringSubviewToFront(self)
        }
    }
    
    func hide() {
        self.removeFromSuperview()
    }
}
