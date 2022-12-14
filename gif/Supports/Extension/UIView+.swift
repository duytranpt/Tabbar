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

extension UIView {
    func fixInView(_ superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
    }
}


extension UIView {
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
    
    
    @IBInspectable
    public var BGHexColor: String {
        set {
            self.backgroundColor = .colorFromHex(newValue)
        }
        get {
            (self.backgroundColor?.hexStringFromColor(color: self.backgroundColor!))!
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.borderWidth
        } set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.black
        } set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var vCornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor.clear
        } set {
            self.layer.masksToBounds = false
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        } set {
            self.layer.shadowRadius = newValue
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        } set {
            self.layer.shadowOffset = newValue
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        } set {
            self.layer.shadowOpacity = newValue
            self.layer.masksToBounds = false
        }
    }
    
    func addAction(action: @escaping () -> Void) {
        let tapRecognizer = UITapGestureRecognizer { recognizer in
            action()
        }
        self.addGestureRecognizer(tapRecognizer)
    }
    
    var safeAreaTop: CGFloat {
        var topSafeAreaHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            topSafeAreaHeight = safeFrame.minY
        }
        return topSafeAreaHeight
    }

    func navbarHeight() -> CGFloat {
        var height: CGFloat = 64
        if checkiPhoneX() {
            height += 36
        }
        return height
    }
    
    func checkiPhoneX() -> Bool {
        return safeAreaTop > 20 ?  true : false
    }
    
    func HEADER_STATUSBAR() -> CGFloat {
        var height: CGFloat = 20
        if checkiPhoneX() {
            height = safeAreaTop
        }
        return height
    }
    
    func HEADER_HEIGH() -> CGFloat {
        var height: CGFloat = 64
        if checkiPhoneX() {
            height = safeAreaTop + 44
        }
        return height
    }

}

extension UIView {
    var x: CGFloat {
        get {
            self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var width: CGFloat {
        get {
            self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var xRight: CGFloat {
        get {
            self.frame.origin.x + self.width
        }
        set {
            self.x = newValue - self.width
        }
    }
    
    var yBottom: CGFloat {
        get {
            self.y + self.height
        }
        set {
            self.y = newValue - self.height
        }
    }
    
    var origin: CGPoint {
        get {
            self.frame.origin
        }
        set {
            var r = frame
            r.origin = newValue
            frame = r
        }
    }
    
    var size: CGSize {
        get {
            self.frame.size
        }
        set {
            var r = frame
            r.size = newValue
            frame = r
        }
    }
    var centerY: CGFloat {
        get {
            self.center.y
        }
        set {
            self.center = CGPoint(x: self.centerX, y: newValue)
        }
    }
    
    var centerX: CGFloat {
        get {
            self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.centerY)
        }
    }

}

extension UIView {
    func addDashedBorder(lineWidth: CGFloat, color: UIColor) {
      let shapeLayer:CAShapeLayer = CAShapeLayer()
      let shapeRect = CGRect(x: 0, y: 0, width: self.width, height: self.height)
      
      shapeLayer.bounds = shapeRect
      shapeLayer.position = CGPoint(x: self.width/2, y: self.height/2)
      shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
      shapeLayer.lineWidth = lineWidth
      shapeLayer.lineJoin = CAShapeLayerLineJoin.round
      shapeLayer.lineDashPattern = [6,3]
      shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: self.vCornerRadius).cgPath
      
      self.layer.addSublayer(shapeLayer)
  }
}

extension UIView {
    // Remove all subview
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    // Remove all subview with specific type
    func removeAllSubviews<T: UIView>(type: T.Type) {
        subviews
            .filter { $0.isMember(of: type) }
            .forEach { $0.removeFromSuperview() }
    }
}
