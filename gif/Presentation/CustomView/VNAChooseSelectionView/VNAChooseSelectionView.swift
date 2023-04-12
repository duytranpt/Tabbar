//
//  VNAChooseSelectionView.swift
//  gif
//
//  Created by Duy Tran on 06/01/2023.
//

import UIKit

class VNAChooseSelectionView: UIView {
    var titleLabel: UILabel?
    var vTextField: UITextField?
    var separatorView: UIView?
    var selfPadding: CGFloat = 0.0
    var imgCalendar: UIImageView?
    var selectBlock: (() -> Void)?
    var widthh:Double!
    var heightt:Double!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init?(newInputViewWithTitle title: String?, andIsRequired: Bool, andFrame: CGRect) {
        
        super.init(frame: andFrame)
        let width = andFrame.size.width
        let height = andFrame.size.height
        self.backgroundColor = .white
        selfPadding = 14
        self.titleLabel = UILabel(frame: CGRect(x: 14, y: 10, width: width - 28, height: height/2 - 11))
        self.titleLabel?.font = .fontMedium(13)
        let titleStr = andIsRequired ? "\(title!)*" : title
        let string = NSMutableAttributedString(string: titleStr!)
        
        if andIsRequired {
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("919191"), range: NSRange(location: 0, length: titleStr!.count - 1))
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("FF5C22"), range: NSRange(location: titleStr!.count - 1, length: 1))
        } else {
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("919191"), range: NSRange(location: 0, length: titleStr!.count))
        }
        
        self.titleLabel?.attributedText = string
        self.titleLabel?.numberOfLines = 0
        self.addSubview(self.titleLabel!)
        
        self.vTextField = UITextField(frame: CGRect(x: 14, y: height/2 - 1, width: width - 28, height: height/2 - 5))
        self.vTextField?.textColor = .black
        self.vTextField?.font = .fontMedium(17)
        self.addSubview(vTextField!)
        
        self.separatorView = UIView(frame: CGRect(x: 14, y: height-1, width: width-28, height: 1))
        self.separatorView?.backgroundColor = .colorFromHex("CACACA")
        self.addSubview(separatorView!)
        
        self.imgCalendar = UIImageView(frame: CGRect(x: width - 16 - 15, y: height - 16 - 8, width: 16, height: 16))
        self.imgCalendar?.image = UIImage(named: "16X16ViewMore")
        self.addSubview(imgCalendar!)
        
        let bt = UIButton(frame: andFrame)
        self.addSubview(bt)
        self.sendSubviewToBack(bt)
        
        bt.addAction {
            if (self.selectBlock != nil) {
                self.selectBlock!()
            }
        }
        
        

        
    }
    
    func setUpView(title: String?, andIsRequired: Bool) {
        let widthh = frame.size.width
        let heightt = frame.size.height
        
        self.backgroundColor = .white
        selfPadding = 14
        self.titleLabel = UILabel(frame: CGRect(x: 14, y: 10, width: widthh - 28, height: heightt/2 - 11))
        self.titleLabel?.font = .fontMedium(13)
        let titleStr = andIsRequired ? "\(title!)*" : title
        let string = NSMutableAttributedString(string: titleStr!)
        
        if andIsRequired {
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("919191"), range: NSRange(location: 0, length: titleStr!.count - 1))
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("FF5C22"), range: NSRange(location: titleStr!.count - 1, length: 1))
        } else {
            string.addAttribute(.foregroundColor, value: UIColor.colorFromHex("919191"), range: NSRange(location: 0, length: titleStr!.count))
        }
        
        self.titleLabel?.attributedText = string
        self.titleLabel?.numberOfLines = 0
        self.addSubview(self.titleLabel!)
        
        self.vTextField = UITextField(frame: CGRect(x: 14, y: heightt/2 - 1, width: widthh - 28, height: heightt/2 - 5))
        self.vTextField?.textColor = .black
        self.vTextField?.font = .fontMedium(17)
        self.addSubview(vTextField!)
        
        self.separatorView = UIView(frame: CGRect(x: 14, y: heightt-1, width: widthh-28, height: 1))
        self.separatorView?.backgroundColor = .colorFromHex("CACACA")
        self.addSubview(separatorView!)
        
        self.imgCalendar = UIImageView(frame: CGRect(x: width - 16 - 15, y: height - 16 - 8, width: 16, height: 16))
        self.imgCalendar?.image = UIImage(named: "16X16ViewMore")
        self.addSubview(imgCalendar!)
        
        let bt = UIButton(frame: frame)
        self.addSubview(bt)
        self.bringSubviewToFront(bt)
        print(bt.frame)
        bt.addAction {
            if (self.selectBlock != nil) {
                self.selectBlock!()
            }
        }
    }
    
    func setPlaceholder(_ Placeholder: String!) {
        self.vTextField!.attributedPlaceholder = NSAttributedString(string: "\(Placeholder!)",attributes: [NSAttributedString.Key.foregroundColor: UIColor.cgRGB(rgb: "234 234 234")])
    }
}
