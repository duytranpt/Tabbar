//
//  VNALoading.swift
//  gif
//
//  Created by Duy Tran on 06/02/2023.
//

import UIKit
import Lottie

class VNALoading: UIView {

    var loadingAnimation: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init?(initVer2 bgColor: UIColor?) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)))
        self.backgroundColor = UIColor.red
//        self.loadingAnimation = AnimationView(name: "VNALoading")
//        self.loadingAnimation?.frame = CGRect(origin: .zero, size: CGSize(width: 90, height: 90))
//        self.loadingAnimation?.center = self.center
//        self.addSubview(loadingAnimation!)
//
//        self.loadingAnimation?.loopMode = .loop
//        self.loadingAnimation?.animationSpeed = 1
//        self.loadingAnimation?.play()
        
//        self.loadingAnimation = .init(name: "VNALoading")
//        self.loadingAnimation!.frame = self.bounds
    
//        self.loadingAnimation!.contentMode = .scaleAspectFit
//        self.loadingAnimation!.loopMode = .loop
//        self.loadingAnimation!.animationSpeed = 1
//        self.addSubview(loadingAnimation!)
//        self.loadingAnimation!.play()
        
//        self.addAction { [weak self] in
//            let wSelf = self
//            wSelf?.closeLoading()
//        }
        
    }
    
    func closeLoading() {
        self.removeFromSuperview()
    }
    
    class func hide() {
        let loading = UIApplication.shared.delegate?.window??.viewWithTag(19832017) as? VNALoading
        if loading == nil || !(loading is VNALoading) {
            return
        }
        if let loading {
            NSObject.cancelPreviousPerformRequests(withTarget: loading)
        }
        loading?.isHidden = true
        loading?.removeFromSuperview()
    }

    class func show() {
        self.hide()
        let wd = UIApplication.shared.delegate?.window
        let loading = VNALoading.init(initVer2: UIColor(red: 255, green: 255, blue: 255, alpha: 0.7))
        loading?.tag = 19832017
        wd?!.addSubview(loading!)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
