//
//  HeaderAlert.swift
//  gif
//
//  Created by Duy Tran on 12/04/2023.
//

import UIKit

class HeaderAlert: UIViewController {

    @IBOutlet weak var PopupView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    weak var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.startTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PopupView.isHidden = false
        self.PopupView.yBottom = 0
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.PopupView.y = 69
        }
        
        
    }
    
    func startTimer() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [weak self] _ in
            guard let wSelf = self else {return}
            wSelf.PopupView.y = 70
            UIView.animate(withDuration: 0.3, delay: 0) {
                wSelf.PopupView.yBottom = 0
            }
            wSelf.dismiss(animated: true)
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }
    
    deinit {
        stopTimer()
    }
    
    func showtitle(title: String) {
        titleLbl.text = title
        titleLbl.numberOfLines = 0
        titleLbl.font = .fontMedium(11)
    }
}
