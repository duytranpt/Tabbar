//
//  TitleInforView.swift
//  gif
//
//  Created by Duy Tran on 03/01/2023.
//

import UIKit

class TitleInforView: BaseView {

    @IBOutlet weak var mainTitleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var subTitleLbl2: UILabel!
    
    @IBOutlet weak var titleView: VNAChooseSelectionView!
    @IBOutlet weak var genderView: DTTextInputView!
    
    @IBOutlet weak var lastNameView: DTTextInputView!   //Tên
    @IBOutlet weak var firstNameView: DTTextInputView!  //Họ
    
    @IBOutlet weak var lastNameView2: DTTextInputView!  //Tên
    @IBOutlet weak var firstNameView2: DTTextInputView! //Họ
    
    @IBOutlet var contentView: UIView!
    
    
    let alert = VNBAlertController()
    
    
    override func commonInit() {
        let nib = UINib(nibName: "TitleInforView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        setupUI()
    }
    
    func setupUI() {
        
        mainTitleLbl.textColor = .cgRGB(rgb: "0 104 133")
        mainTitleLbl.text = "Họ và tên khách hàng"
        mainTitleLbl.font = .fontMedium(15)
        
        subTitleLbl.textColor = .cgRGB(rgb: "144 144 144")
        subTitleLbl.text = "Họ và tên khách hàng có dấu"
        subTitleLbl.font = .fontMedium(13)

        subTitleLbl2.textColor = .cgRGB(rgb: "144 144 144")
        subTitleLbl2.text = "Họ và tên khách hàng không dấu"
        subTitleLbl2.font = .fontMedium(13)

        
        titleView.setUpView(title: "Danh xưng", andIsRequired: true)
        titleView.setPlaceholder("Chọn danh xưng")
        
        genderView.setUpView(title: "Giới tính", andType: .INPUT_TYPE_NAME, andIsRequired: true)
        genderView.setPlaceholder("Giới tính")
        genderView.isUserInteractionEnabled = false
        
        //Tên có dấu
        lastNameView.setUpView(title: "Tên đệm & Tên", andType: .INPUT_TYPE_NAME_VI, andIsRequired: true)
        lastNameView.setPlaceholder("Van A")
        lastNameView.vTextField?.tag = 1
        lastNameView.vTextField?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        firstNameView.setUpView(title: "Họ", andType: .INPUT_TYPE_NAME_VI, andIsRequired: true)
        firstNameView.setPlaceholder("Nguyen")
        firstNameView.vTextField?.tag = 2
        firstNameView.vTextField?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        //Tên không dấu
        lastNameView2.setUpView(title: "Tên đệm & Tên", andType: .INPUT_TYPE_NAME, andIsRequired: true)
        lastNameView2.setPlaceholder("Van A")
        lastNameView2.isUserInteractionEnabled = false
        
        firstNameView2.setUpView(title: "Họ", andType: .INPUT_TYPE_NAME, andIsRequired: true)
        firstNameView2.setPlaceholder("Nguyen")
        firstNameView2.isUserInteractionEnabled = false
    }
    
        //lastNameView   //Tên
        //firstNameView  //Họ
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            lastNameView2.vTextField!.text = textField.text!.bo_dau_Tieng_Viet()!.uppercased()
        case 2:
            firstNameView2.vTextField!.text = textField.text!.bo_dau_Tieng_Viet()!.uppercased()
        default:
            break
        }
        
    }

    func fillData(data: ProfileModel) {
        self.genderView.vTextField?.text = data.gender == 1 ? "Nam": "Nữ"
        self.titleView.vTextField?.text = data.title
        self.lastNameView.vTextField?.text = data.firstNameFull?.uppercased()
        self.firstNameView.vTextField?.text = data.lastNameFull?.uppercased()
        self.lastNameView2.vTextField?.text = data.firstName?.uppercased()
        self.firstNameView2.vTextField?.text = data.lastName?.uppercased()
    }
    
    func fillPaxData(data: ResponseListPax) {
        self.genderView.vTextField?.text = data.gender == 1 ? "Nam": "Nữ"
        self.titleView.vTextField?.text = data.title
        self.lastNameView.vTextField?.text = data.firstNameFull?.uppercased()
        self.firstNameView.vTextField?.text = data.lastNameFull?.uppercased()
        self.lastNameView2.vTextField?.text = data.firstName?.uppercased()
        self.firstNameView2.vTextField?.text = data.lastName?.uppercased()
    }

    
    func clearAllData() {
        self.genderView.vTextField?.text = ""
        self.titleView.vTextField?.text = ""
        self.lastNameView.vTextField?.text = ""
        self.firstNameView.vTextField?.text = ""
        self.lastNameView2.vTextField?.text = ""
        self.firstNameView2.vTextField?.text = ""
    }
    
}

