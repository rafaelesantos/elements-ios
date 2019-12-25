//
//  URLResquestExtension.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

extension URLRequest {
    
    public static func getSingleImage(urlString: String, completionHandler: @escaping ([String: UIImage]) -> ()) {
        
        NetworkManager.isReachable { (_) in
            
            DispatchQueue.global(qos: .background).async {
                
                guard let url = URL(string: urlString) else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                guard let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async { completionHandler([urlString: image]) }
            }
        }
    }
    
    public static func getManyImages(forKey: UserDefaultsImages, urlsString: [String], completionHandler: @escaping ([String: UIImage]) -> ()) {
        
        var images: [String: UIImage] = [:]
        
        NetworkManager.isReachable { (_) in
            
            for urlString in urlsString {
                
                URLRequest.getSingleImage(urlString: urlString) { (imageDict) in
                    
                    images[imageDict.first?.key ?? ""] = imageDict.first?.value ?? UIImage()
                    completionHandler(images)
                }
            }
        }
        
        NetworkManager.isUnreachable { (_) in
            
            completionHandler((UserDefaults.standard.value(forKey: forKey.rawValue) as? [String: Data] ?? [:]).mapValues({ (pngData) -> UIImage in
                return UIImage(data: pngData) ?? UIImage()
            }))
        }
    }
}
