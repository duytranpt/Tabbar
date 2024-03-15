//
//  SettingVC.swift
//  gif
//
//  Created Duy Tran on 14/03/2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

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

    }
}

// MARK: Connect View, Interactor, and Presenter
extension SettingVC {
    
}
