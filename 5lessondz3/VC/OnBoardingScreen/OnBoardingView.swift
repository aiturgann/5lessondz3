//
//  OnBoardingView.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 26/3/24.
//

import UIKit

struct Model {
    var image: UIImage
    var title: String
    var description: String
}

class OnBoardingView: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 260)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
        
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(named: "red"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipBtnTppd), for: .touchUpInside)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(named: "red")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextBtnTppd), for: .touchUpInside)
        return button
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .darkGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    var currentIndex = 0
    
    
    let model: [Model] = [Model(image: .image1,
                                title: "Welcome to The Note",
                                description: "Welcome to The Note – your new companion for tasks, goals, health – all in one place. Let's get started!"),
                          Model(image: .image2,
                                title: "Set Up Your Profile",
                                description: "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals. "),
                          Model(image: .image3,
                                title: "Dive into The Note",
                                description: "You're fully equipped to dive into the world of The Note. Remember, we're here to assist you every step of the way. Ready to start? Let's go!")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnBoardingCVCell.self, forCellWithReuseIdentifier: "cell")
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate(
            [collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
             collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             collectionView.heightAnchor.constraint(equalToConstant: 260)
            ])
        
        view.addSubview(skipButton)
        NSLayoutConstraint.activate(
            [skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
             skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             skipButton.heightAnchor.constraint(equalToConstant: 40),
             skipButton.widthAnchor.constraint(equalToConstant: (view.frame.width - 44) / 2)
            ])
        
        view.addSubview(nextButton)
        NSLayoutConstraint.activate(
            [nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
             nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
             nextButton.heightAnchor.constraint(equalToConstant: 40),
             nextButton.widthAnchor.constraint(equalToConstant: (view.frame.width - 44) / 2)
            ])
        
        view.addSubview(pageControl)
        NSLayoutConstraint.activate(
            [pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
             pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    @objc private func skipBtnTppd() {
        let vc = MainView()
        UserDefaults.standard.set(true, forKey: "isOnboardingShown")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func nextBtnTppd() {
        currentIndex += 1
        if currentIndex < 3 {
            pageControl.currentPage = currentIndex
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = true
        } else {
            let vc = MainView()
            UserDefaults.standard.set(true, forKey: "isOnboardingShown")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension OnBoardingView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnBoardingCVCell
        cell.setData(model: model[indexPath.row])
        
        return cell
    }
    
}

extension OnBoardingView: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        let width = view.frame.width
        
        let page = contentOffsetX / width
        
        switch page {
        case 0.0:
            pageControl.currentPage = 0
        case 1.0:
            pageControl.currentPage = 1
        case 2.0:
            pageControl.currentPage = 2
        default:
            ()
        }
    }
}
            




