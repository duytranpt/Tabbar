//
//  NewVC.swift
//  gif
//
//  Created by Duy Tran on 24/08/2022.
//

import UIKit

class NewVC: UIViewController {

    @IBOutlet weak var navi: NaviBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navi.setHeader(title: "New VC", subtitle: "", type: .VNAHEADER_ONE_LINE_SIMPLE)
        
    }
    

}
