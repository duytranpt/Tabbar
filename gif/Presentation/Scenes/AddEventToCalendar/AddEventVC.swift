//
//  AddEventVC.swift
//  gif
//
//  Created by Duy Tran on 04/01/2023.
//

import UIKit
import EventKit
import EventKitUI

class AddEventVC: BaseViewController {
    
    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    
    let eventStore = EKEventStore()
    var time = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setHeader(title: "Add Event to Calendar", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navbarHeight.constant = self.navigationBarView!.height
        
        eventStore.requestAccess( to: EKEntityType.event, completion:{(granted, error) in
            DispatchQueue.main.async {
                if (granted) && (error == nil) {
                    let event = EKEvent(eventStore: self.eventStore)
                    event.title = "Bay SGN"
                    event.isAllDay = false
                    event.startDate = self.time
                    event.url = URL(string: "https://apple.com")
                    event.endDate = self.time + 2
                    let alarm1 = EKAlarm(absoluteDate: event.startDate)
                    let alarm2 = EKAlarm(absoluteDate: event.startDate)
                    
                    event.notes = "Chuẩn bị bay"
                    event.alarms = [alarm1, alarm2]
                    
                    let eventController = EKEventEditViewController()
                    eventController.event = event
                    eventController.eventStore = self.eventStore
                    
                    eventController.editViewDelegate = self
                    self.present(eventController, animated: true, completion: nil)
                    
                }
            }
        })
    }
    

   

}

extension AddEventVC: EKEventEditViewDelegate {
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true)
    }
}
