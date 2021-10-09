//
//  ProfileViewController.swift
//  Music Bag
//
//  Created by Premier on 28/09/21.
//

import UIKit
import Kingfisher

protocol ProfileViewControllerDelegate {
    func toggleMenu()
}

class ProfileViewController: BaseViewController {
    
    var delegate: ProfileViewControllerDelegate?
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var headerContainerView: UIView = {
        let view = UIView()
        view.addShadow(shadowOpacity: 0.5, shadowRadius: 5)
        view.backgroundColor = .black1E2125
        return view
    }()
    
    private lazy var profileImageContainerView: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.backgroundColor = .white
        view.layer.cornerRadius = view.frame.height / 2
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentPhotoActionSheet)))
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private var addPhotoLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Photo"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private var profilImageBorderView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 215, height: 215)
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = view.frame.height / 2
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = .black1E2125
        label.textAlignment = .center
        return label
    }()
    
    private var secondTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.text = "Loved Musics"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: "CollectionTableViewCell")
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .backgroundColor
        configureNavigationBar()
        fulfillData()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    @objc
    private func toggleMenu() {
        self.delegate?.toggleMenu()
    }
    
    private func configureNavigationBar() {
        self.navigationController?.transparentNavigationBar()
        self.navigationController?.setTintColor(.white)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: .gearIcon, style: .plain, target: self, action: #selector(toggleMenu))
    }
    
    private func fulfillData() {
        FireBaseManager.shared.readFromFirestore(collection: "User", completion: { result in
            switch result {
            case .failure(let error):
                self.showAlert(text: error.localizedDescription)
            case .success(let documents):
                
                guard let userUid = FireBaseManager.shared.auth.currentUser?.uid else { return }
                
                for document in documents {
                    if userUid == document.documentID {
                        guard let firstName = document.data()["first_name"] as? String,
                              let lastName = document.data()["last_name"] as? String
                        else {
                            self.showAlert(text: "Error")
                            return
                        }
                        let profileImageUrl = document.data()["url_profile_image"] as? String
                        
                        self.profileNameLabel.text = "\(firstName.capitalized) \(lastName.capitalized)"
                        
                        if let imageUrl = profileImageUrl {
                            self.profileImageContainerView.kf.setImage(with: URL(string: imageUrl))
                            self.addPhotoLabel.removeFromSuperview()
                        } else {
                            self.profileImageContainerView.addSubview(self.addPhotoLabel)
                            self.addPhotoLabel.snp.makeConstraints { make in
                                make.center.equalToSuperview()
                            }
                        }
                    }
                }
            }
        })
    }
    
    private func setupView() {
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(headerContainerView)
        headerContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset((view.bounds.height / 100) * 13)
            make.leading.trailing.equalTo(view)
            make.height.equalTo((view.bounds.height / 100) * 20)
        }
        
        headerContainerView.addSubview(profilImageBorderView)
        profilImageBorderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(headerContainerView.snp.top)
            make.size.equalTo(profilImageBorderView.frame.size.height)
        }
        
        profilImageBorderView.addSubview(profileImageContainerView)
        profileImageContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(profileImageContainerView.frame.size.height)
        }
        
        headerContainerView.addSubview(profileNameLabel)
        profileNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(profileImageContainerView.snp.bottom)
            make.height.equalTo(40)
        }
        
        headerContainerView.addSubview(secondTitleLabel)
        secondTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        scrollView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerContainerView.snp.bottom)
            make.leading.trailing.equalTo(view)
            make.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell") as? CollectionTableViewCell else {
            return UITableViewCell() }
        
        return cell
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc
    private func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Photo", message: "Como você gostaria de selecionar uma foto?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take a Picture", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Escolher da galeria", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))

        present(actionSheet, animated: true)
    }

    private func presentCamera() {
        let cameraView = UIImagePickerController()
        cameraView.sourceType = .camera
        cameraView.delegate = self
        cameraView.allowsEditing = true
        present(cameraView, animated: true)
    }

    private func presentPhotoPicker() {
        let photoPickerView = UIImagePickerController()
        photoPickerView.sourceType = .photoLibrary
        photoPickerView.delegate = self
        photoPickerView.allowsEditing = true
        present(photoPickerView, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)

        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else { return }

        FireBaseManager.shared.uploadProfileImage(imageData: imageData) { success, error in
            if success {
                self.showAlert(text: "Profile picture successfuly altered")
                self.addPhotoLabel.removeFromSuperview()
            } else {
                self.showAlert(text: error?.localizedDescription ?? "")
            }
        }
        DispatchQueue.main.async {
            self.profileImageContainerView.image = selectedImage
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
 
