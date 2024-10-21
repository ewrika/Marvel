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
    
    private let pathView : PathView = {
       let pathView = PathView()
        pathView.translatesAutoresizingMaskIntoConstraints = false
        pathView.backgroundColor = .clear
        
        return pathView
    }()
    
    private var colletionView:UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let colletionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        colletionView.backgroundColor = .clear
        colletionView.register(HeroCell.self, forCellWithReuseIdentifier: String(describing: HeroCell.self))
        colletionView.isPagingEnabled = true
        colletionView.showsHorizontalScrollIndicator = false

        return colletionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Изменить assets Цвета на static var color потому что не так отображается
        view.backgroundColor = UIColor(red: 0.17, green: 0.15, blue: 0.17, alpha: 1.0)

        SetupAutoLayout()
        MarvelLogoSetup()
        LabelSetup()
        PathSetup()
        CellImageSetup()
        
        
        self.colletionView.dataSource = self
        self.colletionView.delegate = self
    }
    
    private func SetupAutoLayout(){
        view.addSubview(logoMarvel)
        view.addSubview(label)
        view.addSubview(pathView)
        view.addSubview(colletionView)
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
    
    private func PathSetup(){
        NSLayoutConstraint.activate([
            pathView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pathView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pathView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pathView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
    private func CellImageSetup(){
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
             colletionView.topAnchor.constraint(equalTo: label.bottomAnchor),
             colletionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
             colletionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
             colletionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
             ])
    }

}

extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HeroList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:HeroCell.self), for: indexPath) as? HeroCell else {
            fatalError("Failed")
        }
        let image = HeroList[indexPath.item]
        
        cell.configure(with: UIImage(named:image.image)!, name:image.name )
        
        return cell
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 550)
    }
}

#Preview {
    ViewController()
}

