//
//  VNBAlertController.swift
//  gif
//
//  Created by Duy Tran on 17/01/2023.
//

import UIKit

class VNBAlertController: UIViewController {

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
}
