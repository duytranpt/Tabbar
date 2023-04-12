//
//  VNAValueView.swift
//  gif
//
//  Created by Duy Tran on 16/01/2023.
//

import UIKit

class VNAValueView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init?(initCardValue andFrame: CGRect, withShadow isShadow: Bool) {
        super.init(frame: andFrame)
        
        let vContainer = UIView(frame: self.bounds)
        if isShadow {
            vContainer.frame = CGRect(x: 5, y: 5, width: self.width - 10, height: self.height - 10)
        }
        self.addSubview(vContainer)
        
        let imgView = UIImageView(frame: vContainer.bounds)
        imgView.image = UIImage(named: "lotusmilesCardPlatinum")
        
        let txtColor = UIColor.white
        
        let embossedNameStr = "Tran cao duy".uppercased()
        let cardNumberStr = "190485376834291"
        let enrollmentDate = "12/22"
        let tierEndDate = "12/25"
         
        vContainer.addSubview(imgView)
        
        let alfa = vContainer.width/335
        
        let lblCardNumber = UILabel(frame: CGRect(x: 20*alfa, y: 99*alfa, width: 200*alfa, height: 15*alfa))
        lblCardNumber.text = cardNumberStr
        lblCardNumber.textColor = txtColor
        lblCardNumber.font = .fontCard(18*alfa)
        vContainer.addSubview(lblCardNumber)
        
        let lblDisplayName = UILabel(frame: CGRect(x: 21*alfa, y: 135*alfa, width: 200*alfa, height: 15*alfa))
        lblDisplayName.text = embossedNameStr
        lblDisplayName.textColor = txtColor
        lblDisplayName.font = .fontCard(11*alfa)
        vContainer.addSubview(lblDisplayName)
        
        let lblEnrollmentDate = UILabel(frame: CGRect(x: 21*alfa, y: 165*alfa, width: 65*alfa, height: 15*alfa))
        lblEnrollmentDate.text = enrollmentDate
        lblEnrollmentDate.textColor = txtColor
        lblEnrollmentDate.font = .fontCard(11*alfa)
        vContainer.addSubview(lblEnrollmentDate)
        
        let lblTierEndDate = UILabel(frame: CGRect(x: 100*alfa, y: lblEnrollmentDate.y, width: 65*alfa, height: 15*alfa))
        lblTierEndDate.text = tierEndDate
        lblTierEndDate.textColor = txtColor
        lblTierEndDate.font = .fontCard(11*alfa)
        vContainer.addSubview(lblTierEndDate)
        
        if isShadow {
            self.layer.cornerRadius = 5
            self.backgroundColor = .clear
            self.layer.shadowColor = UIColor.colorFromHex("F6E4D4").cgColor
            self.layer.shadowOpacity = 0.4
            self.layer.shadowRadius = 10
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.masksToBounds = false
        }
    }
    
    
}
