//
//  LoginVC.swift
//  gif
//
//  Created by Duy Tran on 14/09/2022.
//

import UIKit
import LocalAuthentication


class LoginVC: UIViewController {
   
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    var context = LAContext()

    /// The available states of being logged in or not.
    enum AuthenticationState {
        case loggedin, loggedout
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.clipsToBounds = true
        view1.layer.cornerRadius = 20
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: "MainVC") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
//        context = LAContext()
//
//        context.localizedCancelTitle = "Enter Username/Password"
//
//        // First check if we have the needed hardware support.
//        var error: NSError?
//        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
//            print(error?.localizedDescription ?? "Can't evaluate policy")
//
//            // Fall back to a asking for username and password.
//            // ...
//            return
//        }
//        Task {
//            do {
//                try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Log in to your account")
//                let stb = UIStoryboard(name: "Main", bundle: nil)
//                let vc = stb.instantiateViewController(withIdentifier: "MainVC") as! ViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//
//            } catch let error {
//                print(error.localizedDescription)
//
//                // Fall back to a asking for username and password.
//                // ...
//            }
//        }
    }
}
