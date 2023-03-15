//
//  PriceSlider.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 14/03/2023.
//

private struct Const {
    static let progressHeight = 4.0
    static let draggableButtonWidth = 55.0
    static let draggableButtonheight = 60.0
    static let maxPrice = 300.0
    static let minPrice = 0.0
    static let defaultStart = 0.0
    static let defaultEnd = 200.0
}

import UIKit

class PriceSliderView: UIView {
    // MARK: - Outlets
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0xEEEEEE)
        return view
    }()

    private lazy var filledView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .crayola
        return view
    }()

    private lazy var startDraggableButton: DraggableButton = {
        let button = DraggableButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var endDraggableButton: DraggableButton = {
        let button = DraggableButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var startDraggableButtonLeadingConstraint = NSLayoutConstraint()
    private var endDraggableButtonLeadingConstraint = NSLayoutConstraint()
    private var filledViewLeadingConstraint = NSLayoutConstraint()
    private var filledViewTrailingConstraint = NSLayoutConstraint()

    // MARK: - Variables
    var currentStartPrice = 0.0
    var currentEndPrice = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    private func commonInit() {
        self.addContentView()
        self.addLayoutConstraints()
        self.layoutIfNeeded()
        self.addPanGestureForDraggableButton()
    }

    private func addContentView() {
        self.addSubview(self.containerView)

        self.containerView.addSubview(backgroundView)
        self.containerView.addSubview(filledView)
        self.containerView.addSubview(startDraggableButton)
        self.containerView.addSubview(endDraggableButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.updatePrice()
    }

    private func addLayoutConstraints() {
        self.containerView.fitSuperviewConstraint()

        NSLayoutConstraint.activate([
            self.backgroundView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            self.backgroundView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,
                                                        constant: -10.0 + Const.progressHeight/2),
            self.backgroundView.heightAnchor.constraint(equalToConstant: Const.progressHeight),

            self.filledView.heightAnchor.constraint(equalToConstant: Const.progressHeight),
            self.filledView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,
                                                    constant: -10.0 + Const.progressHeight/2),

            self.startDraggableButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.startDraggableButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40.0),
            self.startDraggableButton.widthAnchor.constraint(equalToConstant: Const.draggableButtonheight),

            self.endDraggableButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.endDraggableButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40.0),
            self.endDraggableButton.widthAnchor.constraint(equalToConstant: Const.draggableButtonheight)
        ])

        self.filledViewLeadingConstraint =
        self.filledView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,
                                                 constant: Const.defaultStart)
        self.filledViewTrailingConstraint =
        self.filledView.trailingAnchor.constraint(equalTo: self.containerView.leadingAnchor,
                                                  constant: Const.defaultEnd)
        self.startDraggableButtonLeadingConstraint =
        self.startDraggableButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,
                                                           constant: Const.defaultStart - Const.draggableButtonheight/2)
        self.endDraggableButtonLeadingConstraint =
        self.endDraggableButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,
                                                         constant: Const.defaultEnd - Const.draggableButtonheight/2)

        self.filledViewLeadingConstraint.isActive = true
        self.filledViewTrailingConstraint.isActive = true
        self.startDraggableButtonLeadingConstraint.isActive = true
        self.endDraggableButtonLeadingConstraint.isActive = true
    }

    private func addPanGestureForDraggableButton() {
        let startPanGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedStartDraggableView(_:)))
        let endPanGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedEndDraggableView(_:)))
        self.startDraggableButton.addGestureRecognizer(startPanGesture)
        self.endDraggableButton.addGestureRecognizer(endPanGesture)

    }

    @objc func draggedStartDraggableView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        if self.startDraggableButtonLeadingConstraint.constant + translation.x <
            self.endDraggableButtonLeadingConstraint.constant {
            self.filledViewLeadingConstraint.constant =
            min(max(0, self.filledViewLeadingConstraint.constant + translation.x), self.containerView.frame.width)
            self.startDraggableButtonLeadingConstraint.constant =
            min(max(-Const.draggableButtonheight/2,
                     self.startDraggableButtonLeadingConstraint.constant + translation.x),
                self.containerView.frame.width - Const.draggableButtonheight/2)
            self.updatePrice()
            self.layoutIfNeeded()
        }

        sender.setTranslation(CGPoint.zero, in: self)
    }

    @objc func draggedEndDraggableView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let isAbleToTranslate = self.endDraggableButtonLeadingConstraint.constant + translation.x >
            self.startDraggableButtonLeadingConstraint.constant
        if isAbleToTranslate {
            self.filledViewTrailingConstraint.constant =
                min(max(0, self.filledViewTrailingConstraint.constant + translation.x), self.containerView.frame.width)
            self.endDraggableButtonLeadingConstraint.constant =
            min(max(-Const.draggableButtonheight/2, self.endDraggableButtonLeadingConstraint.constant + translation.x),
                self.containerView.frame.width - Const.draggableButtonheight/2)
            self.updatePrice()
            self.layoutIfNeeded()
        }

        sender.setTranslation(CGPoint.zero, in: self)
    }

    func updatePrice() {
        let startPrice = Double(Const.maxPrice - Const.minPrice) *
            (self.startDraggableButtonLeadingConstraint.constant /
            (self.containerView.frame.width - Const.draggableButtonheight/2))
        let endPrice = Double(Const.maxPrice - Const.minPrice) *
            (self.endDraggableButtonLeadingConstraint.constant /
            (self.containerView.frame.width - Const.draggableButtonheight/2))
        self.currentStartPrice = max(Const.minPrice, min(Const.maxPrice, startPrice))
        self.currentEndPrice = max(Const.minPrice, min(Const.maxPrice, endPrice))
        self.startDraggableButton.setPrice(self.currentStartPrice)
        self.endDraggableButton.setPrice(self.currentEndPrice)
    }
}
