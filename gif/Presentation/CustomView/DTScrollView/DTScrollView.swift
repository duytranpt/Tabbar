//
//  DTScrollView.swift
//  gif
//
//  Created by Duy Tran on 20/12/2022.
//

import UIKit

class DTScrollView: TPKeyboardAvoidingScrollView {
    
    var listItems: [UIView]?
    var posY: CGFloat = 0.0
    var heightContent: CGFloat = 0.0
    private var xxxLastOffset: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        listItems = [UIView]()
    }
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        
        if view.isKind(of: UIImageView.self) {
            return
        }
        
        view.y = posY
        posY += view.height
        listItems?.append(view)
        self.contentSize = CGSize(width: self.width, height: posY + xxxLastOffset)
        
    }

    func resetOffsetView() {
        var oldOffset = self.contentOffset
        var startY: CGFloat = 0
        for item in listItems! {
            item.setPositionY(startY)
            startY += item.height
        }
        
        var size = self.contentSize
        size.height = startY + 20
        self.contentSize = size
        if size.height + 216 + 40 <= self.height {
            oldOffset.y = 0
        }
        self.setContentOffset(oldOffset, animated: true)
    }
    
    func removeAllItems() {
        listItems = [UIView]()
        self.removeAllSubviews()
        posY = 0
    }
    
    func removeItem(item: UIView) {
        for i in 0...listItems!.count {
            let curr_Itemt = listItems![i]
            if curr_Itemt == item {
                posY -= item.height
                listItems?.remove(at: i)
                item.removeFromSuperview()
            }
        }
    }
    
    func realHeight() -> CGFloat {
        var heig: CGFloat = 0
        for curr_Itemt in listItems! {
            heig = heig + curr_Itemt.height
        }
        return heig
    }
    
    func addSeperator(_ heightSepe: Float, andColor color: UIColor?, margin: CGFloat) {
        let seperator = UIView(frame: CGRect(x: margin, y: posY, width: width - 2 * margin, height: CGFloat(heightSepe)))
        seperator.backgroundColor = color
        addSubview(seperator)
    }
    
    func addSeperator(_ heightSepe: Float, andColor color: UIColor?) {
        addSeperator(heightSepe, andColor: color, margin: 15)
    }
    
}
