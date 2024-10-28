import Foundation
import CollectionViewPagingLayout
import UIKit

final class HeroCell: UICollectionViewCell {

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
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(view)
        view.addSubview(heroImageView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: view.topAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            heroImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            heroImageView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
        	
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
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
