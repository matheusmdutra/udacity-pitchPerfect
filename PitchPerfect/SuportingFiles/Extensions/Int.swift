//
//  UIInt.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 26/08/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    
    func timeStamp(intSeconds: Int)->String {
        
        let mins : Int = intSeconds/60
        let hours : Int = mins/60
        let secs : Int = intSeconds % 60
        
        let strTimestamp:String = ((hours<10) ? "0" : "") + String(hours) + ":" + ((mins<10) ? "0" : "") + String(mins) + ":" + ((secs<10) ? "0" : "") + String(secs)
        
        return strTimestamp
    }
}
