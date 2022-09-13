//
//  CustomButton.swift
//  gif
//
//  Created by Duy Tran on 22/08/2022.
//

import UIKit
import Lottie

class CustomButton: UIView {
    
    @IBOutlet weak var ButtonTitle: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var BackgroundAnimation: AnimationView!
    @IBOutlet weak var ButtonAnimation: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "CustomButton", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        setupUI()
    }
    
    func setupUI() {
        ButtonTitle.contentMode = .center
        ButtonTitle.textColor = .orange
        ButtonTitle.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
    func setupButton(animation: String, title: String) {
        
        BackgroundAnimation.animation = .named(animation)
        BackgroundAnimation.contentMode = .scaleAspectFit
        BackgroundAnimation.loopMode = .loop
        BackgroundAnimation.animationSpeed = 2
        BackgroundAnimation.play()
        
        ButtonTitle.text = title
        
    }

}
