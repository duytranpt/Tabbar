//
//  VNDTSearchFlight.swift
//  gif
//
//  Created by Duy Tran on 18/01/2024.
//

import UIKit

class VNDTSearchFlight: BaseViewController {

    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    @IBOutlet weak var label: VNDTLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeader(title: "Tìm kiếm chuyến bay", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navbarHeight.constant = self.navigationBarView!.height
        
//        let customType = ActiveType.custom(pattern: "\\sLinks are\\b") //Looks for "are"
//        let customType2 = ActiveType.custom(pattern: "\\sit\\b") //Looks for "it"
//        let customType3 = ActiveType.custom(pattern: "\\ssupports\\b") //Looks for "supports"

//        label.enabledTypes.append(customType)
//        label.enabledTypes.append(customType2)
//        label.enabledTypes.append(customType3)
//
//        label.urlMaximumLength = 31
//
//        label.customize { label in
//            label.text = "This is a post with #multiple #hashtags and a userhandle. Links are also supported like" +
//            " this one: http://optonaut.co. Now it also supports custom patterns -> are\n\n" +
//                "Let's trim a long link: \nhttps://twitter.com/twicket_app/status/649678392372121601"
//            label.numberOfLines = 0
//            label.lineSpacing = 4
//            label.textColor = UIColor(red: 102.0/255, green: 117.0/255, blue: 127.0/255, alpha: 1)
//           
//            label.handleMentionTap { self.alert("Mention", message: $0) }
//            label.handleHashtagTap { self.alert("Hashtag", message: $0) }
//            label.handleURLTap { self.alert("URL", message: $0.absoluteString) }
//            
//            label.configureLinkAttribute = { (type, attributes, isSelected) in
//                var atts = attributes
//                switch type {
//                case customType3:
//                    atts[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 14)
//                    atts[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
//                    break
//                default: ()
//                }
//                
//                return atts
//            }
//
//            label.handleCustomTap(for: customType) { self.alert("Custom type", message: $0) }
//            label.handleCustomTap(for: customType2) { self.alert("Custom type", message: $0) }
//            label.handleCustomTap(for: customType3) { self.alert("Custom type", message: $0) }
//        }
        
        let fullString = "Bằng việc bấm Cập nhật, Tôi đã đọc và đồng ý với chính sách bảo mật thông tin, quyền riêng tư của Vietnam Airline."
        label.set(fullString: fullString,
                  part: "Vietnam Airline",
                  mainColor: .cgRGB(rgb: "144 144 144"),
                  partColor: .cgRGB(rgb: "219 163 16"),
                  mainFont: .fontMedium(13), 
                  partFont: .fontBold(13), underLine: true) {
            print("hihi")
        }
        
        
    }
    
    @IBAction func showPopupAction(_ sender: Any) {
        let vndtPopup = VNDTPopupDetailFlight(frame: CGRect(x: 0, y: 0, width: self.screenSize.width, height: self.screenSize.height))
        vndtPopup.show()
    }
    
    
}
