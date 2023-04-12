//
//  CustomSegmentedControl.swift
//  gif
//
//  Created by Duy Tran on 03/04/2023.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {
    
    private let segmentInset: CGFloat = 0
    private let segmentImage: UIImage? = UIImage(color: .red, size: CGSize(width: 100, height: 40))
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        //background
        layer.cornerRadius = bounds.height/2
        self.borderWidth = 0.5
        self.borderColor = .cgRGB(rgb: "210 165 59")
        //foreground
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView
        {
            foregroundImageView.bounds = CGRect(origin: .zero, size: CGSize(width: 100, height: 40.5)).insetBy(dx: segmentInset, dy: segmentInset)
//            foregroundImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            
            foregroundImageView.image = segmentImage
            foregroundImageView.layer.removeAnimation(forKey: "SelectionBounds")
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.layer.cornerRadius = foregroundImageView.bounds.height/2
        }
    }
    
}

extension UIImage{
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
