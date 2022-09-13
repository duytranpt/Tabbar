//
//  DemoVC.swift
//  gif
//
//  Created by Duy Tran on 23/08/2022.
//

import UIKit
import Contacts
import ContactsUI

class DemoVC: UIViewController {
    @IBOutlet weak var navi: NaviBar!
    var myViewHeightConstraint: NSLayoutConstraint!
    private let swipeableView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero,
                                        size: CGSize(width: 200.0, height: 200.0)))
        
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let contacts = self.getContactFromCNContact()
//            for contact in contacts {
//
//                print(contact.middleName)
//                print(contact.familyName)
//                print(contact.givenName)
//                print((contact.phoneNumbers[0].value as CNPhoneNumber).value(forKey: "digits") as! String)
//
//            }

        
        navi.setHeader(title: "Get contact", subtitle: "", type: .VNAHEADER_ONE_LINE_SIMPLE)
        swipeableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(swipeableView)
        
        myViewHeightConstraint = NSLayoutConstraint(item: swipeableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 111)
        myViewHeightConstraint.isActive = true
        swipeableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        swipeableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        swipeableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        swipeableView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        
        swipeableView.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        swipeableView.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
        swipeableView.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        swipeableView.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        
        var frame = swipeableView.frame

        switch sender.direction {
        case .up:
            myViewHeightConstraint.constant = 500
//            frame.origin.y = 100.0
            frame.origin.y = max(0.0, frame.origin.y)
        case .down:
            frame.origin.y = view.bounds.maxY
            myViewHeightConstraint.constant = 111

            if frame.maxY > view.bounds.maxY {
                frame.origin.y = view.bounds.height - frame.height
            }
        case .left:
            print(frame.origin.y)
        case .right:
            print(frame.origin.y)
        default:
            break
        }

        UIView.animate(withDuration: 0.35) {
            self.swipeableView.frame = frame
        }
                
    }
    
    private func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        // Initialize Swipe Gesture Recognizer
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))

        // Configure Swipe Gesture Recognizer
        swipeGestureRecognizer.direction = direction

        return swipeGestureRecognizer
    }

    func getContactFromCNContact() -> [CNContact] {

        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactGivenNameKey,
            CNContactMiddleNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            ] as [Any]

        //Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }

        var results: [CNContact] = []

        // Iterate all containers and append their contacts to our results array
        for container in allContainers {

            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)

            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)

            } catch {
                print("Error fetching results for container")
            }
        }

        return results
    }

    
}
