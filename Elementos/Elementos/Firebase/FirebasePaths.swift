//
//  FirebasePaths.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import Firebase

public class FirebasePaths {
    
    static let reference = Database.database().reference()
    static let elements = FirebasePaths.reference.child("elements")
}
