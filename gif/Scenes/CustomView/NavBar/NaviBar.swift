//
//  NaviBar.swift
//  gif
//
//  Created by Duy Tran on 24/08/2022.
//

import Foundation
import UIKit

class NaviBar: UIView {
    
    @IBOutlet var contentView: Gradient!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    let navigationController = UINavigationController()
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("NaviBar", owner: self)
        contentView.fixInView(self)
        addSubview(contentView)
        rightBtn.isHidden = true
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.textAlignment = .center
//        titleLabel.contentMode = .top
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
    }
    
    

  

    func setHeader(title: String, subtitle: String, type: HEADER_TYPE) {
        titleLabel.text = title
        
        switch type {
        case .VNAHEADER_TWO_LINE:
            
            titleLabel.text = "\(title) \n \(subtitle)"
        case .VNAHEADER_ONE_LINE_SIMPLE:
            print("22222")
            break
            
        }
        
        leftBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    func showRightBtn() {
        rightBtn.isHidden = false
        
    }
    
    func rightAction() {
        
        
    }
    
    @objc func backAction() {
        print("Hể")
        self.navigationController.popViewController(animated: true)
    }
    
}

extension UIView {
    func fixInView(_ superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: NavbarHeight().navbarHeight).isActive = true
    }
}



