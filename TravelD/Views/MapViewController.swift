//
//  MapViewController.swift
//  TravelAI
//
//  Created by Арайлым Сермагамбет on 11.05.2024.
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    var campingPlaceAnnotations = [PlaceAnnotation]()
    var hikingPlaceAnnotations = [PlaceAnnotation]()
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        
        addCampingAnnotations()
        addHikingAnnotations()
        
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        let segmentedControl = UISegmentedControl(items: ["All", "Camping", "Hiking"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(filterAnnotations(_:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
        let zoomInButton = UIButton(type: .system)
        zoomInButton.setTitle("+", for: .normal)
        zoomInButton.backgroundColor = .white
        zoomInButton.frame = CGRect(x: view.frame.width - 70, y: 370, width: 50, height: 50)
        zoomInButton.layer.cornerRadius = 25
        zoomInButton.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        view.addSubview(zoomInButton)
        
        let zoomOutButton = UIButton(type: .system)
        zoomOutButton.setTitle("-", for: .normal)
        zoomOutButton.backgroundColor = .white
        zoomOutButton.frame = CGRect(x: view.frame.width - 70, y: 430, width: 50, height: 50)
        zoomOutButton.layer.cornerRadius = 25
        zoomOutButton.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        view.addSubview(zoomOutButton)
        
        navigationItem.hidesBackButton = true
    }
    
    func addCampingAnnotations() {
        let place1 = Place(
            title: "Аса Үстірті",
            coordinate: CLLocationCoordinate2D(latitude: 43.22, longitude: 77.87),
            photos: [UIImage(named: "asa1")!, UIImage(named: "asa2")!, UIImage(named: "asa3")!],
            information: """
 Ассы биік таулы үстірті - Алматы
қаласынан 100 км қашықтықта орналасқан
таңғажайып табиғат мүйісі.

 Үстіртке, ең дұрысы, мамыр айының аяғы
маусымның басына қарай келу керек. Дәл
осы кезде таудағы алуан түрлі өсімдіктер
жайқала өсіп, түсті кілемге айналады.
""",
            whatsappNumber: 87053826358,
            instagramAccount: "https://www.instagram.com/visitalmatykz/",
            contactNumber: 87053826358,
            carDirections: "Үстіртке жету үшін Алматыдан Құлжа трактіне барып, Есік қаласына жету керек. Оны жүріп өтіп, Түрген кентіне жетіп, оңға қарай оңтүстік жаққа бұрылып, Түрген шатқалына қарай бет аламыз. Шатқалға жеткенде Іле-Алатау саябағына кіруге экологиялық алым төлеу қажет болады. Аса үстіртіндегі бағыт Бартоғай су қоймасынан Нарынкөл-Алматы тас жолына көшумен аяқталады. Жалпы, Алматы қаласынан межелі жерге дейінгі қашықтық - 90 км, уақыт бойынша бір сағаттан сәл астам уақытты алады.",
                    busDirections: nil,
            walDirections: nil
        )
        let annotation1 = PlaceAnnotation(place: place1)
        campingPlaceAnnotations.append(annotation1)
        mapView.addAnnotation(annotation1)
        
        let place2 = Place(
            title: "Жапон жолы",
            coordinate: CLLocationCoordinate2D(latitude: 43.09, longitude: 76.95),
            photos: [UIImage(named: "japan1")!, UIImage(named: "japan2")!, UIImage(named: "japan3")!],
            information: """
 Жаяу серуендеп, төңіректі еркін
серуендеуге үш сағат уақыт қажет
(қозғалыс бірқалыпты болғанда) болады.
Жодың теңіз деңгейінен биіктігі
-1900 метр.nЖолда сіз Көкшоқы шоқысы
(2305м), Қарғалы шыңы (3675м), Үлкен
Алматы шыңдарын (3681м) көресіз, ал
трассаның өзі Көкжайлау үстіртіне
және В. Терешкова асуына баруға
мүмкіндік береді.
""",
            whatsappNumber: nil,
            instagramAccount: nil,
            contactNumber: nil,
            carDirections: "Көкшоқы ауылына қарай бет аласыз",
            busDirections: "№28 автобус, Бұғы ескерткіші",
            walDirections: nil

        )
        
        let annotation2 = PlaceAnnotation(place: place2)
        campingPlaceAnnotations.append(annotation2)
        mapView.addAnnotation(annotation2)
        
        let place3 = Place(
            title: "Есік Көлі",
            coordinate: CLLocationCoordinate2D(latitude: 43.15, longitude: 77.29),
            photos: [UIImage(named: "issik")!, UIImage(named: "issik2")!],
            information: """
Теңіз деңгейінен 1700 м биіктікте
орналасқан Есік көлі. Геологтардың
бір теориясына сәйкес, 10 000 жылдан
астам уақыт бұрын болған көшкін
биіктігі шамамен 300 м болатын табиғи
бөгет құрып, өзен ағынын тоқтатып,
көл құрды.

Есік қаласының орталығынан көлге дейін
жақсы жолмен небәрі 40 минуттық жол бар:
жартасты беткейлердің арасында орналасқан
көлдің көгілдір суларының керемет көрінісін
жіберіп алмаңыз!
""",
            whatsappNumber: nil,
            instagramAccount: nil,
            contactNumber: nil,
            carDirections: "Алматы қаласынан көлікпен 54минтта жетессіз",
            busDirections: "Тікелей автобус жүрмейді",
            walDirections: nil

        )
        let annotation3 = PlaceAnnotation(place: place3)
        campingPlaceAnnotations.append(annotation3)
        mapView.addAnnotation(annotation3)
    
    let place4 = Place(
        title: "Айлы алаң",
        coordinate: CLLocationCoordinate2D(latitude: 43.06, longitude: 76.99),
        photos: [UIImage(named: "moonplane")!],
        information: """
Айлы алаң Іле Алатауының көрікті
жерлерінің бірі болып табылады.
Ол Чукур шатқалында, көл мен
Кумбельсу арасында орналасқан.
Осы жерден мұздық пен кеңес шыңына,
сондай-ақ Тұйықсу шатқалына дейін
баруға болады. Ай жер төбелер
мен биік ағаштармен қоршалған
биіктікте орналасқан. Аумақ 
жеткілікті үлкен және кең,
онда сіз шатырлы кемпингті тыныш
орналастыра аласыз.
""",
        whatsappNumber: nil,
        instagramAccount: nil,
        contactNumber: nil,
        carDirections: "Үлкен Алматы көлінедейін көлңкпен келе аласыз",
                busDirections: "Инструкции по прибытию на автобусе",
        walDirections: "Жолдан кейін солға, содан кейін оңға қарай жүресіз, онда сізді шатқалдың кең бөлігіне апаратын түсу мен бұлақ күтеді. Мұнда біз сізді құттықтаймыз-сіз ай алаңындасыз."

    )
    let annotation4 = PlaceAnnotation(place: place4)
    campingPlaceAnnotations.append(annotation4)
    mapView.addAnnotation(annotation4)
        
        let place5 = Place(
            title: "Терра алаңы",
            coordinate: CLLocationCoordinate2D(latitude: 43.04, longitude: 76.91),
            photos: [UIImage(named: "TerraGlade")!, UIImage(named: "terra1")!, UIImage(named: "terra2")!, UIImage(named: "terra3")!],
            information: """
    Өтпелі шатқалда орналасқан өте көркем жерлердің бірі. Алаңға апаратын жол танымал емес, бірақ өте қызықты және әдемі. Бұл маршрутта сіз шытырман оқиғасыз жасай алмайсыз. Жолда сіз көпірлер, өзен, төбелер мен үлкен тастарды кездестіресіз, оларды абайлап өту керек. Ал, ең бастысы-Үлкен Алматы шыңы мен ара сияқты жақын орналасқан шыңдардың таңғажайып керемет көріністері және алаңнан ашылатын қаланың сұлбасы.
    """,
            whatsappNumber: nil,
            instagramAccount: nil,
            contactNumber: nil,
            carDirections: "Инструкции по прибытию на машине",
                    busDirections: "Жол басталғанға дейін сізге №28 маршрутта Әл-Фараби — Навоидан соңғы аялдамаға дейін жету керек. Оған шыққаннан кейін сіздің алдыңызда жалғыз жол болады. Ол бойымен, өзен бойымен қозғалу керек.",
            walDirections: "жолдың ортасында — ыстық бұлақ пен қыздың көз жасы сарқырамасы-сізді ең қызықты жол күтіп тұр. Сарқырамадан жоғарыға апаратын жол көрінеді, ол қажет. Бағыт шатқалдың сол жағымен, өзеннің жанында жүреді, оған мүмкіндігінше жақын болу керек. Өзеннен өту керек, ол үшін сіздің алдыңызда екі құбырлы көпір болады. Өткеннен кейін сіз көтерілуді көресіз, ол сізді Терра клирингіне апарады."

        )
        let annotation5 = PlaceAnnotation(place: place5)
        campingPlaceAnnotations.append(annotation5)
        mapView.addAnnotation(annotation5)
}
    
    func addHikingAnnotations() {
        let place6 = Place(
            title: "Ботаникалық бақ",
            coordinate: CLLocationCoordinate2D(latitude: 43.22, longitude: 76.91),
            photos: [UIImage(named: "bak")!, UIImage(named: "bak2")!],
            information: "Ботаникалық бақ-өсімдіктер әлемін, оның ішінде сирек кездесетін және Құрып кету қаупі төнген өсімдік түрлерін қорғау, қорғау, молықтыру және пайдалану бойынша зерттеулер мен ғылыми әзірлемелер жүргізуге арналған, табиғатты қорғау және ғылыми ұйым мәртебесі бар ерекше қорғалатын табиғи аумақ.",
            whatsappNumber: 87089705866,
            instagramAccount: "https://www.instagram.com/botsadkz/",
            contactNumber: 87089705866,
            carDirections: nil,
            busDirections: """
            Автобус [18], [30], [32], [45], [70], [79], [124], [205]
            Троллейбус [7], [9], [11]
            """,
            walDirections: "Ботаникалық бақ жеткен соң ішін толқ аралай аласыз"

        )
        let annotation6 = PlaceAnnotation(place: place6)
        hikingPlaceAnnotations.append(annotation6)
        mapView.addAnnotation(annotation6)
        
        let place7 = Place(
            title: "Көктөбе",
            coordinate: CLLocationCoordinate2D(latitude: 43.24, longitude: 76.97),
            photos: [UIImage(named: "koktobe")!, UIImage(named: "koktobe1")!, UIImage(named: "koktobe2")!],
            information: "Көк-төбе - Алматының танымал көрікті жері және қала тұрғындарының сүйікті демалыс орындарының бірі. Атауы Жасыл төбе деп аударылатын шағын тау Алматының оңтүстік-шығыс шетінде орналасқан, ал оның аумағында аттракциондары бар шағын саябақ, ескерткіштер, бақылау алаңдары және Алматы телевышкасы орналасқан. Көк-төбеде аспалы жол бар, сонымен қатар ұзын ілмекті автожол бар. Көк төбенің биіктігі теңіз деңгейінен 1130 метр және Алматы қаласына қатысты 200 метр.",
            whatsappNumber: 87020004488,
            instagramAccount: "https://www.instagram.com/koktobe.park/",
            contactNumber: 87020004488,
            carDirections: "Көк Төбе тауына тек арқанмен ғана емес, айналмалы автожолмен — жеке көлікпен де жетуге болады",
            busDirections: """
            Автобус № [12], [57], [65], [66], [99], [120], [128].
            Әрі қарай арқанды жолмен бара аласыз
            """,
            walDirections: nil

        )
        let annotation7 = PlaceAnnotation(place: place7)
        hikingPlaceAnnotations.append(annotation7)
        mapView.addAnnotation(annotation7)
        
        let place8 = Place(
            title: "Теренкүр",
            coordinate: CLLocationCoordinate2D(latitude: 43.20, longitude: 76.97),
            photos: [UIImage(named: "bak")!, UIImage(named: "bak2")!],
            information: "Терренкур — 1974 жылы салынған және Тәттімбет көшесі мен Достық даңғылына параллель өтетін Алматыдағы Денсаулық жолы. Терренкур Алматының шығыс бөлігінде орналасқан және қала орталығынан тау бөктеріне қарай ағады. Терренкурдың ұзындығы-4,5 шақырым, оның ең биік нүктесі — 1058 метр, ал ең төменгі нүктесі-теңіз деңгейінен 876 метр.",
            whatsappNumber: 87089705866,
            instagramAccount: "https://www.instagram.com/botsadkz/",
            contactNumber: 87089705866,
            carDirections: nil,
            busDirections: """
            Терренкурдың жоғарғы бөлігі Керей-Жәнібек хандар, 310 мекен-жайында орналасқан. Сіз № [29], [29(р)], [12], [141] автобустармен жете аласыз. "Көпір" аялдамасында шығу керек (бағдар-Royal Tulip қонақ үйі)
            """,
            walDirections: "Жол Достық даңғылы, 104 мекенжайындағы Aрман кинотеатрынан бастау алады. Алдымен сіздің көзіңізге кәдімгі жағалау келеді, ол көтерілген сайын азаяды"

        )
        let annotation8 = PlaceAnnotation(place: place8)
        hikingPlaceAnnotations.append(annotation8)
        mapView.addAnnotation(annotation8)
        
        let place9 = Place(
            title: "Halyk Square",
            coordinate: CLLocationCoordinate2D(latitude: 43.22, longitude: 76.94),
            photos: [UIImage(named: "halyk")!, UIImage(named: "halyk 1")!],
            information: "Halyk Square-қоғамдық кеңістік, Алматы қаласының іскерлік бөлігінің қақ ортасында демалуға арналған жасыл арал, ол Әл-Фараби даңғылының бойында Halyk Bank ғимараты мен Almaty Theatre театрының арасында орналасқан. Halyk Square құру мақсаттарының бірі жақсы экологияны сақтау және ауа ағынын жақсарту болды. Скверде көптеген бұталар отырғызылды, өйткені бұталар жойылып бара жатқан қалалық фаунаны паналайды.",
            whatsappNumber: nil,
            instagramAccount: nil,
            contactNumber: nil,
            carDirections: "Егер сіз жеке көлікпен келуді жоспарласаңыз, Әл-Фараби даңғылынан кіріңіз.",
            busDirections: """
            Автобуспен, аллеяның жанында аялдама бар онда №62, 63, 86, 127 маршруттар тоқтайды
            """,
            walDirections: "Әл-Фараби даңғылынан кіріңіз."

        )
        let annotation9 = PlaceAnnotation(place: place9)
        hikingPlaceAnnotations.append(annotation9)
        mapView.addAnnotation(annotation9)
        
        let place10 = Place(
            title: "Медеу",
            coordinate: CLLocationCoordinate2D(latitude: 43.15, longitude: 77.05),
            photos: [UIImage(named: "medeo")!, UIImage(named: "medeo2")!],
            information: "Алматының басты брендтерінің бірі — Медеу спорт кешені қала шекарасында, 1691 метр биіктікте орналасқан. Іле Алатауы тауларының шыңдары, таза ауа, күн-мұнда барлық жастағы алматылықтар өз уақыттарын өткізгенді ұнатады.",
            whatsappNumber: 87082219709,
            instagramAccount: "https://www.instagram.com/medeu_official/",
            contactNumber: 87082219710,
            carDirections: "Cіз орналасқан қаланың ауданынан Достық даңғылына қарай жүріңіз. Әрі қарай, даңғыл бойымен тауларға қарай және одан әрі тауларға қарай жүріңіз.",
            busDirections: """
            автобус [12].
            """,
            walDirections: "Мұз айдынына көліктің кез келген түрімен жетіп, сол жерден Тұйық Су, Кимасаров шатқалына, Шымбұлақ курортына (Шымбұлақ), Горельник бөгетіне немесе шатқалына дейін жаяу барған дұрыс"

        )
        let annotation10 = PlaceAnnotation(place: place10)
        hikingPlaceAnnotations.append(annotation10)
        mapView.addAnnotation(annotation10)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? PlaceAnnotation else {
            return
        }
        
        let placeDetailVC = PlaceDetailViewController()
        placeDetailVC.place = annotation.place
        navigationController?.pushViewController(placeDetailVC, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func zoomIn() {
        var region = mapView.region
        region.span.latitudeDelta /= 2
        region.span.longitudeDelta /= 2
        mapView.setRegion(region, animated: true)
    }
    
    @objc func zoomOut() {
        var region = mapView.region
        region.span.latitudeDelta *= 2
        region.span.longitudeDelta *= 2
        mapView.setRegion(region, animated: true)
    }
    
    @objc func filterAnnotations(_ sender: UISegmentedControl) {
        mapView.removeAnnotations(mapView.annotations)
        
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.addAnnotations(campingPlaceAnnotations + hikingPlaceAnnotations)
        case 1:
            mapView.addAnnotations(campingPlaceAnnotations)
        case 2:
            mapView.addAnnotations(hikingPlaceAnnotations)
        default:
            break
        }
        
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
}


