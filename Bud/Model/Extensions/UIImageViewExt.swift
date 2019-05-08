//
//  UIImageView.swift
//  Bud
//
//  Created by Aaron Thomas on 07/05/2019.
//  Copyright © 2019 InteractiveCode. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
   
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        self.image = nil
    
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }

        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                if error != nil {
                    //log error silently
                    DispatchQueue.main.async(execute: {
                        self.image = UIImage(named: "placeholder")
                    })
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                        self.image = downloadedImage
                    }
                })
            }).resume()
        }
    }
}
