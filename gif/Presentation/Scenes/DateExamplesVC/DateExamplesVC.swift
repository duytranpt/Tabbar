//
//  DateExamplesVC.swift
//  gif
//
//  Created by Duy Tran on 29/12/2022.
//

import UIKit

class DateExamplesVC: BaseViewController {

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    @IBOutlet weak var contentLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setHeader(title: "Date Examples", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navbarHeight.constant = self.navigationBarView!.height
        
    }

    @IBAction func buttonTapAction(_ sender: Any) {
        //        dd/MM/yyyy HH:mm:ss
        let dateFormatter = "dd/MM/yyyy"
        guard let dateFromString = Date.dateFromString(textInput.text, withFormat: dateFormatter) else { return }
        guard let formatDate = Date.formatDate(date: dateFromString, format: dateFormatter) else { return }
        let intdate = dateFromString.millisecondsSince1970
        let dateFromInt = Date(milliseconds: intdate)
        guard let dateFromMilliseconds = Date.dateFromMilliseconds(intdate, withFormat: dateFormatter) else { return }
  
        let textContent = "dateFromString: \(dateFromString)\nformatDate: \(formatDate)\nintdate: \(intdate)\ndateFromInt: \(dateFromInt)\ndateFromMilliseconds: \(dateFromMilliseconds)"
        contentLbl.text = textContent
        
    }
    
    
}
