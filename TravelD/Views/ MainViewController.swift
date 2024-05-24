//
//  ViewController.swift
//  TravelAI
//
//  Created by Арайлым Сермагамбет on 07.04.2024.
import UIKit
import SnapKit

class MainViewController: UIViewController {
    let welcomeLabel = UILabel()

    private let sliderData: [MainItem] = [
        MainItem(color: .brown, title: "Кольсай", text: "За неделю Кольсай посетило 10 000 туристов." , image: .kolsai),
        MainItem(color: .orange, title: "Шарын", text: "За неделю Кольсай посетило ү 000 туристов." , image: .charyn),
        MainItem(color: .gray, title: "Японская дорога", text: "За неделю Кольсай посетило ү 000 туристов.", image: .japaneseКoad)
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 354, height: 320)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal // Направление прокрутки горизонтальное
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Топ 3 мест этой недели"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViews()
        setupConstraints()
//        displayWelcomeMessage()
        
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }

            if let user = user {
                self.welcomeLabel.text = "Салем, \(user.username)"
                self.welcomeLabel.numberOfLines = 0 // Разрешаем перенос текста на несколько строк, если нужно
                self.welcomeLabel.sizeToFit() // Обновляем размер метки, чтобы текст оказался в верхней части
            }
        }

    }
    
    private func setupViews() {
        view.backgroundColor = .black
        welcomeLabel.font = UIFont.systemFont(ofSize: 24)
        welcomeLabel.textAlignment = .center
        view.addSubview(welcomeLabel)
    }
    
    private func setupConstraints() {
        // Используем SnapKit для установки ограничений
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-30)  // Отступ сверху
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)  // Отступ слева
        }
    }

//    private func displayWelcomeMessage() {
//        // Извлекаем логин пользователя из `UserDefaults`
//        let currentUser = UserDefaults.standard.string(forKey: "user.username") ?? "Guest"
//        welcomeLabel.text = "Welcome, \(currentUser)!"
//    }
    
    private func setupUI() {
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(20)
            make.height.equalTo(320)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainItemCell.self, forCellWithReuseIdentifier: "cell")
        

        // Add buttons
        let buttonSize = CGSize(width: 50, height: 50)
        let button1 = createButton(with: .ssl, action: #selector(button1Tapped))
        let button2 = createButton(with: .button2, action: #selector(button2Tapped))
        let button3 = createButton(with: .button3, action: #selector(button3Tapped))
        let button4 = createButton(with: .button4, action: #selector(button4Tapped))
        
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        
        button1.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(65)
            make.size.equalTo(buttonSize)
        }
        
        button2.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(40)
            make.trailing.equalToSuperview().offset(-65)
            make.size.equalTo(buttonSize)
        }
        
        button3.snp.makeConstraints { make in
            make.top.equalTo(button1.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(65)
            make.size.equalTo(buttonSize)
        }
        
        button4.snp.makeConstraints { make in
            make.top.equalTo(button2.snp.bottom).offset(40)
            make.trailing.equalToSuperview().offset(-65)
            make.size.equalTo(buttonSize)
        }
    }
    
    @objc private func button1Tapped() {
           let newViewController = NewViewController() // Замените NewViewController на ваш класс контроллера
           
           // Открытие нового контроллера с помощью push навигации
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc private func button2Tapped() {
        // Создание нового экземпляра контроллера
        let newViewController = NewTwoViewController() // Замените NewViewController на ваш класс контроллера
        
        // Открытие нового контроллера с помощью push навигации
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc private func button3Tapped() {
        let newViewController = NewThreeViewController() // Замените NewViewController на ваш класс контроллера
        
        // Открытие нового контроллера с помощью push навигации
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc private func button4Tapped() {
        let newViewController = NewFourViewController() // Замените NewViewController на ваш класс контроллера
        
        // Открытие нового контроллера с помощью push навигации
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    private func createButton(with image: UIImage?, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(red: 0.9176, green: 0.9019, blue: 0.7922, alpha: 1.0)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainItemCell
        let item = sliderData[indexPath.item]
        cell.configure(with: item)
        return cell
    }
}

struct MainItem {
    var color: UIColor
    var title: String
    var text: String
    var image: UIImage
}

class MainItemCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let textView = UITextView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Add image view
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        // Add title label
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        // Add text view
        contentView.addSubview(textView)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configure(with item: MainItem) {
        imageView.image = item.image
        titleLabel.text = item.title
        textView.text = item.text
    }
}

class NewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSafetyLabel() // Добавляем метод, чтобы добавить метку
    }
    
    private func addSafetyLabel() {
        let safetyLabel = UILabel()
        safetyLabel.numberOfLines = 0
        safetyLabel.text = """
        
        Кемпинг - это отличный способ провести время на природе, но безопасность всегда должна быть приоритетом. Вот некоторые меры безопасности, которые важно соблюдать во время кемпинга:
        
        - Выбор безопасного места для палатки
        - Контроль огня
        - Безопасное использование оборудования
        - Безопасное хранение пищи
        - Осмотр природы
        - Сообщение кому-то о своих планах
        - Первая помощь
        - Одежда и экипировка
        - Безопасный доступ к воде
        - Планирование и подготовка
        
        Соблюдение этих мер безопасности поможет вам насладиться кемпингом, минимизируя риски и обеспечивая приятный опыт на природе.
        """
        safetyLabel.textColor = .black
        safetyLabel.font = UIFont.systemFont(ofSize: 16)
        safetyLabel.textAlignment = .left
        
        view.addSubview(safetyLabel)
        safetyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            safetyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -150),
            safetyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            safetyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            safetyLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}


class NewTwoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Қажетті жабдықтар" // Set the title of the view controller
        navigationController?.navigationBar.prefersLargeTitles = true // Set large title
        
        // Change the font size of the large title
        if let font = UIFont(name: "Arial-BoldMT", size: 24
        ) {
            navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.black // Optionally, change the color as well
            ]
        }
        
        addScrollView() // Call to addScrollView instead of addBagLabel
    }

    
    private func addScrollView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let bagLabel = UILabel()
        bagLabel.numberOfLines = 0
        bagLabel.text = """
        Кэмпингта табиғатта жайлы және қауіпсіз уақыт өткізу үшін қажет нәрсенің бәрі болуы маңызды. Мұнда әдетте өзіңізбен бірге алуға ұсынылатын негізгі нәрселердің тізімі берілген::

        - Шатыр: сізбен бірге болатын адамдар саны үшін дұрыс өлшемді шатырды таңдаңыз.
        
        - Ұйықтайтын сөмке мен төсеніш: бұл суық пен ылғалдан қорғайтын шатырда жайлы ұйықтауға көмектеседі.
        
        - Жарықтандыру: фонарь немесе бас шам қараңғы уақытта пайдалы.
        
        - Карта және компас: әсіресе егер сіз соқпақтардан тыс маршруттармен жүргіңіз келсе.
        
        - Киім: ауа-райын ескеріңіз. Температураның өзгеруіне дайын болу үшін қабатты киімді алыңыз.
        
        - Аяқ киім: ыңғайлы және жерде жүруге ыңғайлы етік немесе кроссовка.
        
        - Тамақ пен сусындар: барлық уақытта жеткілікті мөлшерде тамақ алыңыз, сонымен қатар су немесе су көздерінен тазартқыш алыңыз.
        
        - Ас үй ыдыстары: кішкене газ оттығы, Кастрюль, Ас құралдары және ашқыш болуы мүмкін.
        
        - Алғашқы көмек: патч, антисептик, таңғыштар және т. б. бар алғашқы көмек жинағы.
        
        - Қосалқы батареялар немесе портативті зарядтағыш: шамды, телефонды және басқа құрылғыларды зарядтауға арналған.

        Бұл сіздің нақты қажеттіліктеріңізге және жоспарланған әрекеттеріңізге байланысты толықтырылуы мүмкін негізгі тізім.
        """
        bagLabel.textColor = .black
        bagLabel.font = UIFont.systemFont(ofSize: 16)
        bagLabel.textAlignment = .left

        contentView.addSubview(bagLabel)
        bagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bagLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            bagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}





class NewThreeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView) // Добавляем scrollView в иерархию представлений
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView) // Добавляем contentView в scrollView
        
        // Создание UIImageView для первого изображения
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 200))
        imageView1.contentMode = .scaleAspectFit
        imageView1.image = .bug
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView1)
        
        // Создание UILabel
        let label1 = UILabel()
        label1.textAlignment = .left
        label1.numberOfLines = 0
        label1.text = """
        Рюкзак жеңіл, ыңғайлы, кең болуы керек. Ең ыңғайлы туристік рюкзактар-анатомиялық. Кәдімгі рюкзакты пайдаланған кезде оның барлық ауырлығы, жүктеме тасымалдаушының иығына түседі, ал кең белдеуі бар анатомиялық рюкзакты қолданған кезде жүктеменің бір бөлігі төменгі арқаға бөлініп, иықтағы жүктемені азайтады.

       Рюкзактарды сауатты төсеу-маңызды және қажетті дағды. Рюкзак оны баспай, арқасына сүйенуі керек. Рюкзактың төменгі бөлігі төменгі арқа пішініне сәйкес келуі және оған тығыз орналасуы керек. Рюкзактың белдіктері ыңғайлы болатындай етіп реттелуі керек. Төсеу кезіндегі негізгі ереже: ауыр - төмен, жұмсақ - артқа, көлемді - Жоғары, қажетті заттар - қалтаға. Рюкзакты төсеу рюкзактың артқы жағындағы тұрақты тепе-теңдікке кепілдік беруі керек, сондықтан оның төменгі бұрыштарын әсіресе тығыз толтыру қажет.
"""
        label1.textColor = .black
        label1.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label1)
        
       
        
        
        // Активация констрейнтов
        NSLayoutConstraint.activate([
            // Констрейнты для scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Констрейнты для contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Констрейнты для imageView1
            imageView1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            imageView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView1.heightAnchor.constraint(equalToConstant: 200),
            
            // Констрейнты для label1
            label1.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 20),
            label1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}





class NewFourViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView) // Добавляем scrollView в иерархию представлений
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView) // Добавляем contentView в scrollView
        
        // Создание UIImageView для первого изображения
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 200))
        imageView1.contentMode = .scaleAspectFit
        imageView1.image = UIImage(named: "cump1")
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView1)
        
        // Создание UILabel
        let label1 = UILabel()
        label1.textAlignment = .left
        label1.numberOfLines = 0
        label1.text = """
        1. Ішкі шатырды ілмектермен түзетіп, жайыңыз. Доғаларды жинаңыз. Олар бір-біріне ойықтармен салынған байланысты элементтерден тұрады.
        """
        label1.textColor = .black
        label1.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label1)
        
        // Создание UIImageView для второго изображения
        let imageView2 = UIImageView()
        imageView2.contentMode = .scaleAspectFit
        imageView2.image = UIImage(named: "cump2")
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView2)
        
        let label2 = UILabel()
        label2.textAlignment = .left
        label2.numberOfLines = 0
        label2.text = """
        2. Әр доғаны құрастырғаннан кейін, доғалардың ұштарын ішкі шатырдың бұрыштарындағы арнайы саңылауларға-көзілдіріктерге салу арқылы оларды көлденеңінен бекітіңіз.
        """
        label2.textColor = .black
        label2.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label2)
        
        let imageView3 = UIImageView()
        imageView3.contentMode = .scaleAspectFit
        imageView3.image = .cump3
        imageView3.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView3)
        
        let label3 = UILabel()
        label3.textAlignment = .left
        label3.numberOfLines = 0
        label3.text = """
        3. Ілгектердің көмегімен ішкі шатырды доғаларға бекітіңіз. Содан кейін жоғарғы жағына қысқа доғаны орнатыңыз және белдіктердің керілуін реттеңіз. Сыртқы шатырдың ішкі шатырға тиіп кетпеуі маңызды.
        """
        label3.textColor = .black
        label3.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label3)
        
        let imageView4 = UIImageView()
        imageView4.contentMode = .scaleAspectFit
        imageView4.image = .cump4
        imageView4.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView4)
        
        let label4 = UILabel()
        label4.textAlignment = .left
        label4.numberOfLines = 0
        label4.text = """
        4. Сыртқы шатырды лақтырыңыз, үшінші доғаны оның ілмектеріне сатыңыз және шатырды ішкі жағынан Velcro белдіктерімен бекітіңіз.
        """
        label4.textColor = .black
        label4.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label4)
        
        let imageView5 = UIImageView()
        imageView5.contentMode = .scaleAspectFit
        imageView5.image = .cump5
        imageView5.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView5)
        
        let label5 = UILabel()
        label5.textAlignment = .left
        label5.numberOfLines = 0
        label5.text = """
        5. Шатырдың түбін созыңыз, ілмектерді ілмектерге салыңыз және шатырды жерге бекітіңіз. Содан кейін қалған қазықтармен дауыл сызықтарын бекітіңіз. Түбін ұстайтын қазықтарды 40-45° бұрышпен, ал тартқыштарды 20-30°бұрышпен орналастырыңыз.
        """
        label5.textColor = .black
        label5.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label5)
        
        
        
        // Активация констрейнтов
        NSLayoutConstraint.activate([
            // Констрейнты для scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Констрейнты для contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Констрейнты для imageView1
            imageView1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            imageView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView1.heightAnchor.constraint(equalToConstant: 200),

            // Констрейнты для label1
            label1.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 20),
            label1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            // Констрейнты для imageView2
            imageView2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            imageView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView2.heightAnchor.constraint(equalToConstant: 200),

            // Констрейнты для label2
            label2.topAnchor.constraint(equalTo: imageView2.bottomAnchor, constant: 20),
            label2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Констрейнты для imageView2
            imageView3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
            imageView3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView3.heightAnchor.constraint(equalToConstant: 200),

            // Констрейнты для label2
            label3.topAnchor.constraint(equalTo: imageView3.bottomAnchor, constant: 20),
            label3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            imageView4.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 20),
            imageView4.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView4.heightAnchor.constraint(equalToConstant: 200),

            // Констрейнты для label2
            label4.topAnchor.constraint(equalTo: imageView4.bottomAnchor, constant: 20),
            label4.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            imageView5.topAnchor.constraint(equalTo: label4.bottomAnchor, constant: 20),
            imageView5.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView5.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView5.heightAnchor.constraint(equalToConstant: 200),

            // Констрейнты для label2
            label5.topAnchor.constraint(equalTo: imageView5.bottomAnchor, constant: 20),
            label5.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label5.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label5.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
