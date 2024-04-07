//
//  ViewController.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 26/3/24.
//

import UIKit

protocol MainViewProtocol {
    
    func successNotes(notes: [Note])
}

class MainView: UIViewController {
    
    private var notes: [Note] = []
    
    private var controller: MainControllerProtocol?
    
    private var isSearching: Bool = false
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search".localized()
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarEditingChanged), for: .editingChanged)
        return searchBar
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes".localized()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 60) / 2, height: 100)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.backgroundColor = UIColor(named: "red")
        button.layer.cornerRadius = 42/2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addBtnTppd), for: .touchUpInside)
        return button
    }()
    
    private let searchResultLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainCVCell.self, forCellWithReuseIdentifier: MainCVCell.reuseId)
        
        setupUI()
        controller = MainController(view: self)
        addGestureRecognizer()
    }
    
    private func localizeWords() {
        titleLabel.text = "Notes".localized()
        searchBar.placeholder = "Search".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isDarkTheme = UserDefaults.standard.bool(forKey: "isDarkTheme")
        if isDarkTheme == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
        
        setupNavItem(isDarkTheme: isDarkTheme)
        controller?.onGetNotes()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.title = ""
    }
    
    private func setupNavItem(isDarkTheme: Bool) {
        localizeWords()
        navigationItem.title = "Home".localized()
        let navItemSettingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsBtnTppd))
        navItemSettingsButton.tintColor = .black
        navigationItem.rightBarButtonItem = navItemSettingsButton
        navigationItem.setHidesBackButton(true, animated: false)
        
        if isDarkTheme == true {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationItem.rightBarButtonItem?.tintColor = .white
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationItem.rightBarButtonItem?.tintColor = .black
        }
        
    }
    
    private func setupUI() {
        view.addSubview(searchBar)
        NSLayoutConstraint.activate(
            [searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
             searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate(
            [titleLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
             titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39),
             titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -39),
             titleLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate(
            [collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
             collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             collectionView.heightAnchor.constraint(equalToConstant: 250)
            ])
        
        view.addSubview(addButton)
        NSLayoutConstraint.activate(
            [addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130),
             addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             addButton.heightAnchor.constraint(equalToConstant: 42),
             addButton.widthAnchor.constraint(equalToConstant: 42)
            ])
        
        view.addSubview(searchResultLabel)
        NSLayoutConstraint.activate(
            [searchResultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             searchResultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    @objc private func settingsBtnTppd() {
        let vc = SettingsView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func addBtnTppd() {
        let vc = AddNoteView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func searchBarEditingChanged() {
        guard let text = searchBar.text else {
            return
        }
        isSearching = true
        controller?.onSearchNotes(text: text)
    }
    
    private func addGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(resignSearchBar))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func resignSearchBar() {
        if searchBar.text?.isEmpty == true {
            searchBar.text = ""
            searchBar.resignFirstResponder()
            if notes.isEmpty {
                searchResultLabel.text = "Add your first note!".localized()
            } else {
                searchResultLabel.text = ""
            }
        }   
    }
    
}

extension MainView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCVCell.reuseId, for: indexPath) as! MainCVCell
        cell.setData(title: notes[indexPath.row].title ?? "")
        cell.backgroundColor = .systemMint
        cell.layer.cornerRadius = 12
        return cell
    }
    
    
}

extension MainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AddNoteView()
        vc.setNote(note: notes[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
    

extension MainView: MainViewProtocol {
    
    func successNotes(notes: [Note]) {
        if notes.isEmpty {
            if isSearching {
                searchResultLabel.text = "Nothing was found for your request...".localized()
            } else {
                searchResultLabel.text = "Add your first note!".localized()
            }
            searchResultLabel.isHidden = false
        } else {
            searchResultLabel.text = ""
            searchResultLabel.isHidden = true
        }
        self.notes = notes
        collectionView.reloadData()
    }
}


