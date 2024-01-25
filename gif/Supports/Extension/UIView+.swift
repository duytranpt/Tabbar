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
    
    func setPositionY(_ postY: CGFloat) {
        var r = frame
        r.origin.y = Double(postY)
        UIView.animate(withDuration: 0.25, animations: { [self] in
            frame = r
        }) { finished in
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
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 20, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
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

public extension UIView {
    func popIn(duration: TimeInterval = 0.5) {
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: duration, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    func popOut(duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, delay: 1.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: nil)
    }
}


extension UIView {
    func randomNumber(length: Int) -> String {
        let letters = "1234567890"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

extension UIView {
    func hideAllSubviews(_ isHidden: Bool) {
        for subview in self.subviews {
            if !(subview is UIButton) {
                subview.isHidden = isHidden
            }
        }
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T? {
        let bundle = Bundle(for: T.self)
        let nibName = String(describing: T.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as? T
    }
}

extension UIView {
    func addTicketBorder(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        let ticketPath = UIBezierPath()
        
        // Tạo hình dạng ticket
        ticketPath.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        ticketPath.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY + cornerRadius))
        ticketPath.addArc(withCenter: CGPoint(x: bounds.minX + cornerRadius, y: bounds.minY + cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 1.5, clockwise: true)
        ticketPath.addLine(to: CGPoint(x: bounds.maxX - cornerRadius, y: bounds.minY))
        ticketPath.addArc(withCenter: CGPoint(x: bounds.maxX - cornerRadius, y: bounds.minY + cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi * 1.5, endAngle: CGFloat.pi * 2, clockwise: true)
        ticketPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        ticketPath.close()
        
        // Tạo layer cho đường viền
        let borderLayer = CAShapeLayer()
        borderLayer.path = ticketPath.cgPath
        borderLayer.lineWidth = borderWidth
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = nil
        
        // Thêm layer vào view
        layer.addSublayer(borderLayer)
    }
}

extension UIView {
    enum viewType {
        case Vertical
        case Horizontal
    }
    
    func addSemiCircleMaskToView(yPositions: [CGFloat], radiusSize: CGFloat, type: viewType) {
        let maskLayer = CAShapeLayer()
        let maskPath = UIBezierPath(rect: self.bounds)
        
       
        for y in yPositions {
            switch type {
            case.Horizontal:
                let pathTop = UIBezierPath(rect: self.bounds)
                pathTop.addArc(withCenter: CGPoint(x: y, y: 0), radius: radiusSize, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
                maskPath.append(pathTop)

                let pathBottom = UIBezierPath(rect: self.bounds)
                pathBottom.addArc(withCenter: CGPoint(x: y, y: self.bounds.size.width), radius: radiusSize, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
                maskPath.append(pathBottom)
            case .Vertical:
                let pathRight = UIBezierPath(rect: self.bounds)
                pathRight.addArc(withCenter: CGPoint(x: 0, y: y), radius: radiusSize, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
                maskPath.append(pathRight)

                let pathLeft = UIBezierPath(rect: self.bounds)
                pathLeft.addArc(withCenter: CGPoint(x: self.bounds.size.width, y: y), radius: radiusSize, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
                maskPath.append(pathLeft)
            }
        }
        
        maskLayer.path = maskPath.cgPath
        maskLayer.fillRule = .evenOdd
        self.layer.mask = maskLayer

    }
}

extension UIView {
    func initView(_ bd: Bundle) -> Any? {
        let view = bd.loadNibNamed(self.className(), owner: nil, options: nil)?.first
        return view
    }
}

extension UIView {
    func applyCornerRadius(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX + topLeft, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX - topRight, y: bounds.minY))
        path.addArc(withCenter: CGPoint(x: bounds.maxX - topRight, y: bounds.minY + topRight), radius: topRight, startAngle: CGFloat(-Double.pi / 2), endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY - bottomRight))
        path.addArc(withCenter: CGPoint(x: bounds.maxX - bottomRight, y: bounds.maxY - bottomRight), radius: bottomRight, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
        path.addLine(to: CGPoint(x: bounds.minX + bottomLeft, y: bounds.maxY))
        path.addArc(withCenter: CGPoint(x: bounds.minX + bottomLeft, y: bounds.maxY - bottomLeft), radius: bottomLeft, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: true)
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY + topLeft))
        path.addArc(withCenter: CGPoint(x: bounds.minX + topLeft, y: bounds.minY + topLeft), radius: topLeft, startAngle: CGFloat(Double.pi), endAngle: CGFloat(-Double.pi / 2), clockwise: true)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}


extension UIView {
    
    func makeDashedBorderLine() {
        let path = CGMutablePath()
        let shapeLayer = CAShapeLayer()
        let lineDashPattern: [NSNumber] = [2, 2]
        let lineDashWidth: CGFloat = 1.0
        
        shapeLayer.lineWidth = lineDashWidth
        shapeLayer.strokeColor = self.backgroundColor?.cgColor
        shapeLayer.lineDashPattern = lineDashPattern
        path.addLines(between: [CGPoint(x: bounds.minX, y: bounds.height/2),
                                CGPoint(x: bounds.maxX, y: bounds.height/2)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}

extension UIView {
    func addDottedLine(color: UIColor = .gray, dotSize: CGSize = CGSize(width: 4, height: 1), dotSpacing: CGFloat = 2) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = dotSize.height
        
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [NSNumber(value: Float(dotSize.width)), NSNumber(value: Float(dotSpacing))]
        
        shapeLayer.path = path.cgPath
        layer.addSublayer(shapeLayer)
    }
}

// MARK: Live view NibView
protocol NibView: NSObjectProtocol {
    static var nibName: String { get }
}

extension NibView where Self: UIView {
    
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    /**
     - Abstract:
        This method called to `inflateView(from:locatedAt:)` with:
        * nibName -> `Self.nibName`
        * bundle -> main bundle
    */
    func inflateView() {
        inflateView(from: Self.nibName, locatedAt: .main)
    }
    
    /**
     With this method you could specify manually the name of the nibName and the
     bundle where the view is located
     - Parameter nibName: nib name to be inflated
     - Parameter bundle: bundle where nib will be searched
    */
    func inflateView(from nibName: String, locatedAt bundle: Bundle) {
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        
        backgroundColor = .clear
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
