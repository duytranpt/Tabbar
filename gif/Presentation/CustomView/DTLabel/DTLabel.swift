//
//  DTLabel.swift
//  gif
//
//  Created by Duy Tran on 29/12/2022.
//

import UIKit

class DTLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    func commonInit() {
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        self.textColor = .text_gray_color
        self.contentMode = .topLeft
    }
    
    func formatText(fullString: NSString, boldPartOfString: [NSString], font: UIFont!, boldFont: UIFont, color: UIColor, underLine: Bool) {
        self.attributedText = setupText(fullString: fullString, boldPartOfString: boldPartOfString, font: font, boldFont: boldFont, color: color, underLine: underLine)
    }
    
    private func setupText(fullString: NSString, boldPartOfString: [NSString], font: UIFont, boldFont: UIFont, color: UIColor, underLine: Bool) -> NSAttributedString {
        
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font]
        let boldString = NSMutableAttributedString(string: fullString as String, attributes:nonBoldFontAttribute)
        
        for i in boldPartOfString {
            let boldFontAttribute = [NSAttributedString.Key.font:boldFont]
            boldString.addAttributes(boldFontAttribute, range: fullString.range(of: i as String))
            let colorAttribute = [NSAttributedString.Key.foregroundColor: color]
            boldString.addAttributes(colorAttribute, range: fullString.range(of: i as String))
            if underLine {
                let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
                boldString.addAttributes(underlineAttribute, range: fullString.range(of: i as String))
            }
        }

        return boldString
    }
    
    func tapLabel(key: [NSString], action: @escaping (Int) -> Void) {
        self.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer { recognizer in
            for (index, element) in key.enumerated() {
                let text = (self.text)!
                let termsRange: NSRange = (text as NSString).range(of: element as String)
                if recognizer.didTapAttributedTextInLabel(label: self, inRange: termsRange) {
                    action(index)
                    break
                }
            }
            
        }
        self.addGestureRecognizer(tapRecognizer)
    }
    
    func text(str: String) {
        self.text = bo_dau_Tieng_Viet(str)
    }
    
}

extension UIGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}


extension DTLabel {
    func bo_dau_Tieng_Viet(_ str: String?) -> String? {
        var vn = str?.replacingOccurrences(of: "đ", with: "d")
        vn = vn?.replacingOccurrences(of: "Đ", with: "D")
        let data = vn?.data(using: .ascii, allowLossyConversion: true)
        var en: String? = nil
        if (data != nil) {
            en = String(data: data!, encoding: .ascii)
        }
        return en
    }
}
