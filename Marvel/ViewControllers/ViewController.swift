import UIKit

class ViewController: UIViewController {
    var lastIndex = 0
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
        var layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        let colletionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        colletionView.backgroundColor = .clear
        colletionView.register(HeroCell.self, forCellWithReuseIdentifier: String(describing: HeroCell.self))
        colletionView.isPagingEnabled = true
        colletionView.decelerationRate = .fast
        
        colletionView.showsHorizontalScrollIndicator = false

        return colletionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backGround

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
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           let centerIndex = findCenterIndex()
            pathView.color = HeroList[centerIndex].color
       }
       
       private func findCenterIndex() -> Int {
           let center = self.view.convert(self.colletionView.center, to: self.colletionView)
           let index = colletionView.indexPathForItem(at: center)
           lastIndex = index?.item ?? lastIndex
           return lastIndex
       }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.9
        let height = collectionView.bounds.height * 0.8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidth = collectionView.bounds.width * 0.9
        let horizontalInset = (collectionView.bounds.width - cellWidth) / 2
        return UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}




#Preview {
    ViewController()
}

