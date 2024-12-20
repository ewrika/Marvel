import UIKit
import CollectionViewPagingLayout

class HeroViewController: UIViewController {
    private var lastIndex = 0
    private let viewModel: HeroViewModel
    private let coordinator: Coordinator?
    private let detailedViewController = DetailedViewController()
    private var isLoadingMoreHeroes = false

    enum ViewState {
        case loading
        case loaded
        case offline
        case error
    }

    init(viewModel: HeroViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        effectView.alpha = 0

        return effectView
    }()

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
        setupView()
        setupCollectionView()
        setupRefreshControl()

        viewModel.onStateChanged = { [weak self] state in
            guard let self = self else {return}
            switch state {
            case .loading:
                showLoader()
            case .loaded:
                hideLoader()
                collectionView.reloadData()
                refreshControl.endRefreshing()
            case .offline:
                hideLoader()
                refreshControl.endRefreshing()
                collectionView.reloadData()
                AlertPresenter.showError(on: self, title: "Нет подключения к интернету", message: "Включен оффлайн режим")
            case .error:
                hideLoader()
                refreshControl.endRefreshing()
                AlertPresenter.showError(on: self, title: "Произошла ошибка", message: "Попробуйте позже")
            }

        }

        bindViewModel()
        viewModel.loadHeroes()
    }

    private func setupView() {
        view.backgroundColor = Constants.Color.backGround
        addSubviews()
        setupConstraints()
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupRefreshControl() {
        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshHeroes), for: .valueChanged)
    }

    @objc private func refreshHeroes() {
        showLoader()
        viewModel.loadHeroes()
    }

    private func bindViewModel() {
        viewModel.onHeroesUpdated = {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            self.setInitialPathViewColor()
            self.hideLoader()
        }

        viewModel.onError = {  error in
            self.refreshControl.endRefreshing()
            self.hideLoader()
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
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 1
        }
    }

    private func hideLoader() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 0
        }
    }

    private func setupConstraints() {
        scrollViewSetup()
        marvelLogoSetup()
        labelSetup()
        pathSetup()
        cellImageSetup()
        blurEffectViewSetup()
        activityIndicatorSetup()
    }

    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(logoMarvel)
        scrollView.addSubview(label)
        scrollView.addSubview(pathView)
        scrollView.addSubview(collectionView)
        view.addSubview(blurEffectView)
        view.addSubview(activityIndicator)
    }

    private func activityIndicatorSetup() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func blurEffectViewSetup() {
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
            cell.configure(with: nil, name: hero.name)
            Task {
                if let image = await viewModel.loadImage(for: hero) {
                    DispatchQueue.main.async {
                        cell.configure(with: image, name: hero.name)
                    }
                }
            }

        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let centerIndex = findCenterIndex()
        let hero = viewModel.hero(at: centerIndex)

        Task { [weak self] in
            guard let self = self else { return }
            if let image = await viewModel.loadImage(for: hero) {
                DispatchQueue.main.async {
                    self.pathView.updateColor(from: image)
                }
            }
        }

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !viewModel.heroes.isEmpty else { return }

        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.width
        let frameWidth = scrollView.frame.width

        if offsetX > contentWidth - frameWidth * 2 && !isLoadingMoreHeroes {
            isLoadingMoreHeroes = true
            viewModel.loadHeroes()
            viewModel.onHeroesUpdated = {
                self.collectionView.reloadData()
                self.isLoadingMoreHeroes = false
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
            }
        }
    }

}
