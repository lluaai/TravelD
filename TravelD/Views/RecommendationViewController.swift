//
//  RecommendationViewController.swift
//  TravelAI
//
//  Created by Арайлым Сермагамбет on 07.04.2024.
//
import UIKit

class RecommendationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Открываем MapViewController при загрузке RecommendationViewController
        let mapViewController = MapViewController()
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}

//
//import UIKit
//import SnapKit
//
//class RecommendationViewController: UIViewController {
//    
//    var viewModel = RecommendationViewModel()
//
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: view.bounds, style: .grouped)
//        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
//        return tableView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        title = "План на месяц"
//        setupViews()
//        setupConstraints()
//        setupAddExpenseButton()
//        
//    }
//    
//    
//    private func setupViews() {
//        view.addSubview(tableView)
//    }
//    
//    private func setupConstraints() {
//        tableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//    private func setupAddExpenseButton() {
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addExpense))
//        navigationItem.rightBarButtonItem = addButton
//    }
//    
//    
//    @objc private func addExpense() {
//        let alertController = UIAlertController(title: "Планировать поездки", message: nil, preferredStyle: .alert)
//        
//        alertController.addTextField { textField in
//            textField.placeholder = "Название"
//        }
//        
//        alertController.addTextField { textField in
//            textField.placeholder = "Дата"
//            textField.keyboardType = .decimalPad
//        }
//        
//        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self, weak alertController] _ in
//            guard let fields = alertController?.textFields, let description = fields[0].text, let amountString = fields[1].text, let amount = Int(amountString) else {
//                return
//            }
//            self?.viewModel.addPurchase(description: description, amount: amount)
//            self?.tableView.reloadData()
//        }
//        
//        alertController.addAction(addAction)
//        alertController.addAction(UIAlertAction(title: "Назад", style: .cancel, handler: nil))
//        
//        present(alertController, animated: true)
//    }
//}
//
//extension RecommendationViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.purchase.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
//        let purchase = viewModel.purchase[indexPath.row]
//        cell.textLabel?.text = "\(purchase.description) - \(purchase.amount) апрель"
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Все планы"
//        } else {
//            return nil
//        }
//    }
//}
