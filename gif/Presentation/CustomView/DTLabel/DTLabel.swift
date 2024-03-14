//
//  DTLabel.swift
//  gif
//
//  Created by Duy Tran on 29/12/2022.
//

import UIKit

class VNDTLabel: ActiveLabel {

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
        
    func text(str: String) {
        self.text = bo_dau_Tieng_Viet(str)
    }
    
    func set(fullString: String, part: String, mainColor: UIColor, partColor: UIColor, mainFont: UIFont, partFont: UIFont, underLine: Bool,_ callback: (() -> Void)? = nil) {
        
        let customType = ActiveType.custom(pattern: String(format: "\\s%@\\b", part))
        self.enabledTypes.append(customType)
        self.customize { label in
            label.text = fullString // "Bằng việc bấm Cập nhật, Tôi đã đọc và đồng ý với chính sách bảo mật thông tin, quyền riêng tư của Vietnam Airline"
            label.textColor = mainColor
            label.font = mainFont
            
            label.customColor[customType] = partColor
            label.configureLinkAttribute = { (type, attributes, isSelected) in
                var atts = attributes
                
                switch type {
                case customType:
                    atts[NSAttributedString.Key.font] = partFont
                    if underLine {
                        atts[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
                    }
                    break
                default: ()
                }
                
                return atts
            }
            
            label.handleCustomTap(for: customType) { str in
                print(str)
                if let callback = callback {
                    callback()
                }
            }
                        
        }
    }
    
}

extension UIGestureRecognizer {
    
    func rangesOfUnderlinedText(in attributedString: NSAttributedString) -> [NSRange] {
        var ranges: [NSRange] = []
        let range = NSRange(location: 0, length: attributedString.length)
        
        attributedString.enumerateAttribute(.underlineStyle, in: range, options: []) { (value, range, _) in
            if let style = value as? Int, style != 0 {
                ranges.append(range)
            }
        }
        
        return ranges
    }
    
    func didTapAttributedTextInLabel(label: UILabel, tapLocation: CGPoint) -> Bool {
        guard let attributedText = label.attributedText else {
            return false
        }
        
        let rangesOfUnderlinedText = rangesOfUnderlinedText(in: attributedText)
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        let textStorage = NSTextStorage(attributedString: attributedText)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.size = label.bounds.size
        
        let locationOfTouchInLabel = tapLocation
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (label.bounds.size.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (label.bounds.size.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        for range in rangesOfUnderlinedText {
            if NSLocationInRange(indexOfCharacter, range) {
                return true
            }
        }
        
        return false
    }

}

extension UILabel {
    

}


extension VNDTLabel {
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
