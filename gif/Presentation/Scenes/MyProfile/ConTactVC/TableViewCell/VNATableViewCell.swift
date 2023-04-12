//
//  VNATableViewCell.swift
//  gif
//
//  Created by Duy Tran on 06/01/2023.
//

import UIKit

class VNATableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var displayNumber: UILabel!
    @IBOutlet weak var displayGender: UILabel!
    @IBOutlet weak var displayDob: UILabel!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    var setMoreAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func fillData(data: [ResponseListPax], indexPath: IndexPath) {
        let pax = data[indexPath.section]
        let coutPax = indexPath.section + 1
        self.titleLbl.text = "Hành khách %@".localized(String(coutPax))
        self.displayNumber.text = pax.phone
        self.displayGender.text = pax.gender == 1 ? "Nam" : "Nữ"
        self.displayDob.text = pax.dob?.reformatDateString(fromFormat: "yyyy-MM-dd", toFormat: "dd/MM/yyyy")
        self.displayName.text = "\(pax.lastNameFull ?? "") \(pax.firstNameFull ?? "")"
        
    }
    
    @IBAction func moreAction(_ sender: Any) {
        if (self.setMoreAction != nil) {
            self.setMoreAction!()
        }
    }
    
}

