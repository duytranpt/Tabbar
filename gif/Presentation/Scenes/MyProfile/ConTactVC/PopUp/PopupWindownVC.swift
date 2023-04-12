//
//  PopupWindownVC.swift
//  gif
//
//  Created by Duy Tran on 09/01/2023.
//

import UIKit

class PopupWindownVC: UIViewController {

    var popUpWindowView: PopupContactView!
    var setDetailAction: (() -> Void)?
    var setDeleteAction: (() -> Void)?
    
    init(x: Double, y: Double) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen

        popUpWindowView = PopupContactView(frame: CGRect(x: x - 165, y: y, width: 165, height: 110))
        view.addSubview(popUpWindowView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        popUpWindowView.deleteBtn.addAction { [weak self] in
            guard let wSelf = self else { return }
            if (wSelf.setDeleteAction != nil) {
                wSelf.setDeleteAction!()
            }
        }
        
        popUpWindowView.detailBtn.addAction { [weak self] in
            guard let wSelf = self else { return }
            if (wSelf.setDetailAction != nil) {
                wSelf.setDetailAction!()
            }
        }
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
      }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
