//
//  TimePickerToolBarView.swift
//  gif
//
//  Created by Duy Tran on 04/01/2023.
//

import UIKit

class TimePickerToolBarView: UIView {
    
    var date: Date?
    var datePicker: UIDatePicker?
    var hasToolBar: Bool?
    let SCREEN_WIDTH = UIScreen.main.bounds.width
    var doneAction: (() -> Void)?
    var cancelAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _init()
    }
    
    init?(_ andFrame: CGRect?) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 216))
        _init()
    }
    
    private func createUIToolBar() -> UIToolbar {
        let pickerToolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: self.width, height: 44)))
        
        //customize the toolbar
        pickerToolbar.barStyle = .default
        pickerToolbar.backgroundColor = UIColor.white
        pickerToolbar.isTranslucent = false
        // add buttons
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Xong", style: .done, target: self, action: #selector(onClickDoneButton))
        let cancelButton = UIBarButtonItem(title: "Huỷ", style: .done, target: self, action: #selector(onClickCancelButton))
        doneButton.tintColor = .rgbColor(red: 5, green: 101, blue: 130, alpha: 1)
        cancelButton.tintColor = .rgbColor(red: 5, green: 101, blue: 130, alpha: 1)
        
        //add the items to the toolbar
        pickerToolbar.items = [cancelButton, space, doneButton]
        return pickerToolbar

    }
    
    @objc func timeChanged(_ sender: UIDatePicker) {
       
    }
    
    @objc func onClickDoneButton(_ button: UIBarButtonItem?) {
        if (doneAction != nil) {
            doneAction!()
        }
    }
    
    @objc func onClickCancelButton(_ button: UIBarButtonItem?) {
        if (cancelAction != nil) {
            cancelAction!()
        }
    }
}

extension TimePickerToolBarView {
    func show(in view: UIView?, with date: Date?, animated: Bool) {
        if view == nil {
            return
        }
        
        if date == nil {
            self.date = datePicker?.maximumDate
        }
        var v = view?.viewWithTag(204)
        if v == nil {
            var r = view?.frame
            r?.origin = CGPoint.zero
            v = UIView(frame: r!)
            v?.tag = 204
            v?.backgroundColor = .rgbColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            view?.addSubview(v!)
        }
        
        view?.bringSubviewToFront(v!)
        v?.isHidden = false
        if view?.subviews.contains(self) == false {
            view?.addSubview(self)
        }
        
        var frameAppear = self.frame
        frameAppear.origin.y = view!.height - frameAppear.size.height
        var frameAnimated = self.frame
        frameAnimated.origin.y = view!.height
        if animated {
            self.frame = frameAnimated
        } else {
            self.frame = frameAppear
        }
        view?.bringSubviewToFront(self)
        self.isHidden = false
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.frame = frameAppear
            } completion: { finished in
                
            }
        }
    }
    
    func setDate(_ date: Date?) {
        if date != self.date {
            self.date = date
            datePicker!.setDate(date!, animated: true)
        }
    }
    
    func _init() {
        backgroundColor = UIColor.white
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: width, height: 216))
        datePicker?.backgroundColor = UIColor.white
        
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
           } else {
               // Fallback on earlier versions
           }
        datePicker?.centerX = width / 2
        datePicker?.locale = Locale(identifier: "vi_VN")
        addSubview(datePicker!)
        
    }
    
    func setDatePickerMode(datePickerMode: UIDatePicker.Mode) {
        datePicker?.datePickerMode = datePickerMode
        if datePicker?.superview == nil {
            datePicker?.centerX = self.width/2
            self.addSubview(datePicker!)
        }
        
        if hasToolBar! {
            var r = self.frame
            r.origin.y = 44
            datePicker?.frame = r
            datePicker?.centerX = self.width/2
            r.origin = self.frame.origin
            r.size.height += 44
            self.frame = r
            let toolbar = self.createUIToolBar()
            self.addSubview(toolbar)
        }
    }
    
    func hide() {
        var supperView = self.superview
        var v = supperView?.viewWithTag(204)
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            
            v!.isHidden = true
            var r = self.frame
            r.origin.y = supperView!.frame.size.height
            self.frame = r

        }) { [self] finished in
            self.removeFromSuperview()
            v!.removeFromSuperview()
        }
        
    }
    
}

