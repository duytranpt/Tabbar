//
//  SettingVC.swift
//  gif
//
//  Created Duy Tran on 14/03/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import PassKit

// MARK: View
final class SettingVC: BaseViewController {
    // MARK: Variables
    
    // MARK: IBOutlet
    @IBOutlet weak var lblContent: UILabel!
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchDataOnLoad()
    }
    
    // MARK: Fetch SettingVC
    private func fetchDataOnLoad() {
        // NOTE: Ask the Interactor to do some work
        
    }
    
    // MARK: SetupUI
    private func setupView() {
        self.setHeader(title: "Cài đặt".localizeString(), subTitle: "", Type: .ONE_LINE_SIMPLE)
        
        self.lblContent.text = "lbl_Hello_Text".localizeString()
    }
    
    // MARK: IBAction
    @IBAction func Eng(_ sender: Any) {
        App.Lang = "en"
        setupView()
    }
    
    @IBAction func Vi(_ sender: Any) {
        App.Lang = "vi"
        setupView()
    }
    
    @IBAction func Ko(_ sender: Any) {
        App.Lang = "ko"
        setupView()
        downloadMultiPass()
    }
}

// MARK: Connect View, Interactor, and Presenter
extension SettingVC {
    func downloadMultiPass() {
//        VNALoading.show()
        let passURLStrings = ["https://pdt.checkin.amadeus.net/1ASIUUNSVN/bp?id=09CEB302E73BBA3B3B70FD2512E81FAA5B033B3F1711268826", "https://pdt.checkin.amadeus.net/1ASIUUNSVN/bp?id=C34559E7F8C83F43C93A1EBE8D4AA82BDB0BC93C1711271524"]
        
        let dispatchGroup = DispatchGroup()
        var lstPass = [PKPass]()
        
        for passURLString in passURLStrings {
            guard let passURL = URL(string: passURLString) else {
                print("Invalid pass URL: \(passURLString)")
                continue
            }
            
            dispatchGroup.enter()
            let session = URLSession.shared
            let task = session.dataTask(with: passURL) { (data, response, error) in
                defer {
                    dispatchGroup.leave()
                }
                
                guard let data = data else {
                    if let error = error {
                        print("Error downloading pass: \(error.localizedDescription)")
                    }
                    return
                }
                
                do {
                    let pass = try PKPass(data: data)
                    lstPass.append(pass)
                } catch {
                    print("Error creating pass: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            // Both passes have been downloaded and processed
            self.handlePass(lstPass)
//            VNALoading.hide()
            print("All passes downloaded")
        }
    }
    
    func handlePass(_ lstPass: [PKPass]) {
        if lstPass.isEmpty {
            return
        }
        
        let passLibrary = PKPassLibrary()
        if passLibrary.containsPass(lstPass.first!) {
            print("Pass already exists in Wallet")
        } else {
            if let pkvc = PKAddPassesViewController(passes: lstPass) {
//                VNALoading.hide()
                self.present(pkvc, animated: true, completion: nil)
            }
        }
    }
}
