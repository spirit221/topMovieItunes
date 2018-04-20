//
//  Connectivity.swift
//  testPod
//
//  Created by Sergey Gusev on 04.04.2018.
//  Copyright © 2018 Sergey Gusev. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
