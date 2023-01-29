//
//  DetailImageViewController.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 20.01.2023.
//

import UIKit
import SnapKit

class DetailImageViewController: UIViewController {
    
    // MARK: - Public properties
    var model: PresentPhotoModel!
	
	// MARK: - Private properties
	private var photoGalleryManager = PhotoGalleryManager.shared
    
    // MARK: - UI
	private let usernameLabel = UILabel()
	private let instagramLabel = UILabel()
	
    private var pictureImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 4
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var addToFavoritesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to favorites", for: .normal)
        button.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        button.tintColor = .white
        button.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        button.layer.shadowColor = UIColor.systemGray2.cgColor
        button.layer.shadowOpacity = 0.5
        button.alpha = 0.7
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fillElements()
    }
    
    //MARK: - Methods
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc private func addToFavorites() {
		var isFavourite = model.isFavourite
		if isFavourite {
			isFavourite.toggle()
            photoGalleryManager.favouritesArray.remove(at: 0)
            addToFavoritesButton.setTitle("Add to favorites", for: .normal)
        } else {
            if let modelForFavourites = self.model {
                self.photoGalleryManager.favouritesArray.insert(modelForFavourites, at: 0)
				isFavourite.toggle()
                self.addToFavoritesButton.setTitle("Delete from favorites", for: .normal)
                print("Image added to favourites. Total count: \(self.photoGalleryManager.favouritesArray.count)")
            }
        }
    }
    
    private func loadImages() {
        guard let model = model else { return }
        
        // Picture
        if let image = URL(string: model.image) {
            DispatchQueue.global(qos: .userInitiated).async {
                let data = try? Data(contentsOf: image)
                
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.pictureImageView.image = image
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
        
        // Avatar
        if let image = URL(string: model.userAvatar) {
            DispatchQueue.global(qos: .userInitiated).async {
                let data = try? Data(contentsOf: image)
                
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.profileImageView.image = image
                    }
                }
            }
        }
    }
    
    private func fillElements() {
        
        //load images
        loadImages()
        
        guard let model = model else { return }
        
        //username
        usernameLabel.text = model.userName
        usernameLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        //instagram
        instagramLabel.text = "@\(model.instagram)"
        instagramLabel.textColor = .systemGray
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
        view.addSubview(dismissButton)
        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(instagramLabel)
        view.addSubview(addToFavoritesButton)
        view.addSubview(activityIndicator)
        pictureImageView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func setupConstraints() {
        
        pictureImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.68)
        }
        
        dismissButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(30)
            make.width.equalTo(31)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(pictureImageView.snp.bottom).offset(20)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.top.equalTo(pictureImageView.snp.bottom).offset(20)
        }
        
        instagramLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        addToFavoritesButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(50)
            make.width.equalTo(250)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(pictureImageView.snp.center)
        }
    }
}
