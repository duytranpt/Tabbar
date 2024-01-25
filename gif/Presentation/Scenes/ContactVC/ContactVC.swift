//
//  ContactVC.swift
//  gif
//
//  Created by Duy Tran on 14/09/2022.
//

import UIKit
import Contacts

class ContactVC: BaseViewController, UIDocumentInteractionControllerDelegate, UIDocumentPickerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    
    var contacts = [FetchedContact]()
    var csvString = "Given Name,Family Name,Group Membership,Phone 1 - Value\n"
    var documentInteractionController: UIDocumentInteractionController!
    var urlPath = URL(fileURLWithPath:"")
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setHeader(title: "ContactVC", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navigationBarView?.whiteBackgroud()
        self.navbarHeight.constant = self.navigationBarView!.height
        self.showRightButtonWithImg(img: "icLogout") {
            let url = URL(fileURLWithPath: "file:/var/mobile/Containers/Data/Application/22CC65A5-A59B-4334-BD86-172A2A73ED25/Documents/CSVContactsData.csv")
            self.documentInteractionController = UIDocumentInteractionController(url: self.urlPath)
            self.documentInteractionController.delegate = self
            // Hiển thị tệp CSV
            self.documentInteractionController.presentPreview(animated: true)
        }
        
//        fetchContacts()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "Cell")
        countLabel.text = "\(contacts.count) Số liên lạc"
        contacts = self.replacePhoneNumber(data: contacts)
        createCSV()
        self.exportContact()
//        self.chooseFile()
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
            return self
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    
    func chooseFile() {
           let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
           documentPicker.delegate = self
           documentPicker.allowsMultipleSelection = false
           present(documentPicker, animated: true, completion: nil)
       }

       // Delegate method - Được gọi khi người dùng đã chọn một tệp
       func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
           guard let selectedFileURL = urls.first else {
               return
           }

           // Xử lý tệp tin được chọn ở đây
           print("Đường dẫn tệp được chọn: \(selectedFileURL)")
           urlPath = selectedFileURL
       }

       // Delegate method - Được gọi khi người dùng đã hủy chọn tệp
       func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
           dismiss(animated: true, completion: nil)
       }
    
    func replacePhoneNumber(data: [FetchedContact]) -> [FetchedContact] {
        var contacts = [FetchedContact]()
        for i in data {
            var newPhone = i.telephone.removingWhitespaces()
            if newPhone.excludingLast(char: newPhone.count - 3) == "+84" {
                newPhone = "0\(newPhone.excludingFirst(char: 3))"
            }
            let newi = FetchedContact(firstName: i.firstName, lastName: i.lastName, telephone: newPhone)
            contacts.append(newi)
        }
        
        return contacts
    }
    
    private func fetchContacts() {
        // 1.
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                // 2.
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                let saveRequest = CNSaveRequest()
                do {
                    
                    // 3.
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        self.contacts.append(FetchedContact(firstName: contact.givenName, lastName: contact.familyName, telephone: contact.phoneNumbers.first?.value.stringValue ?? ""))
                        saveRequest.delete(contact.mutableCopy() as! CNMutableContact)
                    })
                    try store.execute(saveRequest)

                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }
    
    func deletaAllcontact() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                let saveRequest = CNSaveRequest()
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        saveRequest.delete(contact.mutableCopy() as! CNMutableContact)
                    })
                    try store.execute(saveRequest)
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }

}

extension ContactVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ContactCell
        
        cell.fillData(data: contacts, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = "\(contacts[indexPath.row].firstName) \(contacts[indexPath.row].lastName)"
        nameLbl.text = name
    }
    
}

extension ContactVC {
    
    func createCSV() {
        
        for (index, element) in contacts.enumerated() {
            if element.telephone.string_not_empty()! {
                let firstName = element.firstName.debugDescription.split(separator: "-")[0].replacingOccurrences(of: ")", with: "")
                let telephone = element.telephone
                let lastName = element.lastName
                
                let Membership = "* myContacts"
                
                let dataString = "\(firstName),\(lastName),\(Membership),\(telephone)\n"
                print("\(index + 1): \(dataString)")
                csvString = csvString.appending(dataString)
            }
            
        }
        
        
    }
    
    func exportContact() {
        let fileManager = FileManager.default
        do {
            let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
            print("PATH: \(path)")
            
            let fileURL = path.appendingPathComponent("CSVContactsData.csv")
            urlPath = fileURL
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            
            
            let activityVC = UIActivityViewController(activityItems: [URL(fileURLWithPath: fileURL.absoluteString)],
                                                      applicationActivities: nil)
            present(activityVC, animated: true)
            
        } catch {
            print("error creating file")
        }
    }
    
//    func deleteAllContacts() {
//        let contactStore = CNContactStore()
//        
//        contactStore.requestAccess(for: .contacts) { (granted, error) in
//            if granted {
//                let keys = [CNContactPhoneNumbersKey] as [CNKeyDescriptor]
//                let containerId = contactStore.defaultContainerIdentifier
//                
//                if let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId) {
//                    do {
//                        let cnContacts = try contactStore.unifiedContacts(matching: predicate, keysToFetch: keys)
//                        
//                        let saveRequest = CNSaveRequest()
//                        
//                        for contact in cnContacts {
//                            saveRequest.delete(contact.mutableCopy() as! CNMutableContact)
//                        }
//                        
//                        try contactStore.execute(saveRequest)
//                        print("Deleted contacts: \(cnContacts.count)")
//                    } catch {
//                        print("Error fetching or deleting contacts: \(error)")
//                    }
//                } else {
//                    print("Error creating predicate for contacts in container.")
//                }
//            }
//        }
//    }
    
}
