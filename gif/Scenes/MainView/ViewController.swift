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



class ViewController: UIViewController, RSKImageCropViewControllerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {

    }
        
    //MARK: Outlet
    @IBOutlet weak var newView: UIView!
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
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EXPANDTABBAR = getTabbarHeight()
        setupUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(changeColorView.frame.height)
        changeColorView.removePlus()
        if changeColorView.ListIcon.count > 16 && changeColorView.frame.height == SMALL_TABBAR {
            changeColorView.collectionView.isScrollEnabled = false
        }

    }

    
    //MARK: Setup UI
    
    func setupUI() {
        didExpanded = false
        setupTabbar()
        setupGif()
        navBarView.setHeader(title: "Ứng dụng đọc báo điện tử PressReader", subtitle: "", type: .VNAHEADER_ONE_LINE_SIMPLE)
        buttonView.setupButton(animation: "gift-on-the-way", title: "Ví gia đình")
        ic2.setupButton(animation: "ic1", title: "VNPAY")
        ic3.setupButton(animation: "ic2", title: "Demo")
        ic4.setupButton(animation: "ic1", title: "Test")
        
        ic3.ButtonAnimation.addTarget(self, action: #selector(tapbtn), for: .touchUpInside)
        ic3.ButtonAnimation.tag = 3
        ic4.ButtonAnimation.addTarget(self, action: #selector(tapbtn), for: .touchUpInside)
        ic4.ButtonAnimation.tag = 4
    }
    
    @objc func tapbtn(sender: UIButton) {
        
        switch sender.tag {
        case 3:
            Defaults.set(listIT: changeColorView.ListIcon)
        case 4:
            print("Defaults: \(Defaults.getListIC())")
        default:
            break
        }
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
                changeColorView.addGestureRecognizer(createSwipeGestureRecognizerNew(for: .changed))
                changeColorView.addGestureRecognizer(createSwipeGestureRecognizerNew(for: .ended))
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
