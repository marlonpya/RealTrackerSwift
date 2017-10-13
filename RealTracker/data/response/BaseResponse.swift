//
//  BaseResponse.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 9/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import UIKit

class BaseResponse : Codable {
    var message: String!
    var status: Bool!
    
    fileprivate enum Key: CodingKey {
        case message, status, result
    }

//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Key.self)
//
//        self.message = try container.decode(String.self, forKey: .message)
//        self.status = try container.decode(Bool.self, forKey: .status)
//        self.result = try container.decode(T.self, forKey: .result)
//    }
//
//
//    func encode(to encoder: Encoder) throws {
//    }
}
