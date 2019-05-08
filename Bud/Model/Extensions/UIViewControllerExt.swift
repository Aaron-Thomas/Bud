//
//  UIViewControllerExt.swift
//  Bud
//
//  Created by Aaron Thomas on 07/05/2019.
//  Copyright © 2019 InteractiveCode. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showLoadingView() {
        let backgroundView = UIView()
        backgroundView.frame =  CGRect(x:0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        backgroundView.tag = 1
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        let spinner = UIActivityIndicatorView()
        spinner.frame = CGRect(x:0, y: 0, width: 50, height: 50)
        spinner.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        spinner.color = UIColor.white
        spinner.tag = 2
        
        self.view.addSubview(backgroundView)
        self.view.addSubview(spinner)
        self.view.bringSubviewToFront(spinner)
        self.view.isUserInteractionEnabled = false
        
        DispatchQueue.main.async {
            spinner.startAnimating()
        }
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            if let backgroundView = self.view.viewWithTag(1) {
                backgroundView.removeFromSuperview()
            }
            if let spinner = self.view.viewWithTag(2) {
                spinner.removeFromSuperview()
            }
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func showErrorPopoverView(errorTitle: String, errorMessage: String) {
        guard let errorView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "errorview") as? ErrorView else { return }
        
        errorView.errorTitle = errorTitle
        errorView.errorMessage = errorMessage
        
        self.present(errorView, animated: true, completion: nil)
    }
}
