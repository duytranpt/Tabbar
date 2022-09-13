//
//  ChooseColorView.swift
//  gif
//
//  Created by Duy Tran on 26/08/2022.
//

import UIKit

protocol PopupColor: AnyObject {
    func close()
    func chooseColor(colorType: Int)
    func changesettingView()
}

class ChooseColorView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var color1: UIImageView!
    @IBOutlet weak var color2: UIImageView!
    @IBOutlet weak var color3: UIImageView!
    @IBOutlet weak var color4: UIImageView!
    @IBOutlet weak var colorlist: UIStackView!
    @IBOutlet weak var chooseColorPopup: UIView!
    
    @IBOutlet weak var viewChangeColors2: UIView!
    @IBOutlet weak var viewChangeColors: UIView!
    weak var delegate: PopupColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Loadnib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Loadnib()
        
    }

    func Loadnib() {
        Bundle.main.loadNibNamed("ChooseColorView", owner: self)
        contentView.fixInView(self)
        chooseColorPopup.roundCorners(radius: 20, corners: .allCorners)
    }
    
    func setShowColor(_ isShow: Bool) {
        self.colorlist.isHidden = !isShow
    }
    

    func setupUI(colorType: Int) {
        self.color1.image = UIImage(named: "ellipse1")
        self.color2.image = UIImage(named: "ellipse2")
        self.color3.image = UIImage(named: "ellipse3")
        self.color4.image = UIImage(named: "ellipse4")
        
        switch colorType {
        case 1:
            self.color1.image = UIImage(named: "ellipse1Check")
            Defaults.setColor(value: 1)
            print("Defaults1: \(Defaults.getColor())")
            break
        case 2:
            self.color2.image = UIImage(named: "ellipse2Check")
            Defaults.setColor(value: 2)
            print("Defaults2: \(Defaults.getColor())")
            break
        case 3:
            self.color3.image = UIImage(named: "ellipse3Check")
            Defaults.setColor(value: 3)
            print("Defaults3: \(Defaults.getColor())")
            break
        case 4:
            self.color4.image = UIImage(named: "ellipse4Check")
            Defaults.setColor(value: 4)
            print("Defaults4: \(Defaults.getColor())")
            break
        default:
            break
        }
    }
    
    func setupColor(indexColor: Int) {
        setupUI(colorType: indexColor)
    }
    
    func setShowColor(isShow: Bool) {
        viewChangeColors.isHidden = !isShow
        viewChangeColors2.isHidden = !isShow
    }
    
    @IBAction func chooseColorAction(_ sender: UIButton) {
        delegate?.chooseColor(colorType: sender.tag)
        setupUI(colorType: sender.tag)
    }
    
    @IBAction func reOrderAction(_ sender: Any) {
        print("bruhhh")
        delegate?.changesettingView()
    }
    
    @IBAction func closePopup(_ sender: UIButton) {
//        print("Close!!")
        delegate?.close()
    }
}
