//
//  TabbarHomeVC.swift
//  gif
//
//  Created by Duy Tran on 30/08/2022.
//

import UIKit
import Lottie


class TabbarHomeVC: UIView {
    
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var contentView: Gradient!
    @IBOutlet weak var topView: UIView!
    let insetSection = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    let itemPerRow: Int = 4
    var popupChooseColor: ChooseColorView!
    var isSettingView: Bool = false
    var isLongPress: Bool = false
    var ListIcon: [VNATabBarIconModel] = []
    var ListIconDefault: [VNATabBarIconModel] = []
    var listCircleView: [UIView] = []
    var listPlusView: [UIView] = []
    let ScreenSize: CGRect = UIScreen.main.bounds
    var HomeItem: HomeIcon!
    var loadingAnimation: LottieAnimationView?
    var tabBarCallback: ((_ actionStr: VNAHOMETABBARACTION) -> Void)?
    
    enum VNAHOMETABBARACTION : Int {
        case VNATABBAR_HOME = 0
        case VNATABBAR_BOOK_TICKET = 1
        case VNATABBAR_LOTUS_SMILE = 2
        case VNATABBAR_CHECK_IN = 3
        case VNATABBAR_MY_SEAT = 4
        case VNATABBAR_MY_SEAT_POSVN = 44
        case VNATABBAR_FOLLOW = 5
        case VNATABBAR_FLIGHT_CALENDER = 6
        case VNATABBAR_VN_HOLLIDAYS = 7
        case VNATABBAR_HOTTEL_BOOKING = 8
        case VNATABBAR_FLIGHT_MAP = 9
        case VNATABBAR_INFORM = 10
        case VNATABBAR_SET_UP = 11
        case VNATABBAR_MYPROFILE = 12
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        Bundle.main.loadNibNamed("TabbarHomeVC", owner: self)
        contentView.fixInView(self)
        self.addSubview(contentView)
        let ListHomeItem = parseConfig()
        if Defaults.get() == nil || Defaults.get()?.version != ListHomeItem.version {
            createDataFromPlist()
        } else {
            ListIcon = Defaults.getListIC() == nil ? Defaults.get()!.ListIcon : Defaults.getListIC() ?? []
        }
        if Defaults.getColor() == 0 {
            let colorValue: Int = Defaults.get()!.BgColor
            Defaults.setColor(value: colorValue)
        }
        ListIconDefault = ListIcon
        chooseColor(colorType: Defaults.getColor())
        setupCollectionView()
        showSettingView(isShow: false)
        removePlus()
    }
    
    
    func createDataFromPlist() {
        let ListHomeItem = parseConfig()
        Defaults.set(list: ListHomeItem)
        ListIcon = Defaults.get()!.ListIcon
        collectionView.reloadData()
    }
    
    func parseConfig() -> HomeIcon {
        let url = Bundle.main.url(forResource: "NewHome", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(HomeIcon.self, from: data)
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragInteractionEnabled = false
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        if ListIcon.count > 16 {
            collectionView.isScrollEnabled = true
        }
        collectionView.register(UINib(nibName: "iconCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.contentSize = CGSize(width: ScreenSize.width, height: 77)
        
    }
    
    func unchangeIconPossition() {
        ListIcon = ListIconDefault
        collectionView.reloadData()
    }
    
    func setShowCircleIcon() {
        var indexPath: NSIndexPath
        for i in 0..<ListIcon.count {
            indexPath = NSIndexPath(row: i, section: 0)
            let cell = self.collectionView(collectionView, cellForItemAt: indexPath as IndexPath) as! iconCell
            cell.setupUI(value: ListIcon[i], setHightLight: false, didExpandTabbar: true)
        }
    }
    
    func setUpLoadingView(animation: String) {
        
        if (self.loadingAnimation != nil) {
            self.loadingAnimation!.removeFromSuperview()
        }
        
        let rect = CGRect(origin: .zero, size: CGSize(width: 34, height: 16))
        
        loadingAnimation = .init(name: animation)
        loadingAnimation!.frame = animationView.bounds
        
        loadingAnimation!.contentMode = .scaleAspectFit
        loadingAnimation!.loopMode = .loop
        loadingAnimation!.animationSpeed = 1
        animationView.addSubview(loadingAnimation!)
        loadingAnimation!.play()
    }
    
    func closePopup() {
        self.popupChooseColor?.removeFromSuperview()
    }
    
    
    func showSettingView(isShow: Bool) {
        if isShow {
            settingView.nsHeight.constant = 67.5
            settingView.isHidden = false
        } else {
            settingView.nsHeight.constant = 0
            settingView.isHidden = true
        }
    }
    
    func removePlus() {
        for i in listPlusView {
            i.removeFromSuperview()
        }
        
        self.listPlusView.removeAll()
        
        for i in listCircleView {
            i.removeFromSuperview()
        }
        
        self.listCircleView.removeAll()
    }
    
    func showTopView(isShow: Bool) {
        if isShow {
            topView.nsHeight.constant = 22
            topView.isHidden = false
        } else {
            topView.nsHeight.constant = 0
            topView.isHidden = true
        }
    }
    
    func showTitleView(isShow: Bool) {
        if isShow {
            titleView.nsHeight.constant = 54
            titleView.isHidden = false
        } else {
            titleView.nsHeight.constant = 0
            titleView.isHidden = true
        }
    }
    
    //MARK: Action
    @IBAction func restore(_ sender: Any) {
        createDataFromPlist()
        isSettingView = false
        showSettingView(isShow: false)
        showTopView(isShow: true)
        showTitleView(isShow: true)
        removePlus()
        print("ListIcon: \(ListIcon)")
        Defaults.set(listIT: ListIcon)
    }
    
    @IBAction func save(_ sender: Any) {
        collectionView.dragInteractionEnabled = false
        isSettingView = false
        showSettingView(isShow: false)
        showTopView(isShow: true)
        showTitleView(isShow: true)
        removePlus()
        ListIconDefault = ListIcon
        Defaults.set(listIT: ListIcon)
    }
    
    @IBAction func showChooseColorPopup(_ sender: UIButton) {
        popupChooseColor = ChooseColorView()
        popupChooseColor.setupColor(indexColor: Defaults.getColor())
        popupChooseColor.translatesAutoresizingMaskIntoConstraints = false
        popupChooseColor.delegate = self
        popupChooseColor.fixInView(contentView)
        contentView.addSubview(popupChooseColor)
    }
}

extension TabbarHomeVC: PopupColor {
    func chooseColor(colorType: Int) {
        switch colorType {
        case 1:
            contentView.startColor = .rgbColor(red: 45, green: 103, blue: 130, alpha: 1)
            contentView.endColor = .rgbColor(red: 2, green: 57, blue: 91, alpha: 1)
        case 2:
            contentView.startColor = .rgbColor(red: 0, green: 57, blue: 92, alpha: 1)
            contentView.endColor = .rgbColor(red: 8, green: 39, blue: 59, alpha: 1)
        case 3:
            contentView.startColor = .rgbColor(red: 24, green: 133, blue: 186, alpha: 1)
            contentView.endColor = .rgbColor(red: 8, green: 70, blue: 100, alpha: 1)
        case 4:
            contentView.startColor = .rgbColor(red: 135, green: 158, blue: 173, alpha: 1)
            contentView.endColor = .rgbColor(red: 72, green: 87, blue: 96, alpha: 1)
        default:
            break
        }
    }
    
    func close() {
        closePopup()
    }
    
    func changesettingView() {
        collectionView.reloadData()
        isSettingView = true
        closePopup()
        showSettingView(isShow: true)
        showTopView(isShow: false)
        showTitleView(isShow: false)
        
    }
}


extension TabbarHomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListIcon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! iconCell
        let title = ListIcon[indexPath.item].title
        let icon = ListIcon[indexPath.item].icon
        cell.title.text = title
        cell.icon.image = UIImage(named: "\(icon)")
        
        if isSettingView {
            collectionView.dragInteractionEnabled = true
            if self.listCircleView.count < 16 {
                var circleContainerView: UIView!
                circleContainerView = UIView(frame: cell.frame)
                circleContainerView.backgroundColor = .clear
                self.collectionView.addSubview(circleContainerView)
                collectionView.sendSubviewToBack(circleContainerView)
                
                var xTiny: UIView!
                xTiny = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 48, height: 48)))
                xTiny.translatesAutoresizingMaskIntoConstraints = false
                circleContainerView.addSubview(xTiny)
                
                xTiny.backgroundColor = .clear
                xTiny.layer.cornerRadius = 24
                xTiny.layer.borderWidth = 0.25
                xTiny.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
                xTiny.topAnchor.constraint(equalTo: circleContainerView.topAnchor).isActive = true
                xTiny.centerXAnchor.constraint(equalTo: circleContainerView.centerXAnchor).isActive = true
                xTiny.widthAnchor.constraint(equalToConstant: 48).isActive = true
                xTiny.heightAnchor.constraint(equalToConstant: 48).isActive = true
                
                if indexPath.row == 0 {
                    circleContainerView.isHidden = true
                }
                self.listCircleView.append(circleContainerView)
                
                if ((indexPath.row + 1) % 4) != 0 {
                    let xPlus = UIView()
                    xPlus.backgroundColor = .clear
                    xPlus.translatesAutoresizingMaskIntoConstraints = false
                    collectionView.addSubview(xPlus)
                    
                    xPlus.topAnchor.constraint(equalTo: circleContainerView.bottomAnchor).isActive = true
                    xPlus.leadingAnchor.constraint(equalTo: circleContainerView.trailingAnchor).isActive = true
                    xPlus.heightAnchor.constraint(equalToConstant: 16).isActive = true
                    xPlus.widthAnchor.constraint(equalToConstant: 16).isActive = true
                    
                    
                    let xVertical = UIView()
                    xVertical.backgroundColor = UIColor(white: 1, alpha: 0.3)
                    xVertical.translatesAutoresizingMaskIntoConstraints = false
                    xPlus.addSubview(xVertical)
                    
                    xVertical.widthAnchor.constraint(equalToConstant: 1).isActive = true
                    xVertical.heightAnchor.constraint(equalToConstant: 16).isActive = true
                    xVertical.centerXAnchor.constraint(equalTo: xPlus.centerXAnchor).isActive = true
                    xVertical.centerYAnchor.constraint(equalTo: xPlus.centerYAnchor).isActive = true
                    
                    let xHorizontal = UIView()
                    xHorizontal.backgroundColor = UIColor(white: 1, alpha: 0.3)
                    xHorizontal.translatesAutoresizingMaskIntoConstraints = false
                    xPlus.addSubview(xHorizontal)
                    
                    xHorizontal.widthAnchor.constraint(equalToConstant: 16).isActive = true
                    xHorizontal.heightAnchor.constraint(equalToConstant: 1).isActive = true
                    xHorizontal.centerXAnchor.constraint(equalTo: xPlus.centerXAnchor).isActive = true
                    xHorizontal.centerYAnchor.constraint(equalTo: xPlus.centerYAnchor).isActive = true
                    self.listPlusView.append(xPlus)
                }
                
            }
            
        } else {
            collectionView.dragInteractionEnabled = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding = CGFloat(itemPerRow + 1) * 16
        let availabelWith = collectionView.frame.width - padding
        let size = availabelWith / CGFloat(itemPerRow)
        
        return CGSize(width: size, height: 77)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insetSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt sectionff: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = ListIcon[indexPath.row]
        tabBarCallback!(TabbarHomeVC.VNAHOMETABBARACTION(rawValue: data.action) ?? .VNATABBAR_HOME)
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let object = ListIcon.remove(at: sourceIndexPath.item)
        self.ListIcon.insert(object, at: destinationIndexPath.item)

    }
    
}

extension TabbarHomeVC: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        if indexPath.row != 0 {
//
//            let item =  ListIcon[indexPath.row].title
//            let itemProvider = NSItemProvider(object: item as NSString)
//            let dragItem = UIDragItem(itemProvider: itemProvider)
//
//            dragItem.localObject = item
//            dragItem.previewProvider = { () -> UIDragPreview? in
//
//                let view = UIView()
//                view.frame = CGRect(x: 0, y: 0, width: 77, height: 77)
//                view.layer.cornerRadius = 24
//                view.backgroundColor = .gray
//
//
//                let imageView = UIImageView(image: UIImage(named: "\(self.ListIcon[indexPath.row].iconNotCircle)"))
//                imageView.frame = CGRect(origin: .zero, size: CGSize(width: 48, height: 48))
//                imageView.layer.cornerRadius = imageView.frame.height/2
//                imageView.backgroundColor = .clear
//                imageView.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(imageView)
//                imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//                imageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
//                imageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
//
//
//
//                let title = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 14)))
//                title.font = .systemFont(ofSize: 11, weight: .regular)
//                title.textColor = .white
//                title.textAlignment = .center
//                title.text = "\(self.ListIcon[indexPath.row].title)"
//                title.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(title)
//
//                title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
//                title.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
//                title.heightAnchor.constraint(equalToConstant: 14).isActive = true
//                title.widthAnchor.constraint(equalToConstant: imageView.frame.width).isActive = true
//
//                return UIDragPreview(view: imageView)
//
//            }
//
//            return [dragItem]
//        } else {
//            return [UIDragItem]()
//        }
        return [UIDragItem]()

    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        
        let cell = collectionView.cellForItem(at: indexPath) as! iconCell
        let parameters = UIDragPreviewParameters()
        let poss = CGRect(origin: CGPoint(x: cell.icon.frame.origin.x, y: 0), size: CGSize(width: 48, height: 48))
        parameters.visiblePath = UIBezierPath(roundedRect: poss,
                                              cornerRadius: 24)
        parameters.backgroundColor = .clear
        return parameters
    }
    
    func collectionView(_ collectionView: UICollectionView, dropPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let cell = collectionView.cellForItem(at: indexPath) as! iconCell
        cell.stopAnimate()
        let parameters = UIDragPreviewParameters()
        let poss = CGRect(origin: CGPoint(x: cell.icon.frame.origin.x, y: 0), size: CGSize(width: 48, height: 48))
        parameters.visiblePath = UIBezierPath(roundedRect: poss,
                                              cornerRadius: 24)
        parameters.backgroundColor = .clear
        return parameters

    }
    
}

extension TabbarHomeVC: UICollectionViewDropDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if collectionView.hasActiveDrop {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        var destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: row - 1, section: 0)
        }
        
        collectionView.cellForItem(at: destinationIndexPath)
        if coordinator.proposal.operation == .move {
            isLongPress = false
            collectionView.reloadData()
            reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        }
        
    }
    
    fileprivate func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        
        if let item = coordinator.items.first,
           let sourceIndexPath = item.sourceIndexPath {
            collectionView.performBatchUpdates {
                
                if destinationIndexPath.row != 0 {
                    let object = ListIcon.remove(at: sourceIndexPath.item)
                    self.ListIcon.insert(object, at: destinationIndexPath.item)
                    
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                }
            }
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
}
