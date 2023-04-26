//
//  GlobalsFunctions.swift
//  demoFireBase
//
//  Created by Mohan K on 11/04/23.
//

import Foundation

func delay(time: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        closure()
    }
}

func DLog(_ items: Any?..., function: String = #function, file: String = #file, line: Int = #line) {
    if Application.debug {
        let url = NSURL(fileURLWithPath: file)
    }
    
}

struct Application {
     static let debug = true
    static let isInDevlopment = true
}
