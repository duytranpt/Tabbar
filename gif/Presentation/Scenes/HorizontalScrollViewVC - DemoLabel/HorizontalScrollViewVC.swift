//
//  HorizontalScrollViewVC.swift
//  gif
//
//  Created by Duy Tran on 29/12/2022.
//

import UIKit

class HorizontalScrollViewVC: BaseViewController {
    @IBOutlet weak var demoSegment: CustomSegmentedControl!
    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    
    var scView:UIScrollView!
    let buttonPadding:CGFloat = 10
    var xOffset:CGFloat = 10
    var lastTag: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setHeader(title: "Horizontal ScrollView", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navbarHeight.constant = self.navigationBarView!.height
        
        
        scView = UIScrollView(frame: CGRect(x: 20, y: 120, width: view.bounds.width - 40, height: 50))
        scView.isPagingEnabled = true
        view.addSubview(scView)
        scView.backgroundColor = UIColor.blue

        for i in 1 ... 10 {
            let button = UIButton()
            button.tag = i
            lastTag = i
            button.backgroundColor = UIColor.darkGray
            button.setTitle("\(i)", for: .normal)
            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 70, height: 30)
            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            scView.addSubview(button)
            
        }
        
        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)

        
        let content: NSString = "Bằng việc bấm Cập nhật,\nTôi đã đọc và đồng ý với chính sách bảo mật thông tin, quyền riêng tư của Vietnam Airline"
        let arrBold: [NSString] = ["Cập nhật", "chính sách bảo mật thông tin, quyền riêng tư", "Vietnam Airline"]
        
        

    }
    
    @objc func buttonTapped(sender: UIButton) {
        print(sender.tag)
        sender.isSelected = !sender.isSelected
        sender.backgroundColor = sender.isSelected ? .red:.darkGray
        let index = sender.tag - 1
       
//        let subview3 = scView.subviews.first(where: { $0.initialIndex == index })
//        if let index3 = subview3?.initialIndex {
//            scView.swapSubViewsWithIndex(index3)
//        }
        scView.swapSubViewsWithIndex(index)
    }

    
    
    @IBAction func buttonAction(_ sender: UIButton) {
    
        self.callNumber(phoneNumber: "0964151505")
        
    }
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}

extension UIScrollView {
    func swapSubViewsWithIndex(_ index: Int) {
        guard index > 0 && index < subviews.count else { return }

        let view1 = subviews[index]
        let view2 = subviews[0]

        let frame1 = view1.frame
        let frame2 = view2.frame

        view1.frame = frame2
        view2.frame = frame1
        subviews[index].tag = 1
        subviews[0].tag = index + 1
        exchangeSubview(at: 0, withSubviewAt: index)
        self.scrollRectToVisible(subviews[0].frame, animated: true)
    }
    
    
}

extension UIView {
    private struct AssociatedKeys {
        static var initialIndex = "initialIndex"
    }

    var initialIndex: Int {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.initialIndex) as? Int else {
                return -1
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.initialIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
