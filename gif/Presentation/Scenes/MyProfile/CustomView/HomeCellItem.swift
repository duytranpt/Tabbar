//
//  HomeCellItem.swift
//  gif
//
//  Created by Duy Tran on 20/12/2022.
//

import UIKit

class HomeCellItem: UIView {
    
    var titleLabel: UILabel?
    var desLabel: UILabel?
    var iconImg: UIImageView?
    
    init?(newHomeItem icon: String, title: String?, des: String?, isShowLine: Bool, andFrame: CGRect) {
        
        super.init(frame: andFrame)
        let width = andFrame.size.width
        let height = andFrame.size.height
        self.backgroundColor = .white
        
        self.iconImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        self.iconImg?.centerY = height/2
        self.iconImg?.image = UIImage(named: icon)
        self.addSubview(iconImg!)
        
        self.titleLabel = UILabel(frame: CGRect(x: self.iconImg!.xRight + 17, y: 16, width: width - 56, height: 20))
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        self.titleLabel?.text = title
        self.titleLabel?.textColor = .text_Color
        self.titleLabel?.numberOfLines = 0
        self.addSubview(self.titleLabel!)
        
        self.desLabel = UILabel(frame: CGRect(x: self.iconImg!.xRight + 17, y: titleLabel!.yBottom + 2, width: width - 41, height: 15))
        self.desLabel?.textColor = .text_gray_color
        self.desLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        self.desLabel?.text = des
        self.addSubview(desLabel!)
        
        if isShowLine {
            let line = UIView(frame: CGRect(x: 0, y: self.height - 1, width: self.width, height: 1))
            line.backgroundColor = .cgRGBA(rgba: "132 130 129, 0.15")
            self.addSubview(line)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
