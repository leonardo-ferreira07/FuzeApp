//
//  UIImageViewExtensions.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import UIKit
import NukeExtensions

extension UIImageView {
    func loadImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        NukeExtensions.loadImage(with: url, into: self)
    }
}
