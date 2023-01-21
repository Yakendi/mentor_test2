//
//  DetailImageViewController.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 20.01.2023.
//

import UIKit
import SnapKit

class DetailImageViewController: UIViewController {
    
    //MARK: - UI
    private lazy var pictureImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .systemPink
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .systemPink
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var addToFavoritesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to favorites", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemPink
        return button
    }()
    
    let usernameLabel = UILabel()
    let instagramLabel = UILabel()
    let descriptionLabel = UILabel()
    let locationLabel = UILabel()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fillLabels()
    }
    
    //MARK: - Fill labels
    private func fillLabels() {
        //username
        usernameLabel.text = "USERNAME"
        usernameLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //instagram
        instagramLabel.text = "@instagram"
        instagramLabel.textColor = .systemGray
        instagramLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //description
        descriptionLabel.text = "Great pink color Great pink color Great pink color Great pink color Great pink color Great pink color"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //location
        locationLabel.text = "\u{1F4CD}Iowa, US"
        locationLabel.textColor = .systemGray
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Setup views
private extension DetailImageViewController {
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(pictureImageView)
        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(instagramLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(locationLabel)
        view.addSubview(addToFavoritesButton)
    }
    
    func setupConstraints() {
        pictureImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.55)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(pictureImageView.snp.bottom).offset(20)
            make.height.equalTo(70)
            make.width.equalTo(70)
            profileImageView.layer.cornerRadius = 4
            profileImageView.clipsToBounds = true
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.top.equalTo(pictureImageView.snp.bottom).offset(20)
        }
        
        instagramLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
        
        addToFavoritesButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(50)
            make.width.equalTo(300)
            addToFavoritesButton.layer.cornerRadius = 10
            addToFavoritesButton.clipsToBounds = true
        }
    }
}
