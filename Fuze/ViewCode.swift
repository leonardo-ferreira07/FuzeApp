//
//  ViewCode.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

// MARK: - ViewCode Protocol

protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupView()
    func setupAdditionalConfiguration()
}

// MARK: - Setup View method

extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}

// MARK: - Default implementation to make it `optional`

extension ViewCode {
    func setupAdditionalConfiguration() {}
}
