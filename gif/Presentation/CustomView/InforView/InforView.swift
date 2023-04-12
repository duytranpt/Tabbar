//
//  InforView.swift
//  gif
//
//  Created by Duy Tran on 03/01/2023.
//

import UIKit

class InforView: BaseView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var emailView: DTTextInputView!
    @IBOutlet weak var phoneNumberView: DTTextInputView!
    
    //Title infor outlet:
    @IBOutlet weak var titleInforView: TitleInforView!
    
    
    //bsv outlet:
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bsvInputView: UIView!
    
    
    @IBOutlet weak var messLlb: UILabel!
    @IBOutlet weak var displayCardNumberView: UIView!
    @IBOutlet weak var displayNameView: UIView!
    @IBOutlet weak var displayCardRankView: UIView!
    @IBOutlet weak var sperator: NSLayoutConstraint!
    @IBOutlet weak var inforSTV: UIStackView!
    
    //document outlet:
    @IBOutlet weak var documentTitleLbl: UILabel!
    @IBOutlet weak var addDocumentViewBtn: VNBButton!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var docView1: DocumentView!
    @IBOutlet weak var docView2: DocumentView!
    @IBOutlet weak var speratorView: UIView!
    @IBOutlet weak var speratorView2: UIView!
    @IBOutlet weak var btnConfirmDoc: VNBButton!
    @IBOutlet weak var btnCancelDoc: VNBButton!
    @IBOutlet weak var btnDocView: UIView!
    
    //FooterView outlet:
    @IBOutlet weak var clearAllContentBtn: VNBButton!
    @IBOutlet weak var cancelBtn: VNBButton!
    @IBOutlet weak var confirmBtn: VNBButton!
    @IBOutlet weak var privacyPolicyLbl: DTLabel!
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    //
    @IBOutlet weak var lastSV: UIStackView!
    @IBOutlet weak var fourthSV: UIStackView!
    @IBOutlet weak var thirdSV: UIStackView!
    @IBOutlet weak var secondSV: UIStackView!
    @IBOutlet weak var mainSTV: UIStackView!
    
    //
    var newinput: VNDTSelectDateView?
    var mainView: UIView?
    let spacing = 8
    var navC: UINavigationController?
    let alert = VNBAlertController()
    //action
    var setConfirmAction: (() -> Void)?
    
    override func commonInit() {
        let nib = UINib(nibName: "InforView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        setupUI()
        setupCardView()
        setupDocumentView()
        setupFooterView()
    }
    
    func getContentHeight() -> CGFloat {
        
        let heightContentView = lastSV.height + fourthSV.height + thirdSV.height + secondSV.height + titleInforView.height
        
        return heightContentView + CGFloat(6*spacing)
    }
    
    func setupUI() {
        newinput = VNDTSelectDateView(newInputViewWithTitle: "Ngày sinh", andIsRequired: true, andFrame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 59)))
        newinput!.setPlaceholder("Chọn ngày")
        dobView.addSubview(newinput!)
        newinput!.selectBlock = { [weak self] in
            guard let wSelf = self else { return }
            wSelf.mainView?.endEditing(true)
            wSelf.newinput!.dateTimePicker?.show(in: wSelf.mainView, with: Date(), animated: true)
        }
        
        emailView.setUpView(title: "Email", andType: .INPUT_TYPE_EMAIL, andIsRequired: true)
        emailView.setPlaceholder("Nhập Email")
        
        phoneNumberView.setUpView(title: "Số điện thoại", andType: .INPUT_TYPE_NUMBER, andIsRequired: true)
        phoneNumberView.setPlaceholder("Nhập số điện thoại")
        
    }
    
    func setupCardView() {
        titleLbl.text = "Thông tin tài khoản bông sen vàng"
        titleLbl.textColor = .cgRGB(rgb: "0 104 133")
        titleLbl.font = .fontMedium(15)
        messLlb.text = ""
        messLlb.textColor = .cgRGB(rgb: "196 37 63")
        messLlb.font = .fontMedium(11)
        var demoview: DTTextInputView!
        demoview = DTTextInputView(newInputViewWithTitle: "Số thẻ bông sen vàng", andType: .INPUT_TYPE_NUMBER, andIsRequired: true,confirmBtnLbl: "Xác nhận", andFrame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 59)), callback: { [weak self] in
            guard let wSelf = self else { return }
            guard let bsvNumber = demoview.vTextField?.text!.count else { return }
            
            if bsvNumber >= 10 {
                wSelf.inforSTV.isHidden = false
                wSelf.messLlb.text = ""
                wSelf.displayCardNumberView.isHidden = true
                wSelf.displayNameView.isHidden = false
                wSelf.displayCardRankView.isHidden = false
                wSelf.sperator.constant = 16
                wSelf.height = 201
                wSelf.layoutIfNeeded()
            } else {
                wSelf.inforSTV.isHidden = true
                wSelf.sperator.constant = 24
                wSelf.messLlb.text = "Số tài khoản bsv không đúng"
            }
        })
        demoview.setPlaceholder("Nhập số thẻ bông sen vàng")
        bsvInputView.addSubview(demoview)
    }
    
    func setupDocumentView() {
        documentTitleLbl.text = "Giấy tờ tùy thân"
        documentTitleLbl.textColor = .cgRGB(rgb: "0 104 133")
        documentTitleLbl.font = .fontMedium(15)
        
        addDocumentViewBtn.buttonLeftImg(title: "Thêm giấy tờ tùy thân", img: "16X16AddMore", textColor: .cgRGB(rgb: "219 163 16"))
        
        
        addDocumentViewBtn.addAction { [weak self] in
            guard let wSelf = self else { return }

            if wSelf.docView1.mainView == nil {
                wSelf.docView1.mainView = wSelf.mainView
            }
            
            if wSelf.docView2.mainView == nil {
                wSelf.docView2.mainView = wSelf.mainView
            }

            
            if wSelf.docView1.isHidden && wSelf.docView2.isHidden {
                wSelf.docView1.isHidden = false
                wSelf.docView2.tag(2)
            } else {
                if !wSelf.docView1.isHidden && wSelf.docView2.isHidden {
                    wSelf.docView2.isHidden = false
                } else if wSelf.docView1.isHidden && !wSelf.docView2.isHidden {
                    wSelf.docView1.isHidden = false
                    wSelf.docView2.tag(2)
                }
            }
            
            if !wSelf.docView1.isHidden &&  !wSelf.docView2.isHidden {
                wSelf.addView.isHidden = true
                wSelf.speratorView2.isHidden = false
                wSelf.speratorView.isHidden = false
            }
        }
        
        if docView1.isHidden && docView2.isHidden {
            addView.isHidden = false
            speratorView.isHidden = true
        }
        docView1.deleteAction = { [weak self] in
            guard let wSelf = self else { return }
            wSelf.speratorView.isHidden = true
            wSelf.speratorView2.isHidden = true
            wSelf.docView2.tag(1)
            wSelf.addView.isHidden = false
        }
        
        docView2.deleteAction = { [weak self] in
            guard let wSelf = self else { return }
            wSelf.speratorView.isHidden = true
            wSelf.speratorView2.isHidden = true
            wSelf.addView.isHidden = false
            wSelf.docView2.tag(2)
        }
        
        btnCancelDoc.addAction { [weak self] in
            guard let wSelf = self else { return }
            wSelf.navC?.popViewController(animated: true)
        }

        btnConfirmDoc.addAction { [weak self] in
            guard let wSelf = self else { return }
            if (wSelf.setConfirmAction != nil) {
                wSelf.setConfirmAction!()
            }
        }
    }
    
    func setupFooterView() {
        clearAllContentBtn.setTitle("Xóa toán bộ thông tin", color: .cgRGB(rgb: "230 72 15"))
        clearAllContentBtn.addAction { [self] in
            print(getContentHeight())
        }
        
        let fullString: NSString = "Bằng việc bấm Cập nhật, Tôi đã đọc và đồng ý với chính sách bảo mật thông tin, quyền riêng tư của Vietnam Airline"
        let arrColor: [NSString] = ["chính sách bảo mật thông tin, quyền riêng tư"]
        privacyPolicyLbl.formatText(fullString: fullString, boldPartOfString: arrColor, font: .fontMedium(13), boldFont: .fontBold(13), color: .cgRGB(rgb: "219 163 16"), underLine: true)
        privacyPolicyLbl.tapLabel(key: arrColor) { link in
            if link == 0 {
                print("Mở cái này trong br")
            }
        }
        
        cancelBtn.addAction { [weak self] in
            guard let wSelf = self else { return }
            wSelf.navC?.popViewController(animated: true)
        }
        
        contentView.addAction { [weak self] in
            guard let wSelf = self else { return }
            if (wSelf.setConfirmAction != nil) {
                wSelf.setConfirmAction!()
            }
        }
        
        clearAllContentBtn.addAction { [weak self] in
            guard let wSelf = self else { return }
            wSelf.clearAllData()
        }
    }
    
    func fillData(data: ProfileModel) {
        titleInforView.fillData(data: data)
        self.emailView.vTextField?.text = data.email
        self.newinput?.vTextField?.text = data.dob!.reformatDateString(fromFormat: "yyyy-MM-dd", toFormat: "dd/MM/yyyy")
        if !data.listDocument!.isEmpty {
            if data.listDocument?.count == 2 {
                self.speratorView2.isHidden = false
                self.addView.isHidden = true
                self.speratorView.isHidden = false
                docView1.fillData(data: data.listDocument![0])
                docView2.fillData(data: data.listDocument![1])
            } else {
                if data.listDocument?.count == 1 {
                    docView1.fillData(data: data.listDocument![0])
                }
            }
        }
    }
    
    func clearAllData() {
        self.docView1.clearAllData()
        self.docView2.clearAllData()
        self.titleInforView.clearAllData()
        self.emailView.vTextField?.text = ""
        self.phoneNumberView.vTextField?.text = ""
        self.newinput?.vTextField?.text = ""
    }
    
    func fillPaxData(data: ResponseListPax) {
        self.emailView.vTextField?.text = data.email
        self.phoneNumberView.vTextField?.text = data.phone
        self.newinput?.vTextField?.text = data.dob!.reformatDateString(fromFormat: "yyyy-MM-dd", toFormat: "dd/MM/yyyy")
        self.titleInforView.fillPaxData(data: data)
        if !data.listDocument!.isEmpty {
            if data.listDocument?.count == 2 {
                self.speratorView2.isHidden = false
                self.addView.isHidden = true
                self.speratorView.isHidden = false
                docView1.fillData(data: data.listDocument![0])
                docView2.fillData(data: data.listDocument![1])
            } else {
                if data.listDocument?.count == 1 {
                    docView1.fillData(data: data.listDocument![0])
                }
            }
        }
    }
    
    func checkNil() {
        docView1.checkNil()
        docView2.checkNil()
    }
    
    func paxData() -> ResponseListPax {
        
        var listDoc = [ResponseListDocument]()
        var listDoc1:ResponseListDocument
        var listDoc2:ResponseListDocument
        if !docView1.isHidden {
            listDoc1 = docView1.docData()
            listDoc.append(listDoc1)
        }
        
        if !docView2.isHidden {
            listDoc2 = docView2.docData()
            listDoc.append(listDoc2)
        }

        return ResponseListPax(firstName: titleInforView.firstNameView.vTextField?.text ?? "",
                               firstNameFull: titleInforView.firstNameView.vTextField?.text ?? "",
                               gender: 1,
                               lastName: titleInforView.firstNameView.vTextField?.text ?? "",
                               lastNameFull: titleInforView.firstNameView.vTextField?.text ?? "",
                               phone: self.phoneNumberView.vTextField?.text ?? "",
                               title: titleInforView.firstNameView.vTextField?.text ?? "",
                               paxId: self.randomNumber(length: 18),
                               email: self.emailView.vTextField?.text ?? "",
                               dob: newinput?.vTextField?.text ?? "",
                               listDocument: listDoc)
    }

}

