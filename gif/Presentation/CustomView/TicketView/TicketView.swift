//
//  TicketView.swift
//  gif
//
//  Created by Duy Tran on 14/07/2023.
//

import UIKit


enum RaceState { case Gate, Laps, Pits }


class TicketView: BaseView {
    
    
    @IBOutlet weak var vContent: UIView!
    @IBOutlet var contentView: UIView!
    
    var type : viewType = .Vertical {
        didSet {
            if oldValue != type {
                switchState(type)
            }
        }
    }
    
    func switchState(_ state : viewType) {
        switch state {
        case .Horizontal:
            contentView.addSemiCircleMaskToView(yPositions: [50], radiusSize: 12, type: .Horizontal)
            vContent.addSemiCircleMaskToView(yPositions: [49], radiusSize: 12, type: .Horizontal)
            
        case .Vertical:
            contentView.addSemiCircleMaskToView(yPositions: [50], radiusSize: 12, type: .Vertical)
            vContent.addSemiCircleMaskToView(yPositions: [49], radiusSize: 12, type: .Vertical)
            
        }
        
    }
    
    override func commonInit() {
        let nib = UINib(nibName: self.className(), bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.contentView.addSemiCircleMaskToView(yPositions: [50], radiusSize: 12, type: type)
        self.vContent.addSemiCircleMaskToView(yPositions: [49], radiusSize: 12, type: type)
    }
    
}
