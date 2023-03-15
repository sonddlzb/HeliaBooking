//
//  DraggableButton.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 14/03/2023.
//

import UIKit

class DraggableButton: UIView {
    // MARK: - Outlets
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var priceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .crayola
        return view
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .crayola
        label.text = "$20"
        label.textColor = .white
        label.font = Outfit.regularFont(size: 16.0)
        label.textAlignment = .center
        return label
    }()

    lazy var draggableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.borderWidth = 4.0
        view.borderColor = .crayola
        return view
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addContentView()
        self.addLayoutConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addContentView()
        self.addLayoutConstraints()
    }

    private func addContentView() {
        self.addSubview(self.containerView)

        self.containerView.addSubview(priceView)
        self.containerView.addSubview(draggableView)

        self.priceView.addSubview(priceLabel)
    }

    private func addLayoutConstraints() {
        self.containerView.fitSuperviewConstraint()
        self.priceLabel.fitSuperviewConstraint()

        NSLayoutConstraint.activate([
            self.draggableView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            self.draggableView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.draggableView.heightAnchor.constraint(equalToConstant: 20.0),
            self.draggableView.widthAnchor.constraint(equalTo: self.draggableView.heightAnchor),

            self.priceLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.priceLabel.bottomAnchor.constraint(equalTo: self.draggableView.topAnchor, constant: -5.0),
            self.priceLabel.heightAnchor.constraint(equalToConstant: 30.0)
        ])

        self.layoutIfNeeded()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.draggableView.borderWidth = 4.0
        self.draggableView.borderColor = .crayola
        self.draggableView.layer.cornerRadius = self.draggableView.frame.height/2
        self.priceView.cornerRadius = 4.0
    }

    func setPrice(_ price: Double) {
        self.priceLabel.text = "$\(Int(price))"
    }
}
