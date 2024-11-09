import UIKit
import CollectionViewPagingLayout

class ViewController: UIViewController {
    var lastIndex = 0
    private let logoMarvel: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Photo.marvelLogo

        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.Text.chooseHero
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white

        return label
    }()

    private let pathView: TrianglePathView = {
        let pathView = TrianglePathView()
        pathView.translatesAutoresizingMaskIntoConstraints = false
        pathView.backgroundColor = .clear

        return pathView
    }()

    private var collectionView: UICollectionView = {
        var layout = CollectionViewPagingLayout()
        layout.scrollDirection = .horizontal
        layout.numberOfVisibleItems = nil

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(HeroCell.self, forCellWithReuseIdentifier: String(describing: HeroCell.self))
        collectionView.isPagingEnabled = true
        collectionView.decelerationRate = .fast
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()

    private let detailedViewController = DetailedViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backGround

        addSubviews()
        marvelLogoSetup()
        labelSetup()
        pathSetup()
        cellImageSetup()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        setInitialPathViewColor()

    }

    private func setInitialPathViewColor() {
        if let firstHero = heroList.first,
           let firstImage = UIImage(named: firstHero.image),
           let initialColor = firstImage.averageColor {
            pathView.color = initialColor
        }
    }

    private func addSubviews() {
        view.addSubview(logoMarvel)
        view.addSubview(label)
        view.addSubview(pathView)
        view.addSubview(collectionView)
    }

    private func marvelLogoSetup() {
        NSLayoutConstraint.activate([
            logoMarvel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoMarvel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoMarvel.heightAnchor.constraint(equalToConstant: 27),
            logoMarvel.widthAnchor.constraint(equalToConstant: 128)
        ])
    }

    private func labelSetup() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: logoMarvel.bottomAnchor, constant: 54),
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func pathSetup() {
        NSLayoutConstraint.activate([
            pathView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pathView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pathView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pathView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func cellImageSetup() {

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HeroCell.self), for: indexPath) as? HeroCell else {
             print("failed")
            return UICollectionViewCell()
        }
        let hero = heroList[indexPath.item]

        if let url = URL(string: hero.url) {
            cell.configure(with: url, name: hero.name)
        } else {
            print("Hero image \(hero.image) not found")
        }
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let centerIndex = findCenterIndex()
        let hero = heroList[centerIndex]

        if let image = UIImage(named: hero.image),
           let averageColor = image.averageColor {
            pathView.color = averageColor
        } else {
            pathView.color = .clear
        }
    }

    private func findCenterIndex() -> Int {
        let center = self.view.convert(self.collectionView.center, to: self.collectionView)
        let index = collectionView.indexPathForItem(at: center)
        lastIndex = index?.item ?? lastIndex
        return lastIndex
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = heroList[indexPath.item]

        guard let url = URL(string: hero.url) else {
            print("Invalid URL for hero image \(hero.image)")
            return
        }

        detailedViewController.configure(with: url, name: hero.name, description: hero.description)
        navigationController?.pushViewController(detailedViewController, animated: true)

        let backImage = Constants.Photo.arrowBack
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = .white
    }

}

#Preview {
    ViewController()
}
