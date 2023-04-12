//
//  ViewController.swift
//  gif
//
//  Created by Duy Tran on 22/08/2022.
//

import UIKit
import Lottie
import SwiftyJSON
import WebKit
import SafariServices

class ViewController: BaseViewController, SFSafariViewControllerDelegate {
 
        
    //MARK: Outlet
    @IBOutlet weak var navibarHeight: NSLayoutConstraint!
    @IBOutlet weak var changeColorView: TabbarHomeVC!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    var myViewHeightConstraint: NSLayoutConstraint!
    var imagePicker : UIImagePickerController!
    var SMALL_TABBAR: CGFloat = 111
    var EXPANDTABBAR: CGFloat!
    var _hTabBar: CGFloat = 0
    var didExpanded: Bool!
    
    let dateFormatter = "dd/MM/yyyy"
    let ScreenSize: CGRect = UIScreen.main.bounds
    var backgroundView: UIView!
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeader(title: "Ứng dụng đọc báo điện tử PressReader", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.hideAllButton()
        EXPANDTABBAR = getTabbarHeight()
        setupUI()
        
        let jsonData = self.readLocalJSONFile(forName: "data")
        let respond = ProfileModel(jsonData!)
        UserDefaults.saveUserData(userData: respond)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        //        changeColorView.setUpLoadingView(animation: "up")
        self.navibarHeight.constant = self.navigationBarView!.height
        smallTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        changeColorView.removePlus()
        if changeColorView.ListIcon.count > 16 && changeColorView.frame.height == SMALL_TABBAR {
            changeColorView.collectionView.isScrollEnabled = false
        }
        
       
//        if UIApplication.shared.alternateIconName == nil {
//            self.setApplicationIconName("AppIcon-2")
//        } else if UIApplication.shared.alternateIconName == "AppIcon-2" {
//            self.setApplicationIconName("AppIcon-3")
//        } else {
//            self.setApplicationIconName(nil)
//        }
        
        self.changeIconApp(date: Date())
    }

    //MARK: Action
        
    //MARK: Setup UI
    
    func changeIconApp(date: Date) {
        let today = date.millisecondsSince1970
        guard let beginDate = Date.dateFromString("20/01/2022", withFormat: dateFormatter)?.millisecondsSince1970 else { return }
        guard let endDate = Date.dateFromString("26/01/2022", withFormat: dateFormatter)?.millisecondsSince1970 else { return }
        
        
        if today <= endDate && today >= beginDate {
            self.setApplicationIconName("AppIcon-3")
        } else {
            self.setApplicationIconName(nil)
        }
        
//        if UIApplication.shared.alternateIconName == nil {
//            self.setApplicationIconName("AppIcon-3")
//        } else {
//            self.setApplicationIconName(nil)
//        }

    }
    
    func setupUI() {
        didExpanded = false
        setupTabbar()
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ViewController {
    
    func getTabbarHeight() -> CGFloat {
        var tabbarHeight: CGFloat = 111
        
        let item = changeColorView.ListIcon.count
        let itemPerRow = changeColorView.itemPerRow
        let row = item/itemPerRow
        let mod = item%itemPerRow
        var numberOfRow: Int
        if mod < itemPerRow && mod != 0 {
            numberOfRow = row+1
        } else {
            numberOfRow = row
        }
    
        if item > 16 {
            tabbarHeight = CGFloat(4 * 77) + CGFloat((numberOfRow - 1)*10) + 54 + 22 + 42
        } else {
            tabbarHeight = CGFloat(numberOfRow * 77) + CGFloat((numberOfRow - 1)*10) + 54 + 22 + 42
        }
        

        return tabbarHeight
    }
    
    func setupTabbar() {
        changeColorView.roundCorners(radius: 24, corners: [.topLeft, .topRight])
        
        changeColorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changeColorView)
        
        myViewHeightConstraint = NSLayoutConstraint(item: changeColorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: SMALL_TABBAR)
        
        myViewHeightConstraint.isActive = true
        changeColorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        changeColorView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        changeColorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        changeColorView.showTitleView(isShow: false)
        changeColorView.addGestureRecognizer(createSwipeGestureRecognizerNew(for: .began))
        changeColorView.addGestureRecognizer(createSwipeGestureRecognizerNew(for: .changed))
        changeColorView.addGestureRecognizer(createSwipeGestureRecognizerNew(for: .ended))
        
        backgroundView = UIView(frame: ScreenSize)
        backgroundView.backgroundColor = .cgRGBA(rgba: "0 0 0, 0.7")
        self.view.addSubview(backgroundView)
        backgroundView.isHidden = true
        self.view.bringSubviewToFront(changeColorView)
        self.changeColorView.tabBarCallback = { actionStr in
            switch actionStr {
            case .VNATABBAR_HOME:
                print("VNATABBAR_HOME")
            case .VNATABBAR_BOOK_TICKET:
                self.smallTabBar()
                self.moveToAddEventVC()
            case .VNATABBAR_LOTUS_SMILE:
                self.VNATABBAR_LOTUS_SMILE()
            case .VNATABBAR_CHECK_IN:
                print("VNATABBAR_CHECK_IN")
            case .VNATABBAR_MY_SEAT:
                print("VNATABBAR_MY_SEAT")
            case .VNATABBAR_MY_SEAT_POSVN:
                print("VNATABBAR_MY_SEAT_POSVN")
            case .VNATABBAR_FOLLOW:
                print("VNATABBAR_FOLLOW")
            case .VNATABBAR_FLIGHT_CALENDER:
                self.smallTabBar()
                self.moveToDateExamplesVC()
            case .VNATABBAR_VN_HOLLIDAYS:
                print("VNATABBAR_VN_HOLLIDAYS")
//                AppleWalletVC
                self.smallTabBar()
                self.moveToAppleWalletVC()
            case .VNATABBAR_HOTTEL_BOOKING:
                print("VNATABBAR_HOTTEL_BOOKING")
            case .VNATABBAR_FLIGHT_MAP:
                self.smallTabBar()
                self.moveToContactVC()
            case .VNATABBAR_INFORM:
                self.smallTabBar()
                self.movetoHorizontalScrollViewVC()
            case .VNATABBAR_SET_UP:
                self.smallTabBar()
                self.moveToPhoneNumberVC()
            case .VNATABBAR_MYPROFILE:
                self.smallTabBar()
                self.moveToMyProfile()
            default:
                break
            }
        }
        
        addBackground()

    }
        
    func addBackground() {
        

        if changeColorView.isSettingView {
            backgroundView.isHidden = false
        }
    }
    
    private func createSwipeGestureRecognizerNew(for direction: UIPanGestureRecognizer.State) -> UIPanGestureRecognizer {
     
        let panGesture = UIPanGestureRecognizer(target: self, action:(#selector(self.handleGesture(_:))))
            panGesture.state = direction
    
        return panGesture
    }
    
    func VNATABBAR_LOTUS_SMILE() {
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("urlPayment.html")
        
        let htmlString = "<html><script>var timer = setInterval(function(){document.getElementById('afopform').submit();if(timer){clearInterval(timer)};}, 1);</script><body><form method=\"post\" action=\"https://vnticket.vnpaytest.vn/vnapaynow/payment_select.html?txnid=537549734383616&merchant=shopeepay&src=sma&token=7a20b4946716f91ea769d34de8d6b16d\" name=\"afopform\" id=\"afopform\" ><input type=\"hidden\" name=\"CountryCode\" value=\"VN\" /><input type=\"hidden\" name=\"LanguageCode\" value=\"vi_VI\" /><input type=\"hidden\" name=\"PaymentMethodCode\" value=\"EW108\" /><input type=\"hidden\" name=\"OrderNumber\" value=\"01731675132769192706\" /><input type=\"hidden\" name=\"MerchantReturnData\" value=\"VN\" /><input type=\"hidden\" name=\"MerchantAccountCode\" value=\"VNACERT\" /><input type=\"hidden\" name=\"SuccessURL\" value=\"https://ipe-pmt.cert.sabre.com/ipe/standardpsp?supplierID=VNPY&pwsStatus=AUTHORIZED\" /><input type=\"hidden\" name=\"PendingURL\" value=\"https://ipe-pmt.cert.sabre.com/ipe/standardpsp?supplierID=VNPY&pwsStatus=PENDING\" /><input type=\"hidden\" name=\"FailureURL\" value=\"https://ipe-pmt.cert.sabre.com/ipe/standardpsp?supplierID=VNPY&pwsStatus=REFUSED\" /><input type=\"hidden\" name=\"CancelURL\" value=\"https://ipe-pmt.cert.sabre.com/ipe/standardpsp?supplierID=VNPY&pwsStatus=CANCELLED\" /><noscript><br/><br/><div style=\"text-align: center\"><h1>Processing your Transaction </h1><p>Please click continue to continue the processing of your transaction.</p><input type=\"submit\" name=\"submit\" value=\"continue\" /></div></noscript></form></body></html>"
       
       
        print("fileURL: \(fileURL)")
        let filePath = fileURL.description

        try? htmlString.write(to: fileURL, atomically: true, encoding: .utf8)
//        UIApplication.shared.open(fileURL)

        let vc = SFSafariViewController(url: fileURL)
        self.present(vc, animated: true)
//        try? htmlString.write(toFile: filePath, atomically: true, encoding: .utf8)
//        if let url = URL(string: filePath) {
//          UIApplication.shared.open(url)
//        }
        
        
    }
    
    func moveToAddEventVC() {
        let storyBoard = UIStoryboard(name: "AddEventVC", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddEventVC") as! AddEventVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToDateExamplesVC() {
        let storyBoard = UIStoryboard(name: "DateExamplesVC", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DateExamplesVC") as! DateExamplesVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToMyProfile() {
//        let storyBoard = UIStoryboard(name: "HomeMyProfileViewController", bundle:Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeMyProfileVC") as! HomeMyProfileViewController
        let vc = LoginMyProfileVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToAppleWalletVC() {
        let storyBoard = UIStoryboard(name: "AppleWalletVC", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AppleWalletVC") as! AppleWalletVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToContactVC() {
        let storyBoard = UIStoryboard(name: "ContactVC", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ContactVC") as! ContactVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func moveToPhoneNumberVC() {
        let storyBoard = UIStoryboard(name: "CheckPhoneNumber", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PhoneNumberVC") as! CheckPhoneNumber
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func movetoHorizontalScrollViewVC() {
        let storyBoard = UIStoryboard(name: "HorizontalScrollViewVC", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HorizontalScrollViewVC") as! HorizontalScrollViewVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func expandTabBar() {
        var frame = changeColorView.frame
        didExpanded = true
        myViewHeightConstraint.constant = EXPANDTABBAR
        frame.origin.y = max(0.0, frame.origin.y)
        changeColorView.setUpLoadingView(animation: "down")
        changeColorView.showTitleView(isShow: true)
        changeColorView.removePlus()
        if changeColorView.ListIcon.count > 16 {
            changeColorView.collectionView.isScrollEnabled = true
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromLeft) {
            self.changeColorView.frame = frame
            self.view.layoutIfNeeded()
        } completion: { _ in }

    }
    
    func smallTabBar() {
        var frame = changeColorView.frame
        didExpanded = false
        if !changeColorView.isSettingView {
            frame.origin.y = view.bounds.maxY
            myViewHeightConstraint.constant = SMALL_TABBAR
            if frame.maxY > view.bounds.maxY {
                frame.origin.y = view.bounds.height - frame.height
            }
            changeColorView.setUpLoadingView(animation: "up")
            changeColorView.showTitleView(isShow: false)
            changeColorView.closePopup()
            changeColorView.collectionView.isScrollEnabled = false
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromLeft) {
            self.changeColorView.frame = frame
            self.view.layoutIfNeeded()
        } completion: { _ in }

    }
    

    @objc func handleGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        if !changeColorView.isSettingView {
            switch sender.state {
            case .began:
                _hTabBar = changeColorView.frame.height
            case .changed:
                if _hTabBar - translation.y < EXPANDTABBAR * 1.5 {
                    myViewHeightConstraint.constant = _hTabBar - translation.y
                }
            case .ended:
                if didExpanded {
                    if changeColorView.frame.height > EXPANDTABBAR * 0.99 {
                        expandTabBar()
                    } else {
                        smallTabBar()
                    }
                } else {
                    if changeColorView.frame.height > SMALL_TABBAR * 1.05 {
                        expandTabBar()
                    } else {
                        smallTabBar()
                    }
                }
                
            default:
                break
            }

        }

    }

    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        
        var frame = changeColorView.frame

        switch sender.direction {
        case .up:
            if !changeColorView.isSettingView {
                myViewHeightConstraint.constant = EXPANDTABBAR
                frame.origin.y = max(0.0, frame.origin.y)
                changeColorView.showTitleView(isShow: true)
                changeColorView.removePlus()
                if changeColorView.ListIcon.count > 16 {
                    changeColorView.collectionView.isScrollEnabled = true
                }
            }
            
        case .down:
            if !changeColorView.isSettingView {
                frame.origin.y = view.bounds.maxY
                myViewHeightConstraint.constant = SMALL_TABBAR
                if frame.maxY > view.bounds.maxY {
                    frame.origin.y = view.bounds.height - frame.height
                }
                changeColorView.showTitleView(isShow: false)
                changeColorView.closePopup()
                changeColorView.collectionView.isScrollEnabled = false
            }
        default:
            break
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromLeft) {
            self.changeColorView.frame = frame
            self.view.layoutIfNeeded()
        } completion: { _ in
//            print("done")
        }
                
    }
    
 
}


extension ViewController {
    func showTabbar() {
        self.smallTabBar()
//        self.changeColorView
    }
    
    func hideTabbar() {
        
    }
   
    
//    func hide() {
//        var supperView = self.superview
//        var v = supperView?.viewWithTag(204)
//
//        UIView.animate(withDuration: 0.3, animations: { [weak self] in
//            guard let self = self else { return }
//
//            v!.isHidden = true
//            var r = self.frame
//            r.origin.y = supperView!.frame.size.height
//            self.frame = r
//
//        }) { [self] finished in
//            self.removeFromSuperview()
//            v!.removeFromSuperview()
//        }
//
//    }
}

extension ViewController {
    func readLocalJSONFile(forName name: String) -> JSON? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return JSON(data)
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }

    func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        UIApplication.shared.open(url, completionHandler: { success in
            if success {
                print("opened")
            } else {
                print("failed")
                // showInvalidUrlAlert()
            }
        })
    }
}
