//
//  iconCell.swift
//  gif
//
//  Created by Duy Tran on 31/08/2022.
//

import UIKit

class iconCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIImageView!
    var isAnimate: Bool! = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupUI(value: item, setHightLight: Bool, didExpandTabbar: Bool) {
        self.title.text = "\(value.title)"
        if isHighlighted {
            if didExpandTabbar {
                if value.iconHightLight != "" {
                    self.icon.image = UIImage(named: "\(value.iconHightLightNotCircle)")
                }
            }
        } else {
            if didExpandTabbar {
                self.icon.image = UIImage(named: "\(value.icon)")
            } else {
                self.icon.image = UIImage(named: "\(value.iconNotCircle)")
            }
        }
    }
    
    func startAnimate() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.duration = 0.05
        shakeAnimation.repeatCount = 4
        shakeAnimation.autoreverses = true
        shakeAnimation.duration = 0.2
        shakeAnimation.repeatCount = 99999
        
        let startAngle: Float = (-2) * 3.14159/180
        let stopAngle = -startAngle
        
        shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
        shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
        shakeAnimation.autoreverses = true
        shakeAnimation.timeOffset = 290 * drand48()
        
        let layer: CALayer = self.layer
        layer.add(shakeAnimation, forKey:"animate")
        isAnimate = true
    }
    
    func stopAnimate() {
        let layer: CALayer = self.layer
        layer.removeAnimation(forKey: "animate")
        isAnimate = false
    }
    
}
