//
//  BaseViewController.swift
//  gif
//
//  Created by Duy Tran on 14/12/2022.
//

import UIKit

class BaseViewController: UIViewController {
    var navigationBarView: VNDTHeaderView?
    let screenSize: CGRect = UIScreen.main.bounds
    
    func setHeader(title: String, subTitle: String, Type: VNDTHeaderView.VNDTHEADERTYPE) {
        navigationBarView = VNDTHeaderView(initHeaderView: title, subTitle: subTitle, type: Type, nav: self.navigationController, andFrame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: self.view.navbarHeight())))
        view.addSubview(navigationBarView!)
    }
    
    func hideAllButton() {
        navigationBarView?.rightButton?.isHidden = true
        navigationBarView?.backButton?.isHidden = true
    }
    
    func setBackAction(_ callback: @escaping () -> Void) {
        if (navigationBarView != nil) {
            navigationBarView!.backButton?.removeTarget(
                nil,
                action: nil,
                for: .allEvents)
            navigationBarView!.backButton?.addAction {
                callback()
            }
        }
    }
    
    func backtoViewController(parentVC: UIViewController) {
        if parentVC == nil {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            self.navigationController?.popToViewController(parentVC, animated: true)
        }
    }
    
    func showRightButton(_ callback: @escaping () -> Void) {
        self.navigationBarView?.showRightButton(action: {
            callback()
        })
    }
    
    func showRightButtonWithImg(img: String, _ callback: @escaping () -> Void) {
        self.navigationBarView?.showRightButtonWithImg(img: img, {
            callback()
        })
    }}

extension BaseViewController {
    
    func showNewAlertOkay(withMessage message:String, action: @escaping () -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            action()
        })
        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    func setApplicationIconName(_ iconName: String?) {
        if UIApplication.shared.responds(to: #selector(getter: UIApplication.supportsAlternateIcons)) && UIApplication.shared.supportsAlternateIcons {
            
            typealias setAlternateIconName = @convention(c) (NSObject, Selector, NSString?, @escaping (NSError) -> ()) -> ()
            
            let selectorString = "_setAlternateIconName:completionHandler:"
            
            let selector = NSSelectorFromString(selectorString)
            let imp = UIApplication.shared.method(for: selector)
            let method = unsafeBitCast(imp, to: setAlternateIconName.self)
            method(UIApplication.shared, selector, iconName as NSString?, { _ in })
        }
    }
}
