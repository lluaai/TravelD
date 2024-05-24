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
        backgroundView.backgroundColor = UIColor(red: 0x4E/255.0, green: 0x7A/255.0, blue: 0xB5/255.0, alpha: 1.0)
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
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }

            if let user = user {
                self.welcomeLabel.text = "\(user.username)"
                self.welcomeLabel.numberOfLines = 0 // Разрешаем перенос текста на несколько строк, если нужно
                self.welcomeLabel.sizeToFit() // Обновляем размер метки, чтобы текст оказался в верхней части
            }
        }
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
            cell.textLabel?.text = "Пайдалы ақпарат"
        case 1:
            cell.textLabel?.text = "Таңдаулылар"
        case 2:
            cell.textLabel?.text = "Шығу"
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
           
            break
        case 2:
            AuthService.shared.signOut { [weak self] error in
                       guard let self = self else { return }
                       if let error = error {
                           AlertManager.showLogoutError(on: self, with: error)
                           return
                       }
                       
                       if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                           sceneDelegate.checkAuthentication()
                       }
                   }
            
            break
        default:
            break
        }
    }
}
 
class MyPlaceViewController: UIViewController {

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
          
                  title = "Пайдалы ақпарат"
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
