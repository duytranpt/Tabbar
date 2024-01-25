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
    
    var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let swipe2Left = UISwipeGestureRecognizer(target: self, action: #selector(swipe2LeftAction(_:)))
        swipe2Left.direction = .left
        self.addGestureRecognizer(swipe2Left)
        
        deleteBtn = UIButton(frame: CGRect(x: self.contentView.width, y: 0, width: 66, height: self.contentView.height))
        deleteBtn?.backgroundColor = .red
        deleteBtn?.vCornerRadius = 8
        self.contentView.addSubview(deleteBtn)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(data: [FetchedContact], indexPath: IndexPath) {
        self.DisplayName.text = data[indexPath.row].firstName + data[indexPath.row].lastName
        self.PhoneNumber.text = data[indexPath.row].telephone
        
    }
    
    @objc func swipe2LeftAction(_ sender:UISwipeGestureRecognizer) {
        UIView .animate(withDuration: 0.2) {
            self.deleteBtn.x = self.contentView.width - 66 - 15
        }
        
    }
    
}
