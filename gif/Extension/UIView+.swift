//
//  UIView+.swift
//  gif
//
//  Created by Duy Tran on 05/09/2022.
//

import UIKit


extension UIView {
    public var safeAreaFrame: CGRect {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.layoutFrame
        }
        return bounds
    }
    
    func roundCorners(radius: CGFloat = 10, corners: UIRectCorner = .allCorners) {
            self.clipsToBounds = true
            self.layer.cornerRadius = radius
            if #available(iOS 11.0, *) {
                var arr: CACornerMask = []
                
                let allCorners: [UIRectCorner] = [.topLeft, .topRight, .bottomLeft, .bottomRight, .allCorners]
                
                for corn in allCorners {
                    if(corners.contains(corn)){
                        switch corn {
                        case .topLeft:
                            arr.insert(.layerMinXMinYCorner)
                        case .topRight:
                            arr.insert(.layerMaxXMinYCorner)
                        case .bottomLeft:
                            arr.insert(.layerMinXMaxYCorner)
                        case .bottomRight:
                            arr.insert(.layerMaxXMaxYCorner)
                        case .allCorners:
                            arr.insert(.layerMinXMinYCorner)
                            arr.insert(.layerMaxXMinYCorner)
                            arr.insert(.layerMinXMaxYCorner)
                            arr.insert(.layerMaxXMaxYCorner)
                        default: break
                        }
                    }
                }
                self.layer.maskedCorners = arr
            } else {
                self.roundCornersBezierPath(corners: corners, radius: radius)
            }
        }
        
        private func roundCornersBezierPath(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }    

    var nsHeight: NSLayoutConstraint {
        var heightConstraint = NSLayoutConstraint()
        for i in self.constraints {
            if i.firstAttribute == .height {
                heightConstraint = i
                break
            }
        }
        return heightConstraint
    }
    
    
}
