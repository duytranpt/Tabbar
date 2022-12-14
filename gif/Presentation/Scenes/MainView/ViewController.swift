//
//  ViewController.swift
//  gif
//
//  Created by Duy Tran on 22/08/2022.
//

import UIKit
import Lottie

class ViewController: BaseViewController {
 
        
    //MARK: Outlet
    @IBOutlet weak var navibarHeight: NSLayoutConstraint!
    @IBOutlet weak var changeColorView: TabbarHomeVC!
    @IBOutlet weak var animationView: AnimationView!
    
    var myViewHeightConstraint: NSLayoutConstraint!
    var imagePicker : UIImagePickerController!
    var SMALL_TABBAR: CGFloat = 111
    var EXPANDTABBAR: CGFloat!
    var _hTabBar: CGFloat = 0
    var didExpanded: Bool!
    
    let ScreenSize: CGRect = UIScreen.main.bounds
    var backgroundView: UIView!
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeader(title: "Ứng dụng đọc báo điện tử PressReader", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navibarHeight.constant = self.navigationBarView!.height
        EXPANDTABBAR = getTabbarHeight()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true

        changeColorView.setUpLoadingView(animation: "up")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        changeColorView.removePlus()
        if changeColorView.ListIcon.count > 16 && changeColorView.frame.height == SMALL_TABBAR {
            changeColorView.collectionView.isScrollEnabled = false
        }
    }

    //MARK: Action
        
    //MARK: Setup UI
    
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
                print("VNATABBAR_BOOK_TICKET")
            case .VNATABBAR_LOTUS_SMILE:
                print("VNATABBAR_LOTUS_SMILE")
            case .VNATABBAR_CHECK_IN:
                print("VNATABBAR_CHECK_IN")
            case .VNATABBAR_MY_SEAT:
                print("VNATABBAR_MY_SEAT")
            case .VNATABBAR_MY_SEAT_POSVN:
                print("VNATABBAR_MY_SEAT_POSVN")
            case .VNATABBAR_FOLLOW:
                print("VNATABBAR_FOLLOW")
            case .VNATABBAR_FLIGHT_CALENDER:
                print("VNATABBAR_FLIGHT_CALENDER")
            case .VNATABBAR_VN_HOLLIDAYS:
                print("VNATABBAR_VN_HOLLIDAYS")
            case .VNATABBAR_HOTTEL_BOOKING:
                print("VNATABBAR_HOTTEL_BOOKING")
            case .VNATABBAR_FLIGHT_MAP:
                print("VNATABBAR_FLIGHT_MAP")
            case .VNATABBAR_INFORM:
                print("VNATABBAR_INFORM")
            case .VNATABBAR_SET_UP:
                print("VNATABBAR_SET_UP")
            case .VNATABBAR_MYPROFILE:
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

    func moveToMyProfile() {
        let storyBoard = UIStoryboard(name: "HomeMyProfileViewController", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeMyProfileVC") as! HomeMyProfileViewController
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
}
