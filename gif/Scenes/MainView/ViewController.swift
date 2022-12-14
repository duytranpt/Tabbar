//
//  ViewController.swift
//  gif
//
//  Created by Duy Tran on 22/08/2022.
//

import UIKit
import Lottie
import RSKImageCropper
import FittedSheets
import AVFoundation
import QRCodeReader
import SafariServices


class ViewController: UIViewController, RSKImageCropViewControllerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {

    }
        
    //MARK: Outlet
    @IBOutlet weak var demoLabel: UILabel!
    @IBOutlet weak var changeColorView: TabbarHomeVC!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var buttonView: CustomButton!
    @IBOutlet weak var ic4: CustomButton!
    @IBOutlet weak var ic3: CustomButton!
    @IBOutlet weak var ic2: CustomButton!
    @IBOutlet weak var navBarView: NaviBar!
    
    var myViewHeightConstraint: NSLayoutConstraint!
    var imagePicker : UIImagePickerController!
    var SMALL_TABBAR: CGFloat = 111
    var EXPANDTABBAR: CGFloat!
    var _hTabBar: CGFloat = 0
    var didExpanded: Bool!
    
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.4)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    let ScreenSize: CGRect = UIScreen.main.bounds
    var backgroundView: UIView!
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fullString = "Số tài khoản : minhtrang16121992\nSố tiền giao dịch : -1,000,000 VND\nSố dư cuối : 5,523,125 VND\nNội dung giao dịch : Chuyen khoan ca nhan"
        demoLabel.attributedText = formatText(fullString: fullString as NSString)
        
        EXPANDTABBAR = getTabbarHeight()
        setupUI()
//        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(changeColorView.frame.height)
        changeColorView.removePlus()
        if changeColorView.ListIcon.count > 16 && changeColorView.frame.height == SMALL_TABBAR {
            changeColorView.collectionView.isScrollEnabled = false
        }

    }

    //MARK: Action
    
    @IBAction func Tapme(_ sender: Any) {
        print(demoLabel.text)
    }
    
    //MARK: Setup UI
    
    func setupUI() {
        didExpanded = false
        setupTabbar()
        setupGif()
        navBarView.setHeader(title: "Ứng dụng đọc báo điện tử PressReader", subtitle: "", type: .VNAHEADER_ONE_LINE_SIMPLE)
        navBarView.leftBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)

        buttonView.setupButton(animation: "qrpay", title: "Ví gia đình")
        ic2.setupButton(animation: "qrpay", title: "VNPAY")
        ic3.setupButton(animation: "qrpay", title: "GetContact")
        ic4.setupButton(animation: "qrpay", title: "QRPay")
        
        buttonView.ButtonAnimation.addTarget(self, action: #selector(tapbtn), for: .touchUpInside)
        buttonView.ButtonAnimation.tag = 1
        ic2.ButtonAnimation.addTarget(self, action: #selector(tapbtn), for: .touchUpInside)
        ic2.ButtonAnimation.tag = 2
        ic3.ButtonAnimation.addTarget(self, action: #selector(tapbtn), for: .touchUpInside)
        ic3.ButtonAnimation.tag = 3
        ic4.ButtonAnimation.addTarget(self, action: #selector(tapbtn), for: .touchUpInside)
        ic4.ButtonAnimation.tag = 4
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapbtn(sender: UIButton) {
        
        switch sender.tag {
        case 1:
            let stb = UIStoryboard(name: "ContactVC", bundle: nil)
            let vc = stb.instantiateViewController(withIdentifier: "ContactVC") as! ContactVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            break
        case 3:
            let popupView = PopupView(frame: CGRect(x: 0, y: 400, width: 375, height: 250))
            view.addSubview(popupView)
        case 4:
//            readerVC.delegate = self
            
            // Or by using the closure pattern
            readerVC.completionBlock = { (result: QRCodeReaderResult?) in
                print(result?.value)
                
                guard let url = URL(string: result?.value ?? "") else { return }
                UIApplication.shared.open(url)
            }

            // Presents the readerVC as modal form sheet
            readerVC.modalPresentationStyle = .formSheet
           
            present(readerVC, animated: true, completion: nil)

        default:
            break
        }
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods

    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
      reader.stopScanning()

      dismiss(animated: true, completion: nil)
    }

    //This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    //By pressing on the switch camera button
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
//        if let cameraName = newCaptureDevice.device.localizedName {
//          print("Switching capture to: \(cameraName)")
//        }
    }

    func readerDidCancel(_ reader: QRCodeReaderViewController) {
      reader.stopScanning()

      dismiss(animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first
//        guard let location = touch?.location(in: self.view) else { return }
//        if !changeColorView.frame.contains(location) {
//            print("Tapped outside the view")
//            if changeColorView.isSettingView {
//                if changeColorView.isSettingView {
//                    changeColorView.createDataFromPlist()
//                    changeColorView.isSettingView = false
//                    changeColorView.showSettingView(isShow: false)
//                    changeColorView.showTopView(isShow: true)
//                    changeColorView.showTitleView(isShow: true)
//                    changeColorView.removePlus()
//                } else {
//                    changeColorView.addGestureRecognizer(createSwipeGestureRecognizerNew(for: .ended))
//                }
//
//            } else {
//                print("Tapped inside the view")
//
//            }
//        }
        
        guard let location = touch?.location(in: self.view) else { return }
        if changeColorView.frame.contains(location) {
            print("Tapped outside the view")
            changeColorView.setShowCircleIcon()
        } else {
            print("Tapped inside the view")
            
            if changeColorView.isSettingView {
                changeColorView.createDataFromPlist()
                changeColorView.isSettingView = false
                changeColorView.showSettingView(isShow: false)
                changeColorView.showTopView(isShow: true)
                changeColorView.showTitleView(isShow: true)
                changeColorView.removePlus()
            } else {
//                changeColorView.addGestureRecognizer(createSwipeGestureRecognizerNew(for: .began))
//                changeColorView.addGestureRecognizer(createSwipeGestureRecognizerNew(for: .changed))
//                changeColorView.addGestureRecognizer(createSwipeGestureRecognizerNew(for: .ended))
            }
            
        }
        
    }

    //MARK: Funtion
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {

        let image : UIImage = image
        picker.dismiss(animated: false, completion: { () -> Void in
            var imageCropVC : RSKImageCropViewController!
            imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.circle)
            imageCropVC.delegate = self
            self.navigationController?.pushViewController(imageCropVC, animated: true)
        })
    }

}

extension ViewController {
    func setupGif() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 2
        animationView.play()

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
        
//        changeColorView.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
//        changeColorView.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
//
//        let panGesture = UIPanGestureRecognizer(target: self, action:(#selector(self.handleGesture(_:))))
//        self.changeColorView.addGestureRecognizer(panGesture)
        changeColorView.addGestureRecognizer(createSwipeGestureRecognizerNew(for: .began))
        changeColorView.addGestureRecognizer(createSwipeGestureRecognizerNew(for: .changed))
        changeColorView.addGestureRecognizer(createSwipeGestureRecognizerNew(for: .ended))
        
        backgroundView = UIView(frame: ScreenSize)
        backgroundView.backgroundColor = .cgRGBA(rgba: "0 0 0, 0.7")
        self.view.addSubview(backgroundView)
        backgroundView.isHidden = true
        self.view.bringSubviewToFront(changeColorView)
        
        addBackground()

    }
        
    func addBackground() {
        

        if changeColorView.isSettingView {
            backgroundView.isHidden = false
        }
    }
    
//    private func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
//        var swipeGestureRecognizer = UISwipeGestureRecognizer()
//        if changeColorView.isSettingView {
//
//        } else {
//            swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
//            swipeGestureRecognizer.direction = direction
//        }
//
//        return swipeGestureRecognizer
//    }
    
    private func createSwipeGestureRecognizerNew(for direction: UIPanGestureRecognizer.State) -> UIPanGestureRecognizer {
     
        let panGesture = UIPanGestureRecognizer(target: self, action:(#selector(self.handleGesture(_:))))
            panGesture.state = direction
    
        return panGesture
    }

    
    func expandTabBar() {
        var frame = changeColorView.frame
        didExpanded = true
        myViewHeightConstraint.constant = EXPANDTABBAR
        frame.origin.y = max(0.0, frame.origin.y)
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
                print("began")
                _hTabBar = changeColorView.frame.height
            case .changed:
                if _hTabBar - translation.y < EXPANDTABBAR * 1.5 {
                    myViewHeightConstraint.constant = _hTabBar - translation.y
                }
                
            case .ended:
                print("ended")
                
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
    
    func formatText(fullString: NSString) -> NSAttributedString {
        
        let font = UIFont.systemFont(ofSize: 17, weight: .regular)
        let boldFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        

        let textArr = fullString.components(separatedBy: "\n")
        let text1 = textArr[0].components(separatedBy: ":")
        let text2 = textArr[1].components(separatedBy: ":")
        let text3 = textArr[2].components(separatedBy: ":")
        
        
        let boldPartOfString1: NSString = text1[1] as NSString
        let colorText: String = String(text2[1].first == " " ? String(text2[1].dropFirst()) : text2[1])
        let boldPartOfString2: NSString = text3[1] as NSString
        
        let color = colorText.first == "+" ? UIColor.cgRGB(rgb: "0 104 133") : UIColor.cgRGB(rgb: "196 37 63")
        
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font]
        
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont]
                
        let colorAttribute = [NSAttributedString.Key.foregroundColor: color]
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let boldString = NSMutableAttributedString(string: fullString as String, attributes:nonBoldFontAttribute)
        
        boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartOfString1 as String))
        boldString.addAttributes(colorAttribute, range: fullString.range(of: colorText as String))
        boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartOfString2 as String))
        
        return boldString
    }
}
