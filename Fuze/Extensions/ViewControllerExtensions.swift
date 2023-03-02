//
//  ViewControllerExtensions.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import UIKit

extension UIViewController {
    func displayAlert(_ error: NetworkError) {
        let alertController = UIAlertController(title: "We are sorry!", message: error.textError(), preferredStyle: .alert)
        let okButtton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okButtton)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
