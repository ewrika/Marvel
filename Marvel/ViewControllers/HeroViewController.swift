import UIKit
import CollectionViewPagingLayout

class HeroViewController: UIViewController {
    private var lastIndex = 0
    private let viewModel: HeroViewModel
    private let coordinator: Coordinator?
    private let detailedViewController = DetailedViewController()

    init(viewModel: HeroViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white
        indicator.hidesWhenStopped = true

        return indicator
    }()

    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [
            .foregroundColor: UIColor.white
        ])

        return refreshControl
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true

        return scrollView
    }()

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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.backGround

        addSubviews()
        setupConstraints()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        showLoader()
        bindViewModel()
        viewModel.loadHeroes()

        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshHeroes), for: .valueChanged)
    }

    @objc private func refreshHeroes() {
        showLoader()
        viewModel.loadHeroes()
    }

    private func bindViewModel() {
        viewModel.onHeroesUpdated = { [weak self] in
            self?.collectionView.reloadData()
            self?.refreshControl.endRefreshing()
            self?.setInitialPathViewColor()
            self?.hideLoader()
        }

        viewModel.onError = { [weak self] error in
            self?.refreshControl.endRefreshing()
            self?.hideLoader()
            print("Error loading heroes: \(error.localizedDescription)")
        }
    }

    private func setInitialPathViewColor() {
        guard let firstHero = viewModel.heroes.first else {
            print("No Heroes available")
            return
        }

        Task { [weak self] in
            guard let self = self else { return }
            if let image = await self.viewModel.loadImage(for: firstHero) {
                DispatchQueue.main.async {
                    self.pathView.updateColor(from: image)
                }
            }
        }

    }

    private func showLoader() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }

    private func hideLoader() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }

    private func setupConstraints() {
        scrollViewSetup()
        marvelLogoSetup()
        labelSetup()
        pathSetup()
        cellImageSetup()
        activityIndicatorSetup()
    }

    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(logoMarvel)
        scrollView.addSubview(label)
        scrollView.addSubview(pathView)
        scrollView.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }

    private func activityIndicatorSetup() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func scrollViewSetup() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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

extension HeroViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.heroes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HeroCell.self), for: indexPath) as? HeroCell else {
            print("failed")
            return UICollectionViewCell()
        }
        let hero = viewModel.hero(at: indexPath.item)

        if let url = URL(string: hero.imageURL) {
            cell.configure(with: nil, name: hero.name)
            Task {
                if let image = await viewModel.loadImage(for: hero) {
                    DispatchQueue.main.async {
                        cell.configure(with: image, name: hero.name)
                    }
                } else {
                    print("Failed to load image for \(hero.name)")
                }
            }
        } else {
            print("Invalid URL for hero image \(hero.name)")
        }

        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let centerIndex = findCenterIndex()
        let hero = viewModel.hero(at: centerIndex)

        guard let url = URL(string: hero.imageURL) else {
            print("Invalid URL for hero image \(hero.imageURL)")
            return
        }

        Task { [weak self] in
            guard let self = self else { return }
            if let image = await viewModel.loadImage(for: hero) {
                DispatchQueue.main.async {
                    self.pathView.updateColor(from: image)
                }
            } else {
                print("Failed to load image for \(hero.name)")
            }
        }

    }

    private func findCenterIndex() -> Int {
        let center = self.view.convert(self.collectionView.center, to: self.collectionView)
        let index = collectionView.indexPathForItem(at: center)
        lastIndex = index?.item ?? lastIndex
        return lastIndex
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = viewModel.hero(at: indexPath.item)

        Task {
            if let image = await viewModel.loadImage(for: hero) {
                DispatchQueue.main.async {
                    self.detailedViewController.configure(
                        with: image,
                        name: hero.name,
                        description: hero.description
                    )
                    self.navigationController?.pushViewController(self.detailedViewController, animated: true)
                }
            } else {
                print("Failed to load image for \(hero.name)")
            }
        }
    }

}
