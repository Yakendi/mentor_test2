//
//  CellForFavoritesViewController.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 21.01.2023.
//

import UIKit
import SnapKit

class CellForFavoritesViewController: UITableViewCell {
    
    //MARK: - Identiifier
    static var identifier: String {
        return String(describing: self)
    }
    
    //MARK: - Setup cell
    private lazy var pictureImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemOrange
        return image
    }()
    
    let usernameLabel = UILabel()
    let photoDescription = UILabel()
    
    //MARK: - Constructor
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
        usernameLabel.text = "USERNAME"
        usernameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        //photoDescription
        photoDescription.text = "Photo description"
        photoDescription.textColor = .systemGray
        photoDescription.numberOfLines = 0
        photoDescription.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Setup views
private extension CellForFavoritesViewController {
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(pictureImageView)
        addSubview(usernameLabel)
        addSubview(photoDescription)
    }
    
    func setupConstraints() {
        pictureImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(80)
            make.width.equalTo(80)
            pictureImageView.layer.cornerRadius = 4
            pictureImageView.clipsToBounds = true
        }
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(pictureImageView.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(16)
        }
        photoDescription.snp.makeConstraints { make in
            make.leading.equalTo(pictureImageView.snp.trailing).offset(8)
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
