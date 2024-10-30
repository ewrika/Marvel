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
        
        ViewSetup()
        HeroImageSetup()
        labelSetup()
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
    }
    
    private func ViewSetup(){
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 60),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30)
        ])
    }
    
    private func HeroImageSetup(){
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: view.topAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            heroImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            heroImageView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func labelSetup(){
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -60),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with image: UIImage, name: String) {
        heroImageView.image = image
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

#Preview {
    let cell = HeroCell(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
    
    cell.configure(with: UIImage(named: "webman")!, name: "Spider Man")
    
    return cell
}
