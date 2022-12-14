//
//  ContactCell.swift
//  gif
//
//  Created by Duy Tran on 14/09/2022.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var DisplayName: UILabel!
    @IBOutlet weak var PhoneNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(data: [FetchedContact], indexPath: IndexPath) {
        self.DisplayName.text = data[indexPath.row].firstName + data[indexPath.row].lastName
        self.PhoneNumber.text = data[indexPath.row].telephone
        
    }
    
}
