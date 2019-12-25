//
//  FirebaseObserve.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import Firebase

public class FirebaseObserve: FirebasePaths {
    
    public static func elements(completionHandler: @escaping ([ElementsCodable]) -> ()) {
        
        self.elements.keepSynced(true)
        
        NetworkManager.isReachable { (_) in
            
            self.elements.observe(.value) { (values) in
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                    let codable = try JSONDecoder().decode([ElementsCodable].self, from: data)
                    DispatchQueue.main.async { completionHandler(codable) }
                }
                
                catch { print(error.localizedDescription) }
            }
        }
        
        NetworkManager.isUnreachable { (_) in
            
            self.elements.queryOrderedByKey().observe(.value) { (values) in
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                    let codable = try JSONDecoder().decode([ElementsCodable].self, from: data)
                    DispatchQueue.main.async { completionHandler(codable) }
                }
                
                catch { print(error.localizedDescription) }
            }
        }
    }
}
