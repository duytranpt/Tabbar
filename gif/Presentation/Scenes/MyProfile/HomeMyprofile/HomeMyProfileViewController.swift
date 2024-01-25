//
//  HomeMyProfileViewController.swift
//  gif
//
//  Created by Duy Tran on 14/12/2022.
//

import UIKit

class HomeMyProfileViewController: BaseViewController {

    @IBOutlet weak var scrollviewWidth: NSLayoutConstraint!
    @IBOutlet weak var navibarHight: NSLayoutConstraint!
    @IBOutlet weak var vScrollview: DTScrollView!
    @IBOutlet weak var profileView: ProfileView!
    
    var titleLbl: UILabel?
    var homeIconArr = [HomeMyProfileItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vScrollview.contentSize.width = screenSize.width
        self.vScrollview.layoutIfNeeded()
        self.setHeader(title: "My Profile", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navibarHight.constant = self.navigationBarView!.height
        self.showRightButtonWithImg(img: "icLogout") {
            UserDefaults.clearProfileModel()
            self.moveToLogin()
        }
        self.setBackAction {
            self.navigationController?.popToRootViewController(animated: true)
        }
        readPlist()
        self.showWith(data: homeIconArr)
        self.view.sendSubviewToBack(vScrollview)
        
        let profileData: ProfileHomeModel = ProfileHomeModel(displayName: "Duy Tran", phoneNumber: "0964151505", profileID: "915540639351980032")
        profileView.fillData(data: profileData)
    }
    
    func moveToLogin() {
        if let loginVC = navigationController?.viewControllers.filter({ $0 is LoginMyProfileVC }).first {
            self.navigationController?.popToViewController(loginVC, animated: true)
        } else {
            let loginVC = LoginMyProfileVC()
            self.navigationController?.viewControllers.insert(loginVC, at: 1)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollviewWidth.constant = screenSize.width
    }

    func readPlist(){
        let url = Bundle.main.url(forResource: "MFFuntions", withExtension:"plist")!
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode(Root.self, from: data)
            self.homeIconArr = result.Arr
        } catch {
            print(error)
        }
        
    }
    
    func showWith(data: [HomeMyProfileItem]) {
        self.vScrollview.addSeperator(8, andColor: UIColor.cgRGB(rgb: "242 247 249"), margin: 0)
        for (index, element) in data.enumerated() {
            self.newHomeViewItem(withData: element)
            if index == data.endIndex-1 {
                break
            }
            self.vScrollview.addSeperator(8, andColor: UIColor.cgRGB(rgb: "242 247 249"), margin: 0)
        }
    }
    
    @objc func moveToNewInfor() {
        
        let storyBoard = UIStoryboard(name: "ProfileInfor", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ProfileInforVC") as! ProfileInforVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func moveToNewContact() {
        let storyBoard = UIStoryboard(name: "ContactViewController", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "newContactVC") as! ContactViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func moveToMyBookings() {
        let storyBoard = UIStoryboard(name: "PopupAddCardVC", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PopupAddCardVC") as! PopupAddCardVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: false)
        
    }
    
    @objc func showAlert() {
        self.showNewAlertOkay(withMessage: "Chưa có gì") {
            
        }
    }


}

extension HomeMyProfileViewController {
    func newHomeViewItem(withData: HomeMyProfileItem) {
        let contentView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: screenSize.width, height: 130)))
        
        let width = screenSize.width
        let numberOfItem = withData.HomeItem.count
        
        titleLbl = UILabel(frame: CGRect(x: 15, y: 24, width: width, height: 18))
        titleLbl?.text = withData.Title
        titleLbl?.textColor = .text_Color
        titleLbl?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        contentView.addSubview(titleLbl!)
        if numberOfItem > 1 {
            contentView.height = CGFloat(numberOfItem) * 69 + 60
        }
        var yPosition : CGFloat = 0
        var isShowLine: Bool = true
        for (index, element) in withData.HomeItem.enumerated() {
            if index == (withData.HomeItem.endIndex - 1) {
                isShowLine = false
            }

            let item = HomeCellItem(newHomeItem: element.icon, title: element.title, des: element.des, isShowLine: isShowLine, andFrame: CGRect(x: 15, y: titleLbl!.yBottom + yPosition, width: width-30, height: 69))
            contentView.addSubview(item!)
            
            let bt = UIButton(frame: item!.frame)
            contentView.addSubview(bt)
            
            bt.addAction {
                let sel = NSSelectorFromString(element.action)
                if self.responds(to: sel) {
                    let imp = self.method(for: sel)
                    typealias buttonAction = @convention(c) (AnyObject, Selector) -> Void
                    let callback: buttonAction = unsafeBitCast(imp, to: buttonAction.self)
                    callback(self, sel)
                }

            }
            yPosition += 69
        }
        
        self.vScrollview.addSubview(contentView)
//        self.vScrollview.resetViewContent()
        
    }
}
