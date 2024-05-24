//
//  SettingsViewController.swift
//  TravelAI
//
//  Created by Арайлым Сермагамбет on 07.04.2024.
//
import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    let welcomeLabel = UILabel()
    let backgroundView = UIView()
    var imageView = UIImageView()
    let tableView = UITableView()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupUI()
        setupViews()
        setupConstraints()
        displayWelcomeMessage()
        fetchAndDisplayUserInfo()
    }
    
    func setupUI() {
        backgroundView.backgroundColor = .red
        view.addSubview(backgroundView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // Регистрация идентификатора ячейки
        view.addSubview(tableView)
    }

    private func setupViews() {
        view.backgroundColor = .black
        
        imageView = UIImageView(image: .ava1)
        imageView.contentMode = .scaleAspectFit // Масштабируем изображение под размеры
        view.addSubview(imageView)
        
        welcomeLabel.font = UIFont.systemFont(ofSize: 22)
        welcomeLabel.textAlignment = .center
        view.addSubview(welcomeLabel)
    }

    
    private func setupConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(75) // Отступ от левого края на 20 пикселей

        }
       
            backgroundView.snp.makeConstraints { make in
                make.center.equalTo(welcomeLabel) // Центрируем по центру welcomeLabel
                make.leading.equalTo(welcomeLabel.snp.leading).offset(-200) // Отступ слева от welcomeLabel
                make.trailing.equalTo(welcomeLabel.snp.trailing).offset(250) // Отступ справа от welcomeLabel
                make.height.equalTo(welcomeLabel.snp.height).offset(40) // Дополнительная высота по вертикали
        }
        
        imageView.snp.makeConstraints { make in
                make.trailing.equalTo(welcomeLabel.snp.leading).offset(-20) // Отступ от правого края welcomeLabel
                make.centerY.equalTo(welcomeLabel) // Выравниваем по вертикали с welcomeLabel
                make.width.height.equalTo(50) // Устанавливаем размеры изображения
            }
        
        tableView.snp.makeConstraints { make in
                make.top.equalTo(backgroundView.snp.bottom).offset(20) // Связываем с нижней частью backgroundView
                make.leading.trailing.bottom.equalToSuperview()
            }
    }
    
    private func displayWelcomeMessage() {
        // Остальной код остается без изменений
        let currentUser = UserDefaults.standard.string(forKey: "currentLoggedInUser") ?? "Guest"
        welcomeLabel.text = "\(currentUser)!"
    }
    
    func fetchAndDisplayUserInfo() {
        // Ваша логика для получения и отображения информации о пользователе
    }
}
// Расширение для реализации методов UITableViewDataSource и UITableViewDelegate
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Количество секций
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // Количество строк в секции
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        // Задаем текст для ячейки в зависимости от индекса
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Пайдалы ақпараттар"
        case 1:
            cell.textLabel?.text = "Техникалық ақпарат"
        case 2:
            cell.textLabel?.text = "Совет"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Определяем, какой раздел был выбран
        switch indexPath.row {
        case 0:
            let myPlaceViewController = MyPlaceViewController()
                   // Переходим к новому контроллеру информации
                   navigationController?.pushViewController(myPlaceViewController, animated: true)
            break
        case 1:
            // Открываем новый раздел информации для "Полезная информация"
            // Ваш код для открытия нового контроллера или отображения информации
            break
        case 2:
            // Открываем новый раздел информации для "Совет"
            // Ваш код для открытия нового контроллера или отображения информации
            break
        default:
            break
        }
    }
}
 
class MyPlaceViewController: UIViewController {
    // MARK: - Properties
  //
  //    private let nameLabel: UILabel = {
  //        let label = UILabel()
  //        label.translatesAutoresizingMaskIntoConstraints = false
  //        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
  //        label.textAlignment = .center
  //        return label
  //    }()
  //
  //    private let emailLabel: UILabel = {
  //        let label = UILabel()
  //        label.translatesAutoresizingMaskIntoConstraints = false
  //        label.font = UIFont.systemFont(ofSize: 16)
  //        label.textAlignment = .center
  //        return label
  //    }()
  //
  //    private let logoutButton: UIButton = {
  //        let button = UIButton(type: .system)
  //        button.translatesAutoresizingMaskIntoConstraints = false
  //        button.setTitle("Logout", for: .normal)
  //        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
  //        button.addTarget(SettingsViewController.self, action: #selector(logoutButtonTapped), for: .touchUpInside)
  //        return button
  //    }()
  //
  //    // MARK: - Lifecycle
  //
  //    override func viewDidLoad() {
  //        super.viewDidLoad()
  //        view.backgroundColor = .white
  //
  //        setupViews()
  //        displayWelcomeMessage()
  //    }
  //
  //    // MARK: - Setup
  //
  //    private func setupViews() {
  //        view.addSubview(nameLabel)
  //        view.addSubview(emailLabel)
  //        view.addSubview(logoutButton)
  //
  //        NSLayoutConstraint.activate([
  //            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
  //            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
  //
  //            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
  //            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
  //
  //            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
  //            logoutButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 50)
  //        ])
  //    }
  //
  //    // MARK: - Actions
  //    @objc private func logoutButtonTapped() {
  //        // Очищаем данные о текущем пользователе из UserDefaults
  //        UserDefaults.standard.removeObject(forKey: "currentLoggedInUser")
  //        UserDefaults.standard.removeObject(forKey: "currentLoggedInEmail")
  //
  //        // Перенаправляем пользователя на экран входа
  //        // Зависит от вашей архитектуры навигации.
  //        // Например, если у вас UINavigationController, вы можете использовать метод popToRootViewController:
  //        if let navigationController = navigationController {
  //            navigationController.popToRootViewController(animated: true)
  //        } else {
  //            // Если вы не используете UINavigationController, можете использовать другие методы, например, презентацию экрана входа модально.
  //        }
  //    }
  //
  //    // MARK: - Helpers
  //    private func displayWelcomeMessage() {
  //        // Извлекаем логин пользователя из UserDefaults
  //        let currentUser = UserDefaults.standard.string(forKey: "currentLoggedInUser") ?? "Guest"
  //        nameLabel.text = "Welcome, \(currentUser)!"
  //    }
  //
  ////    private func displayUserInfo() {
  ////        // Извлекаем информацию о пользователе из хранилища данных
  ////        let currentUser = UserDefaults.standard.string(forKey: "currentLoggedInUser") ?? "Guest"
  ////        let currentEmail = UserDefaults.standard.string(forKey: "currentLoggedInEmail") ?? ""
  ////
  ////        // Отображаем информацию о пользователе
  ////        nameLabel.text = currentUser
  ////        emailLabel.text = currentEmail
  //
          
          
          //       }
              var viewModel = SettingsViewModel()
          
              private lazy var tableView: UITableView = {
                  let tableView = UITableView(frame: view.bounds, style: .grouped)
                  tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                  tableView.delegate = self
                  tableView.dataSource = self
                  tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
                  return tableView
              }()
          
              override func viewDidLoad() {
                  super.viewDidLoad()
          
                  title = "Қосымша"
                  setupViews()
                  setupConstraints()
              }
          
              private func setupViews() {
                  view.addSubview(tableView)
              }
          
              private func setupConstraints() {
                  tableView.snp.makeConstraints { make in
                      make.edges.equalToSuperview()
                  }
              }
          }
          
          
          extension MyPlaceViewController: UITableViewDelegate, UITableViewDataSource {
              func numberOfSections(in tableView: UITableView) -> Int {
                  return viewModel.settingsItems.count
              }
          
              func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                  return viewModel.settingsItems[section].count
              }
          
              func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
          
                  let item = viewModel.settingsItems[indexPath.section][indexPath.row]
                  cell.textLabel?.text = item.title
                  cell.detailTextLabel?.text = item.value
          
                  return cell
              }
          
              func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                  if section == 0 {
                      return "Білуініз керек"
                  } else {
                      return "Пайдалы ақпарат"
                  }
              }
}
