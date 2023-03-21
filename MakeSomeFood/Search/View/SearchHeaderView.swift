//
//  SearchHeaderView.swift
//  MakeSomeFood
//
//  Created by Луиза Самойленко on 21.03.2023.
//

import Foundation
import UIKit

class SearchHeaderView: UICollectionReusableView {
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.font = .montserratMedium22()
        label.tintColor = .specialBlack
        return label
    }()

    let headerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translates()
        button.tintColor = .specialBlack
        button.titleLabel?.font = .montserratMedium13()
        return button
    }()

    private var openAllTags: (() -> Void)?
    private var headerLabelLeading: NSLayoutConstraint?
    private var headerButtonTrailing: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupLayout()
        configureButton()
        setupContsraints()
    }
}

extension SearchHeaderView {
    private func setupLayout() {
        addSubview(headerLabel)
        addSubview(headerButton)
    }

    private func setupContsraints() {
        headerLabelLeading = headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabelLeading!,
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            headerButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerButton.leadingAnchor.constraint(greaterThanOrEqualTo: headerLabel.trailingAnchor, constant: 16),
            headerButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
        ])
    }

    func configure(title: String, actionTitle: String? = nil, offset: CGFloat = 0, openAllTags: (() -> Void)? = nil) {
        headerLabel.text = title
        headerButton.setTitle(actionTitle, for: .normal)
        headerLabelLeading?.constant = offset
        self.openAllTags = openAllTags
    }

    func configureButton() {
        headerButton.addTarget(self, action: #selector(headerButtonTapped), for: .touchUpInside)
    }

    @objc func headerButtonTapped() {
        openAllTags?()
    }
}
