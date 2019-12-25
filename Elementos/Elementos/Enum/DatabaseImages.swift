//
//  DatabaseImages.swift
//  AAACOMP
//
//  Created by Rafael Escaleira on 17/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

public enum UserDefaultsImages: String {
    
    case elements = "elementsImages"
    
    public static func set(forKey: UserDefaultsImages, dict: [String: UIImage]) {
        
        let dictImageData = dict.mapValues({ (image) -> Data in return image.pngData() ?? Data() })
        UserDefaults.standard.set(dictImageData, forKey: forKey.rawValue)
    }
}
