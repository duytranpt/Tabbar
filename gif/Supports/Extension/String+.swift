//
//  String+.swift
//  gif
//
//  Created by Duy Tran on 09/09/2022.
//

import UIKit

extension String {
    
    var isValidEmail: Bool? {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    func localized(table: String? = nil, bundle: Bundle = .main, _ args: CVarArg...) -> String {
        return String(format: NSLocalizedString(self, tableName: table, bundle: bundle, value: self, comment: ""), args.first!)
    }
    
    func localized(table: NSString? = nil, bundle: Bundle = .main, _ args: CVarArg...) -> NSString {
        return NSString(format: NSLocalizedString(self, tableName: table as String?, bundle: bundle, value: self, comment: "") as NSString, args.first!)
    }

    
    func bo_dau_Tieng_Viet() -> String? {
        var vn = replacingOccurrences(of: "đ", with: "d")
        vn = vn.replacingOccurrences(of: "Đ", with: "D")
        let data = vn.data(using: .ascii, allowLossyConversion: true)
        var en: String? = nil
        if (data != nil) {
            en = String(data: data!, encoding: .ascii)
        }
        return en
    }
    
    func string_not_empty() -> Bool? {
        if self == nil {
            return false
        }
        
        if self.trim()?.count ?? 0 > 0 {
            return true
        }

        return false
    }
    
    func trimm() -> String? {
        return trimmingCharacters(in: .whitespaces)
    }
    
    func reformatDateString(fromFormat ff: String?, toFormat tf: String?) -> String? {

        let fmt = DateFormatter()
        fmt.calendar = Calendar(identifier: .gregorian)
        fmt.locale = Locale(identifier: "vi_VN")
        fmt.dateFormat = ff
        let dt = fmt.date(from: self)
        fmt.dateFormat = tf
        if (dt != nil) {
            return fmt.string(from: dt!)
        }
        return ""
    }

}

extension NSString {

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont, widthLimit: CGFloat) -> CGSize {
        
        let style = NSParagraphStyle.default
        let attributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: style
        ]
        
        let attributedText = NSAttributedString(
            string: self as String,
            attributes: attributes)
        
        let rect = attributedText.boundingRect(with: CGSize(width: widthLimit, height: CGFloat.greatestFiniteMagnitude),
                                               options: .usesLineFragmentOrigin,
                                               context: nil)
        
        
        return rect.size
        
    }
    
    func sizeOfString(string: String, constrainedToWidth width: Double) -> CGSize {
        return NSString(string: string).boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: self],
            context: nil).size
    }
}

extension String {
    
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    
}

extension String {
    func trim() -> String? {
        var trimmedString = self
        trimmedString.replacingOccurrences(of: " ", with: "")
        return trimmedString
    }
}



public extension NSObject {
    
    class func className() -> String {
        let className = (NSStringFromClass(self) as String).components(separatedBy: ".").last! as String
        return className
    }
    
    func className() -> String {
        let className = (NSStringFromClass(self.classForCoder) as String).components(separatedBy: ".").last! as String
        return className
    }
    
}


extension NSString {
    func sizeOfString(withFont: UIFont, widthLimit: CGFloat) -> CGSize {
        
        let style = NSParagraphStyle.default
        let attributes = [
            NSAttributedString.Key.font: withFont,
            NSAttributedString.Key.paragraphStyle: style
        ]
        
        let attributedText = NSAttributedString(
            string: self as String,
            attributes: attributes)
        
        let rect = attributedText.boundingRect(with: CGSize(width: widthLimit, height: CGFloat.greatestFiniteMagnitude),
                                               options: .usesLineFragmentOrigin,
                                               context: nil)
        
        
        return rect.size
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func excludingLast(char:Int) -> String {
        return String(self.prefix(self.count - char))
    }
    
    func excludingFirst(char:Int) -> String {
        return String(self.suffix(self.count - char))
    }
}

extension String {
    func localizeString() -> String {
        if let path = Bundle.main.path(forResource: App.Lang, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        }
        return self
    }
}
