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
        image.backgroundColor = .systemOrange
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
        fillLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Fill labels
    private func fillLabels() {
        
		//usernameLabel
//        usernameLabel.text = "USERNAME"
        usernameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        //instagramUsername
//        instagramUsername.text = "Photo description"
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
		contentView.addSubview(pictureImageView)
		contentView.addSubview(usernameLabel)
		contentView.addSubview(instagramUsername)
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
