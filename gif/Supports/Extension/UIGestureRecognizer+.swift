//
//  UIGestureRecognizer+.swift
//  gif
//
//  Created by Duy Tran on 14/12/2022.
//

import UIKit

extension UIGestureRecognizer {
    typealias Action = ((UIGestureRecognizer) -> ())
    
    private struct Keys {
        static var actionKey = "ActionKey"
    }
    
    private var block: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &Keys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        
        get {
            let action = objc_getAssociatedObject(self, &Keys.actionKey) as? Action
            return action
        }
    }
    
    @objc func handleAction(recognizer: UIGestureRecognizer) {
        block?(recognizer)
    }
    
    convenience public  init(block: @escaping ((UIGestureRecognizer) -> ())) {
        self.init()
        self.block = block
        self.addTarget(self, action: #selector(handleAction(recognizer:)))
    }
    
    
}

