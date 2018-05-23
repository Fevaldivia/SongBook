//
//  GCD.swift
//  songBook
//
//  Created by Felipe Valdivia on 5/20/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
}


