//
//  Extension.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UIView {
    
    func changeTag() {
        tag = tag == 0 ? 1 : 0
    }
}
