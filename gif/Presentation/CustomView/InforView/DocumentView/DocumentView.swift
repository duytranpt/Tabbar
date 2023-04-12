//
//  DocumentView.swift
//  gif
//
//  Created by Duy Tran on 03/01/2023.
//

import UIKit

class DocumentView: BaseView {
    @IBOutlet weak var documentType: VNAChooseSelectionView!
    @IBOutlet weak var documentId: DTTextInputView!
    @IBOutlet weak var nationality: VNAChooseSelectionView!
    @IBOutlet weak var dateEx: UIView!
    @IBOutlet weak var country: VNAChooseSelectionView!
    
    @IBOutlet weak var numberDocumentTitleLbl: UILabel!
    @IBOutlet weak var deleteBtn: VNBButton!
    @IBOutlet var contentView: UIView!
    
    var deleteAction: (() -> Void)?
    var mainView: UIView?
    var newinput: VNDTSelectDateView?
    let alert = VNBAlertController()
    
    override func commonInit() {
        let nib = UINib(nibName: "DocumentView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        setupUI()
    }
    
    func tag(_ num: Int) {
        self.tag = num
        numberDocumentTitleLbl.text = "Giấy tờ tùy thân %@".localized("\(num)")
    }
    
    func setupUI() {
        numberDocumentTitleLbl.text = "Giấy tờ tùy thân %@".localized("\(self.tag)")
        numberDocumentTitleLbl.textColor = .cgRGB(rgb: "144 144 144")
        numberDocumentTitleLbl.font = .fontRegular(13)
        
        deleteBtn.buttonLeftImg(title: "Xoá", img: "icDelete", textColor: .cgRGB(rgb: "230 72 15"))
        
        deleteBtn.addAction { [weak self] in
            guard let wSelf = self else { return }
            wSelf.isHidden = true
            wSelf.clearAllData()
            if (wSelf.deleteAction != nil) {
                wSelf.deleteAction!()
            }

        }

        documentType.setUpView(title: "Loại giấy tờ", andIsRequired: true)
        documentType.setPlaceholder("Chọn")
        
        documentId.setUpView(title: "Số giấy tờ", andType: .INPUT_TYPE_NUMBER, andIsRequired: true)
        documentId.setPlaceholder("Chọn")
        
        nationality.setUpView(title: "Quốc gia/ Vùng", andIsRequired: true)
        documentType.setPlaceholder("Chọn")
        
        newinput = VNDTSelectDateView(newInputViewWithTitle: "Ngày sinh", andIsRequired: true, andFrame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 59)))
        newinput!.setPlaceholder("Chọn ngày")
        dateEx.addSubview(newinput!)
        newinput!.selectBlock = { [weak self] in
            guard let wSelf = self else { return }
            wSelf.mainView?.endEditing(true)
            wSelf.newinput!.dateTimePicker?.show(in: wSelf.mainView, with: Date(), animated: true)
        }
        
        country.setUpView(title: "Quốc tịch", andIsRequired: true)
        country.setPlaceholder("Chọn")
    }
    
    func fillData(data: ResponseListDocument) {
        self.isHidden = false
        self.documentType.vTextField?.text = data.documentType
        self.documentId.vTextField?.text = data.documentId
        self.nationality.vTextField?.text = data.passportNation
        self.newinput?.vTextField?.text = data.passportExpiryDate!.reformatDateString(fromFormat: "yyyy-MM-dd", toFormat: "dd/MM/yyyy")
        self.country.vTextField?.text = data.passportIssueCountry
    }
    
    func clearAllData() {
        self.documentType.vTextField?.text = ""
        self.documentId.vTextField?.text = ""
        self.nationality.vTextField?.text = ""
        self.newinput?.vTextField?.text = ""
        self.country.vTextField?.text = ""
    }
    
    func checkNil() -> Bool {
        if self.documentType.vTextField?.text == "" {
            alert.showNewAlertOkay(withMessage: "Loại giấy tờ không được bỏ trống") {}
            return false
        }
        
        if self.documentId.vTextField?.text == "" {
            alert.showNewAlertOkay(withMessage: "Loại giấy tờ không được bỏ trống") {}
            return false
        }
        
        if self.nationality.vTextField?.text == "" {
            alert.showNewAlertOkay(withMessage: "Loại giấy tờ không được bỏ trống") {}
            return false
        }
        
        if self.newinput?.vTextField?.text == "" {
            alert.showNewAlertOkay(withMessage: "Loại giấy tờ không được bỏ trống") {}
            return false
        }
         
        if self.country.vTextField?.text == "" {
            alert.showNewAlertOkay(withMessage: "Loại giấy tờ không được bỏ trống") {}
            return false
        }
        
        return true
    }
    
    func docData() -> ResponseListDocument {
        
        if checkNil() {
            return ResponseListDocument(documentId: self.randomNumber(length: 18),
                                 documentType: self.documentType.vTextField?.text ?? "",
                                 passportExpiryDate: self.newinput?.vTextField?.text ?? "",
                                 passportIssueCountry:  self.country.vTextField?.text ?? "",
                                 passportNation:  self.nationality.vTextField?.text ?? "",
                                 passportNumber: self.documentId.vTextField?.text ?? "")
        }
        
        return ResponseListDocument("jfjjs")
    }
}
