//
//  UIView+Extension.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//


import UIKit

extension UIViewController {
    
    func presentUserInputAlert(_ title: String, isSecure: Bool = false,
                               callback: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { field in
            field.isSecureTextEntry = isSecure
        })
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in
                                        guard let text = alert.textFields?.first?.text,
                                            !text.isEmpty else {
                                            self.presentUserInputAlert(title, callback: callback)
                                            return
                                        }
                                        callback(text)
        }))
        
          let root = UIApplication.shared.keyWindow?.rootViewController
          root?.present(alert, animated: true, completion: nil)
    }
    
}
