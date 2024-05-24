//
//  PlaceInfoView.swift
//  TravelGuige
//
//  Created by Арайлым Сермагамбет on 21.05.2024.
import UIKit
import MapKit
import MessageUI

class PlaceDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MFMessageComposeViewControllerDelegate {
    
    var place: Place?
    var scrollView: UIScrollView!
    var contentView: UIView!
    var collectionView: UICollectionView!
    var informationLabel: UILabel!
    var reviewTextView: UITextView!
    var reviewsTableView: UITableView!
    var startCoordinate: CLLocationCoordinate2D?
    var destinationCoordinate: CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        if let place = place {
            let titleLabel = UILabel()
            titleLabel.text = place.title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
            titleLabel.textAlignment = .center
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
            
            title = ""
            displayPlaceInfo(place)
        }
    }
    
    func setupUI() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width, height: 200)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        contentView.addSubview(collectionView)
        
        informationLabel = UILabel()
        informationLabel.numberOfLines = 0
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(informationLabel)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            
            informationLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            informationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            informationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        if let place = place {
            if place.whatsappNumber != nil {
                let whatsappButton = UIButton(type: .system)
                if let whatsappIcon = UIImage(named: "whatsapp") {
                    whatsappButton.setImage(whatsappIcon.withRenderingMode(.alwaysOriginal), for: .normal)
                }
                whatsappButton.addTarget(self, action: #selector(openWhatsApp), for: .touchUpInside)
                whatsappButton.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(whatsappButton)
                
                NSLayoutConstraint.activate([
                    whatsappButton.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20),
                    whatsappButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 110),
                    whatsappButton.widthAnchor.constraint(equalToConstant: 48),
                    whatsappButton.heightAnchor.constraint(equalToConstant: 48)
                ])
            }
            
            if place.instagramAccount != nil {
                let instagramButton = UIButton(type: .system)
                if let instagramIcon = UIImage(named: "instagram") {
                    instagramButton.setImage(instagramIcon.withRenderingMode(.alwaysOriginal), for: .normal)
                }
                instagramButton.addTarget(self, action: #selector(openInstagram), for: .touchUpInside)
                instagramButton.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(instagramButton)
                
                NSLayoutConstraint.activate([
                    instagramButton.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20),
                    instagramButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 180),
                    instagramButton.widthAnchor.constraint(equalToConstant: 48),
                    instagramButton.heightAnchor.constraint(equalToConstant: 48)
                ])
            }
            
            if place.contactNumber != nil {
                let contactButton = UIButton(type: .system)
                if let contactIcon = UIImage(named: "phone") {
                    contactButton.setImage(contactIcon.withRenderingMode(.alwaysOriginal), for: .normal)
                }
                contactButton.addTarget(self, action: #selector(showContactNumber), for: .touchUpInside)
                contactButton.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(contactButton)
                
                NSLayoutConstraint.activate([
                    contactButton.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20),
                    contactButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 250),
                    contactButton.widthAnchor.constraint(equalToConstant: 48),
                    contactButton.heightAnchor.constraint(equalToConstant: 48)
                ])
            }
        }
        
        // Adding "How to get there" label and buttons
        let howToGetThereLabel = UILabel()
        howToGetThereLabel.text = "Как добраться"
        howToGetThereLabel.font = UIFont.boldSystemFont(ofSize: 18)
        howToGetThereLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(howToGetThereLabel)
        
        NSLayoutConstraint.activate([
            howToGetThereLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 80),
            howToGetThereLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        let carButton = UIButton(type: .system)
        if let carIcon = UIImage(named: "car") {
            carButton.setImage(carIcon.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        carButton.tintColor = UIColor(red: 0.9176, green: 0.9019, blue: 0.7922, alpha: 1.0)
        carButton.addTarget(self, action: #selector(showCarDirections), for: .touchUpInside)
        carButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(carButton)
        
        let walButton = UIButton(type: .system)
        if let walIcon = UIImage(named: "bus") {
            walButton.setImage(walIcon.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        walButton.tintColor = UIColor(red: 0.9176, green: 0.9019, blue: 0.7922, alpha: 1.0)
        walButton.addTarget(self, action: #selector(showWalDirections), for: .touchUpInside)
        walButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(walButton)
        
        let busButton = UIButton(type: .system)
        if let busIcon = UIImage(named: "bus") {
            busButton.setImage(busIcon.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        busButton.tintColor = UIColor(red: 0.9176, green: 0.9019, blue: 0.7922, alpha: 1.0)
        busButton.addTarget(self, action: #selector(showBusDirections), for: .touchUpInside)
        busButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(busButton)
        
        NSLayoutConstraint.activate([
            carButton.topAnchor.constraint(equalTo: howToGetThereLabel.bottomAnchor, constant: 20),
            carButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            carButton.widthAnchor.constraint(equalToConstant: 48),
            carButton.heightAnchor.constraint(equalToConstant: 48),
            
            walButton.topAnchor.constraint(equalTo: howToGetThereLabel.bottomAnchor, constant: 20),
            walButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -170),
            walButton.widthAnchor.constraint(equalToConstant: 48),
            walButton.heightAnchor.constraint(equalToConstant: 48),
            
            busButton.topAnchor.constraint(equalTo: howToGetThereLabel.bottomAnchor, constant: 20),
            busButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            busButton.widthAnchor.constraint(equalToConstant: 48),
            busButton.heightAnchor.constraint(equalToConstant: 48),
            
            busButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func displayPlaceInfo(_ place: Place) {
        informationLabel.text = place.information
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return place?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        cell.backgroundView = UIImageView(image: place?.photos[indexPath.item])
        cell.backgroundView?.contentMode = .scaleAspectFit
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        
        switch result {
        case .cancelled:
            print("Message was cancelled")
        case .failed:
            print("Message failed to send")
        case .sent:
            print("Message was sent")
        @unknown default:
            fatalError("Unknown message compose result")
        }
    }
    
    @objc func openWhatsApp() {
        place?.openWhatsApp()
    }
    
    @objc func openInstagram() {
        place?.openInstagram()
    }
    
    @objc func showContactNumber() {
        guard let contactNumber = place?.contactNumber else {
            let alert = UIAlertController(title: "Номер жоқ", message: "Контакт номер қолжетімді емес ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let alert = UIAlertController(title: "Контактный номер", message: "Номер телефона: \(contactNumber)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Нөмерді сақтау", style: .default, handler: { _ in
            self.savePhoneNumber(contactNumber: contactNumber)
        }))
        alert.addAction(UIAlertAction(title: "Бас тарту", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func savePhoneNumber(contactNumber: Int) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = String(contactNumber)
        
        let alert = UIAlertController(title: "Номер телефона скопирован", message: "Теперь вы можете вставить номер в свои контакты.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func showCarDirections() {
        guard let carDirections = place?.carDirections else {
            let alert = UIAlertController(title: "Нет информации", message: "Информация по маршруту на машине недоступна.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "Маршрут на машине", message: carDirections, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func showWalDirections() {
        guard let walDirections = place?.walDirections else {
            let alert = UIAlertController(title: "Нет информации", message: "Информация по маршруту на автобусе недоступна.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "Маршрут на автобусе", message: walDirections, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func showBusDirections() {
        guard let busDirections = place?.busDirections else {
            let alert = UIAlertController(title: "Нет информации", message: "Информация по маршруту на автобусе недоступна.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "Маршрут на автобусе", message: busDirections, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
