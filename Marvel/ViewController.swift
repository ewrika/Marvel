import UIKit

class ViewController: UIViewController {
    
    private let logoMarvel: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "marvelLogo")
        return imageView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Background")
        SetupAutoLayout()
        MarvelLogo()
    }
    
    private func SetupAutoLayout(){
        
        view.addSubview(logoMarvel)
        
    }
    
    private func MarvelLogo() {
        NSLayoutConstraint.activate([
            logoMarvel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoMarvel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoMarvel.heightAnchor.constraint(equalToConstant: 27),
            logoMarvel.widthAnchor.constraint(equalToConstant: 128)
        ])
    }
}

#Preview {
    ViewController()
}
