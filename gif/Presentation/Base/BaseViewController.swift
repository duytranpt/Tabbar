//
//  BaseViewController.swift
//  gif
//
//  Created by Duy Tran on 14/12/2022.
//

import UIKit
import SwiftyJSON


class BaseViewController: UIViewController {
    var navigationBarView: VNDTHeaderView?
    let screenSize: CGRect = UIScreen.main.bounds
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
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

extension BaseViewController {
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

extension BaseViewController {
    func showHeaderAlert(titleLbl: String) {
        let storyBoard = UIStoryboard(name: "HeaderAlert", bundle:Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HeaderAlert") as! HeaderAlert
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: false)
        vc.showtitle(title: titleLbl)
    }
}

extension BaseViewController {
//    func generateCustomQRCode(from string: String, size: CGSize, dotScale: CGFloat) -> UIImage? {
//        let generator = QRCodeGenerator()
//        generator.content = string
//        generator.size = size
//        generator.scale = dotScale
//        return generator.image
//    }
    func generateCustomQRCode(from string: String, size: CGSize, dotScale: CGFloat) -> UIImage? {
        let data = string.data(using: .utf8)

        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.setValue("H", forKey: "inputCorrectionLevel")

        guard let qrImage = qrFilter.outputImage else { return nil }

        let scaleX = size.width / qrImage.extent.size.width
        let scaleY = size.height / qrImage.extent.size.height
        let transformedQRImage = qrImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

        let colorFilter = CIFilter(name: "CIFalseColor")
        colorFilter?.setDefaults()
        colorFilter?.setValue(transformedQRImage, forKey: "inputImage")
        colorFilter?.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter?.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")

        if let colorOutput = colorFilter?.outputImage {
            let dotScaledOutput = colorOutput.transformed(by: CGAffineTransform(scaleX: dotScale, y: dotScale))
            let context = CIContext()
            if let cgImage = context.createCGImage(dotScaledOutput, from: dotScaledOutput.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return nil
    }
}
