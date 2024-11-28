import Foundation
import CollectionViewPagingLayout
import UIKit

final class HeroCell: UICollectionViewCell {

    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white
        indicator.hidesWhenStopped = true

        return indicator
    }()

    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private var label: UILabel = {
        var labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.backgroundColor = .clear
        labelView.textColor = .white
        labelView.font = UIFont.systemFont(ofSize: 30, weight: .bold)

        return labelView
    }()

    private var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setupConstraints()

        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true

    }

    private func addSubviews() {
        contentView.addSubview(view)
        view.addSubview(heroImageView)
        view.addSubview(label)
        view.addSubview(activityIndicator)
    }

    private func setupConstraints() {
        setupContainerViewConstraints()
        setupHeroImageViewConstraints()
        setupLabelConstraints()
        setupActivityIndicatorConstraints()
    }

    private func setupActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30)
        ])
    }

    private func setupHeroImageViewConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: view.topAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            heroImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            heroImageView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func setupLabelConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with image: UIImage?, name: String?) {
        if let image = image {
            heroImageView.image = image
            activityIndicator.stopAnimating()
        } else {
            heroImageView.image = nil
            activityIndicator.startAnimating()
        }
        label.text = name
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        heroImageView.image = nil
        label.text = nil
    }

}

extension HeroCell: ScaleTransformView {
    var scaleOptions: ScaleTransformViewOptions {
        .layout(.linear)
    }
}
