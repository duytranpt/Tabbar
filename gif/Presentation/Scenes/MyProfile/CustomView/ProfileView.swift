//
//  ProfileView.swift
//  gif
//
//  Created by Duy Tran on 21/12/2022.
//

import UIKit
import SwiftyJSON

class ProfileView: UIView {

    var imgView: UIImageView?
    var nameLbl: UILabel?
    var phoneNumberLb: UILabel?
    var profileIDLbl: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    init?(initProfileView data: ProfileHomeModel, andFrame: CGRect) {
        super.init(frame: andFrame)
        setupUI()
        fillData(data: data)
    }

    func setupUI() {
        imgView = UIImageView(frame: CGRect(x: 15, y: self.height/2 - 30, width: 60, height: 60))
        imgView?.image = UIImage(named: "componantAvatarProfile")
        self.addSubview(imgView!)
        
        let contentView = UIView(frame: CGRect(x: imgView!.xRight + 20, y: self.height/2 - 27, width: self.width - 15*2 - 60 - 20, height: 54))
        self.addSubview(contentView)
        
        nameLbl = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.width, height: 20))
        nameLbl?.font = .fontBold(17)
        nameLbl?.textColor = .cgRGB(rgb: "47 47 47")
        nameLbl?.text = "---"
        
        phoneNumberLb = UILabel(frame: CGRect(x: 0, y: nameLbl!.yBottom + 2, width: contentView.width, height: 15))
        phoneNumberLb?.font = .fontMedium(13)
        phoneNumberLb?.textColor = .cgRGB(rgb: "144 144 144")

        profileIDLbl = UILabel(frame: CGRect(x: 0, y: phoneNumberLb!.yBottom + 2, width: contentView.width, height: 15))
        profileIDLbl?.font = .fontBold(13)
        profileIDLbl?.textColor = .cgRGB(rgb: "219 163 16")
        profileIDLbl?.text = "My Proflie ID:"

        contentView.addSubview(nameLbl!)
        contentView.addSubview(phoneNumberLb!)
        contentView.addSubview(profileIDLbl!)
        
    }
    
    func fillData(data: ProfileHomeModel) {
        nameLbl?.text = data.displayName.count > 0 ? data.displayName : "---"
        phoneNumberLb?.text = data.phoneNumber
        profileIDLbl?.text = "My Proflie ID: %@".localized(data.profileID)
    }
}


