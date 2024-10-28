import Foundation
import CollectionViewPagingLayout
import UIKit

final class HeroCell: UICollectionViewCell {

    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView(frame: self.frame)
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
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Добавляем heroImageView и label в contentView
        contentView.addSubview(heroImageView)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            heroImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            heroImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 28),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -120),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage, name: String) {
        heroImageView.image = image
        label.text = name
    }
}

extension HeroCell: ScaleTransformView {
    var scaleOptions: ScaleTransformViewOptions {
        .layout(.linear)
    }
}

#Preview {
    let cell = HeroCell(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
    
        cell.configure(with: UIImage(named: "webman")!, name: "Spider Man")
    
    return cell
}


