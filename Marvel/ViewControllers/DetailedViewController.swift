//
//  DetailedViewController.swift
//  Marvel
//
//  Created by Георгий Борисов on 09.11.2024.
//

import UIKit

class DetailedViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "deadpool") // Удалить

        return imageView
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        nameLabel.text = "DeadPool" // Удалить

        return nameLabel
    }()

    private let descriptionLabel: UITextView = {
        let descriptionLabel = UITextView()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .white
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        descriptionLabel.isEditable = false
        descriptionLabel.textAlignment = .left
        descriptionLabel.text = "32131321321313" // Удалить

        return descriptionLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        addSubviews()
        setupConstraints()
    }

    func configure(with image: UIImage, name: String, description: String) {
        imageView.image = image
        nameLabel.text = name
        descriptionLabel.text = description
    }

    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
    }

    private func setupConstraints() {
        setupImageView()
        setupNameLabel()
        setupDescriptionLabel()
    }

    private func setupImageView() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupNameLabel() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 250),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupDescriptionLabel() {
            NSLayoutConstraint.activate([
                descriptionLabel.topAnchor.constraint(equalTo: nameLabel.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }

}

#Preview{
    DetailedViewController()
}
