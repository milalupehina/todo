//
//  MainVC.swift
//  hiDementia
//
//  Created by xcode on 27.11.2021.
//


import UIKit

final class PillListVC: TableViewController<PillListItem, PillListCell> {
    //MARK: protocols
    private let interactor: PillListBusinessLogic
    private let router: PillListRoutingLogic
    
    // MARK: - UI Components
    private lazy var activityIndicator: UIActivityIndicatorView = {
         let view = UIActivityIndicatorView(style: .large)
         return view
     }()
    
    private lazy var flyButton: UIButton = {
         let button = UIButton(type: .custom)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setImage(UIImage(systemName: "plus"), for: .normal)
         button.backgroundColor = .systemBlue
         button.clipsToBounds = true
         button.layer.cornerRadius = 20
         button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
         return button
     }()

    // MARK: - Lifecycle
     init(
         _ interactor: PillListBusinessLogic,
         router: PillListRoutingLogic
     ) {
         self.interactor = interactor
         self.router = router
         super.init([]) { cell, item in
              cell.model = item
         } //didTap: <#(PillListCell) -> PillListCell#>
     }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
         super.viewDidLoad()

         interactor.fetchItems(.init(nil, .all))
         setupTableView()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.rightBarButtonItems = setupNavButtons()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Pill List Items"
//        if let window = UIWindow.key {
//            window.addSubview(flyButton)
//            setupFlyButton()
//        }
    }

    @objc
    private func refreshData() {
        interactor.fetchItems(.init(nil, .all))
    }
    
    @objc
    private func goToSettings() {
        router.routeToSettings()
    }
    
    @objc
    private func plusButtonTapped() {
        router.routeToAddItem { [weak self] in
             self?.interactor.fetchItems(.init(nil, .all))
         }
     }
    
    private func setupNavButtons() -> [UIBarButtonItem] {
         let plusButton = UIBarButtonItem(
             barButtonSystemItem: .add,
             target: self,
             action: #selector(plusButtonTapped))
         let settings = UIBarButtonItem(
             image: UIImage(systemName: "gear"),
             style: .plain,
             target: self,
             action: #selector(goToSettings)
         )
         return [settings, plusButton]
     }
}
    

// MARK: - Display Logic

 extension PillListVC: PillListDisplayLogic {
     func displayLoad(_ viewModel: PillListModels.Load.ViewModel) {
           viewModel.show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
     }
     
     func displayUpdateItem(_ viewModel: PillListModels.UpdateItems.ViewModel) {
         
     }

     func displayCells(_ viewModel: PillListModels.FetchItems.ViewModel) {
         tableView.refreshControl?.endRefreshing()
         items = viewModel.items
         tableView.reloadData()
     }

     func displayError(_ viewModel: PillListModels.Error.ViewModel) {
//         alert(
//              title: "Oups ERROR",
//              desc: viewModel.title
//          )
     }
 }

 // MARK: - UITableView Delegate&DataSource
extension PillListVC {
     override func numberOfSections(in tableView: UITableView) -> Int {
         1
     }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            true
        }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if (editingStyle == .delete) {
             interactor.fetchItems(.init(items[indexPath.row], .delete))
             items.remove(at: indexPath.row)
             tableView.beginUpdates()
             tableView.deleteRows(at: [indexPath], with: .middle)
             tableView.endUpdates()
             
         }
    }
}

 // MARK: - Setup UI components

 private extension PillListVC {
     func setupTableView() {
         view.addSubview(activityIndicator)
         activityIndicator.center = view.center
         tableView.backgroundColor = .systemBackground
         NSLayoutConstraint.activate([
             tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
             tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
             tableView.topAnchor.constraint(equalTo: view.topAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
     }

 }

 extension UIWindow {
     static var key: UIWindow? {
         if #available(iOS 13, *) {
             return UIApplication.shared.windows.first { $0.isKeyWindow }//'windows' was deprecated in iOS 15.0: Use UIWindowScene.windows on a relevant window scene instead
         } else {
             return UIApplication.shared.keyWindow
         }
     }
 }



//    private lazy var tableView: UITableView = {
//             let table = UITableView(frame: .zero, style: .plain)
//             table.register(.self, forCellReuseIdentifier: PillListCell.id)
//             let refreshControl = UIRefreshControl()
//             refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
//             table.refreshControl = refreshControl
//             table.translatesAutoresizingMaskIntoConstraints = false
//             return table
//    }()

//    private let grandFatherTakePillsImage: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(named: "Ded")
//        view.center = view.center
//        return view
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        view.addSubview(grandFatherTakePillsImage)
//        grandFatherTakePillsImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 150, height: 100)
//        grandFatherTakePillsImage.center = view.center
//    }


