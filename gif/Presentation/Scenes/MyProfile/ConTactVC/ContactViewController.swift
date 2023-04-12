//
//  ContactViewController.swift
//  gif
//
//  Created by Duy Tran on 05/01/2023.
//

import UIKit
import SwiftyJSON

class ContactViewController: BaseViewController {

    @IBOutlet weak var navbarHeight: NSLayoutConstraint!
    @IBOutlet weak var profileView: ProfileView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var listPaxIsEmptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listPaxNotEmptyView: UIView!
    
    var listPax = UserDefaults.getInfor()?.listPax
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setHeader(title: "Danh bạ hành khách", subTitle: "", Type: .ONE_LINE_SIMPLE)
        self.navbarHeight.constant = self.navigationBarView!.height
        
        let profileData: ProfileHomeModel = ProfileHomeModel(displayName: "Duy Tran", phoneNumber: "0964151505", profileID: "915540639351980032")
        
        profileView.fillData(data: profileData)
        setupTableView()
        addBtn.addAction { [weak self] in
            guard let wSelf = self else { return }
            let storyBoard = UIStoryboard(name: "AddNewContactVC", bundle:Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddNewContactVC") as! AddNewContactVC
            wSelf.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listPax = UserDefaults.getInfor()?.listPax
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "VNATableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "VNATableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionFooterHeight = 12
        tableView.backgroundColor = .clear
       
    }

    //Action:
    
    @IBAction func deleteAllPaxAction(_ sender: Any) {
        self.listPax?.removeAll()
        var data = UserDefaults.getInfor()
        data?.listPax?.removeAll()
        UserDefaults.saveUserData(userData: data!)
        self.tableView.reloadData()
        self.listPaxIsEmptyView.isHidden = false
        self.listPaxNotEmptyView.isHidden = true
    }
    
    
}

extension ContactViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.listPax?.count == 0 {
            self.listPaxIsEmptyView.isHidden = false
            self.listPaxNotEmptyView.isHidden = true
        }
        
        return self.listPax?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "VNATableViewCell", for: indexPath) as! VNATableViewCell
        
        cell.fillData(data: listPax!, indexPath: indexPath)
        cell.setMoreAction = { [weak self] in
            guard let wSelf = self else { return }
            let buttonPosition = CGPoint(x: cell.moreBtn.frame.origin.x, y: cell.moreBtn.frame.origin.y)
            let converPosition = cell.moreBtn.superview!.convert(buttonPosition, to: wSelf.view)
        
            var popUpWindow: PopupWindownVC!
            popUpWindow = PopupWindownVC(x: converPosition.x, y: converPosition.y)
            wSelf.present(popUpWindow, animated: true, completion: nil)
            
            popUpWindow.setDetailAction = {
                let storyBoard = UIStoryboard(name: "InforContactVC", bundle:Bundle.main)
                let vc = storyBoard.instantiateViewController(withIdentifier: "InforContactVC") as! InforContactVC
                
                vc.paxData = wSelf.listPax?[indexPath.section]
                wSelf.dismiss(animated: true)
                wSelf.navigationController?.pushViewController(vc, animated: true)
            }

            popUpWindow.setDeleteAction = {
                wSelf.dismiss(animated: true)
                
                wSelf.deletePax(id: wSelf.listPax?[indexPath.section].paxId)
                tableView.beginUpdates()
                tableView.deleteSections([indexPath.section], with: .left)
                tableView.endUpdates()
                tableView.reloadData()
            }
        }
        return cell
    }
}

extension ContactViewController {
    func deletePax(id: String?) {
        for (index, element) in listPax!.enumerated() {
            if id == element.paxId {
                self.listPax?.remove(at: index)
                var data = UserDefaults.getInfor()
                data?.listPax?.remove(at: index)
                UserDefaults.saveUserData(userData: data!)
            }
        }
    }
}
