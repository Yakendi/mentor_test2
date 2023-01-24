//
//  CellForUnsplashImage.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 19.01.2023.
//

import UIKit
import SnapKit

class CellForExploreImage: UICollectionViewCell {
    
    //MARK: - Identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    //MARK: - Setup cell
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
    
    //MARK: - Configurator
    func configure(_ viewModel: ImageURLs) {
        if let imageURL = URL(string: viewModel.thumb ?? "nil") {
            DispatchQueue.global().async {
                                                
                let data = try? Data(contentsOf: imageURL)
                
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
}

//MARK: - Setup views
private extension CellForExploreImage {
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
