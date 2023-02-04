//
//  CellForFavoritesViewController.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 21.01.2023.
//

import UIKit
import SnapKit

class CellForFavoritesViewController: UITableViewCell {
    
    // MARK: - Identiifier
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI
    private var pictureImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
		image.layer.cornerRadius = 4
		image.clipsToBounds = true
        return image
    }()
    
    let usernameLabel = UILabel()
    let instagramUsername = UILabel()
    
    // MARK: - Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
    }
    
    //MARK: - Configurator
    func configure(_ viewModel: PresentPhotoModel) {
        
        // image
        if let imageURL = URL(string: viewModel.thumbImage) {
            DispatchQueue.global().async {
                
                let data = try? Data(contentsOf: imageURL)
                
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.pictureImageView.image = image
                    }
                }
            }
        }
        
		// usernameLabel
        usernameLabel.text = viewModel.userName
        usernameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        // instagramUsername
        instagramUsername.text = "@\(viewModel.instagram)"
        instagramUsername.textColor = .systemGray
    }
}

//MARK: - Setup views
private extension CellForFavoritesViewController {
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
		contentView.addSubviews(pictureImageView, usernameLabel, instagramUsername)
    }
    
    func setupConstraints() {
        pictureImageView.snp.makeConstraints { make in
			make.width.height.equalTo(100)
			make.bottom.equalToSuperview().offset(-16)
			make.leading.top.equalToSuperview().offset(16)
        }
		
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(pictureImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(16)
        }
		
        instagramUsername.snp.makeConstraints { make in
            make.leading.equalTo(pictureImageView.snp.trailing).offset(16)
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
