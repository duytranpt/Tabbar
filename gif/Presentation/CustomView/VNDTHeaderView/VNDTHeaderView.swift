//
//  VNDTHeaderView.swift
//  gif
//
//  Created by Duy Tran on 14/12/2022.
//

import UIKit

class VNDTHeaderView: UIView {

    enum VNDTHEADERTYPE : Int {
        case ONE_LINE_SIMPLE
        case ONE_LINE_DES
        case TWO_LINE
    }
    var backButton: VNBButton?
    var rightButton: VNBButton?
    var homeButton: VNBButton?
    var titleLabel: UILabel?
    var subTitleLabel: UILabel?
    var imgBongSen: UIImageView?
    var gradientView: CAGradientLayer?
    weak var navC: UINavigationController?
    
    init?(initHeaderView title: String?, subTitle: String?, type: VNDTHEADERTYPE, nav: UINavigationController?, andFrame: CGRect) {
        super.init(frame: andFrame)
        
        let margin_Y: CGFloat = 13
        let s_Height_Header = self.HEADER_HEIGH()
        let s_Height_StatusBar = self.HEADER_STATUSBAR()
        
        self.backgroundColor = .orange
        self.navC = nav
        self.titleLabel = UILabel()
        self.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        self.titleLabel?.textColor = .white
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.text = title
        
        self.subTitleLabel = UILabel()
        self.subTitleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        self.subTitleLabel?.textColor = .white
        self.subTitleLabel?.textAlignment = .center
        self.subTitleLabel?.numberOfLines = 0
        self.subTitleLabel?.text = subTitle
        
        self.imgBongSen = UIImageView(frame: CGRect(x: 0, y: self.height - self.height*89/100, width: self.height*131/100, height: self.height*89/100))
        self.imgBongSen?.image = UIImage(named: "maskGroup67")
        switch type {
        case .ONE_LINE_SIMPLE:
            self.titleLabel?.frame = CGRect(x: s_Height_Header - s_Height_StatusBar + margin_Y, y: s_Height_StatusBar, width: self.width - 2*(s_Height_Header - s_Height_StatusBar + margin_Y), height: s_Height_Header - s_Height_StatusBar)
            self.backButton = VNBButton(HeaderButton: "icArrowbackWhite", isRight: false, rect: CGRect(x: 0, y: self.titleLabel!.y, width: self.titleLabel!.height, height: self.titleLabel!.height))
            
            self.rightButton = VNBButton(HeaderButton: "icArrowbackWhite", isRight: true, rect: CGRect(x: self.width - 44, y: self.backButton!.y, width: 44, height: 44))
            
        case .ONE_LINE_DES:
            break
        case .TWO_LINE:
            self.backButton = VNBButton(HeaderButton: "icArrowbackWhite", isRight: false, rect: CGRect(x: 0, y: s_Height_StatusBar, width: s_Height_Header - s_Height_StatusBar, height: s_Height_Header - s_Height_StatusBar))
            self.rightButton = VNBButton(HeaderButton: "", isRight: true, rect: CGRect(x: self.width - self.backButton!.width, y: self.backButton!.y, width: self.backButton!.width, height: self.backButton!.height))
            
            self.titleLabel?.frame = CGRect(x: self.backButton!.xRight, y: self.backButton!.y, width: self.width - 2*self.backButton!.xRight, height: self.backButton!.height/2)
            self.subTitleLabel?.frame = CGRect(x: self.titleLabel!.x, y: self.titleLabel!.yBottom, width: self.titleLabel!.width, height: self.backButton!.height/2)
        }
        
        self.addSubview(titleLabel!)
        self.addSubview(subTitleLabel!)
        self.addSubview(backButton!)
        self.addSubview(imgBongSen!)
        backButton?.addAction {
            self.navC?.popViewController(animated: true)
            print("PopVC")
        }
        
        gradientView = CAGradientLayer()
        gradientView?.frame = self.frame
        gradientView?.locations = [0, 1]
        gradientView?.colors = [
            UIColor.cgRGB(rgb: "45 103 130").cgColor,
            UIColor.cgRGB(rgb: "2 57 91").cgColor
        ]
        self.layer.insertSublayer(gradientView!, at: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    
    func setTitle(_ title: String) {
        self.titleLabel?.text = title
    }
    
    func showRightButton(action: @escaping () -> Void) {
        self.addSubview(rightButton!)
        rightButton?.imgView?.image = UIImage(named: "icCloseWhiteNew")
        rightButton?.addAction {
            action()
        }
    }
    
    func removeGradient() {
        if (gradientView != nil) {
            self.gradientView?.removeFromSuperlayer()
            self.gradientView = nil
        }
    }
    
    func addCustomView(_ viewMore: UIView) {
        viewMore.y = self.height
        viewMore.alpha = 1;
        self.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height + viewMore.height)
        self.imgBongSen?.frame = CGRect(x: 0, y: self.height - self.height*89/100, width: self.height*131/100, height: self.height*89/100)
        self.addSubview(viewMore)
        if gradientView != nil {
            gradientView?.frame = self.frame
        }
    }
    
    func showRightButtonWithImg(img: String, _ callback: @escaping () -> Void) {
        self.addSubview(rightButton!)
        rightButton?.imgView?.frame = rightButton!.bounds
        self.rightButton?.imgView?.image = UIImage(named: img)
        self.rightButton?.addAction {
            callback()
        }
    }
    
}
