//
//  IntroductionViewController.swift
//  HeliaHotelBooking
//
//  Created by Hà Quang Hưng on 01/03/2023.
//

import UIKit

class IntroductionViewController: BaseViewControler {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var buttonNextScreen: TapableView!
    var pageSlideBar: PageSlideBar!
    var currentPage = 0
    var dataSlideIntroStore = DataSlideIntroStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    func setUpView() {
        createSlideIntro()
        configPageSlideBar()
    }
    func configPageSlideBar() {
        pageSlideBar = PageSlideBar()
        pageSlideBar.numberOfPages = 3
        pageSlideBar.currentPage = 0
        pageSlideBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pageSlideBar)
        pageSlideBar.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8).isActive = true
        pageSlideBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        pageSlideBar.widthAnchor.constraint(equalToConstant: 36).isActive = true
        pageSlideBar.bottomAnchor.constraint(equalTo: buttonNextScreen.topAnchor, constant: -30).isActive = true
    }
    func createSlideIntro() {
        let nib = UINib(nibName: "SlideCollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "Slide")
        self.dataSlideIntroStore.arrNameImage = ["travel1", "travel2", "travel3"]
        self.dataSlideIntroStore.arrTextLabelTitle = ["Travel safely, comfortably, & easily",
                                                      "Find the best hotels for your vacation",
                                                      "Let's discover the world with us"]
        self.dataSlideIntroStore.arrTextLabelContent
            .append("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ternpor incididunt ut labore et dolore magna aliqua")
        self.dataSlideIntroStore.arrTextLabelContent
            .append("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ternpor incididunt ut labore et dolore magna aliqua")
        self.dataSlideIntroStore.arrTextLabelContent
            .append("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ternpor incididunt ut labore et dolore magna aliqua")
    }
    @IBAction func nextScreen(_ sender: Any) {
        if currentPage < dataSlideIntroStore.arrTextLabelTitle.count - 1 {
            currentPage += 1
            collectionView.setContentOffset(CGPoint(x: Int(view.frame.width) * currentPage, y: 0), animated: true)
        } else {
            navigationController?.pushViewController(SignInViewController(), animated: true)
        }
    }
    @IBAction func skipIntro(_ sender: Any) {
        let positionXLastItem = dataSlideIntroStore.arrTextLabelContent.count - 1
        collectionView.setContentOffset(CGPoint(x: Int(view.frame.width) * positionXLastItem, y: 0), animated: true)
    }
}

extension IntroductionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSlideIntroStore.arrTextLabelTitle.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Slide",
                                                            for: indexPath) as? SlideCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageIntro.image = UIImage(named: dataSlideIntroStore.arrNameImage[indexPath.row])
        cell.labelTitle.text = dataSlideIntroStore.arrTextLabelTitle[indexPath.row]
        cell.labelContent.text = dataSlideIntroStore.arrTextLabelContent[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.currentPage = indexPath.row
        pageSlideBar.currentPage = indexPath.row
    }
}

extension IntroductionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
}
