import UIKit

class ViewController: UIViewController {
    
    private let logoMarvel: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "marvelLogo")
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose your hero"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Изменить assets Цвета на static var color потому что не так отображается
        view.backgroundColor = UIColor(red: 0.17, green: 0.15, blue: 0.17, alpha: 1.0)

        SetupAutoLayout()
        MarvelLogoSetup()
        LabelSetup()
    }
    
    private func SetupAutoLayout(){
        view.addSubview(logoMarvel)
        view.addSubview(label)
    }
    
    private func MarvelLogoSetup() {
        NSLayoutConstraint.activate([
            logoMarvel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoMarvel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoMarvel.heightAnchor.constraint(equalToConstant: 27),
            logoMarvel.widthAnchor.constraint(equalToConstant: 128)
        ])
    }
    
    private func LabelSetup(){
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: logoMarvel.bottomAnchor, constant: 54),
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

#Preview {
    ViewController()
}
