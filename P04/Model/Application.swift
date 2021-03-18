//
//  App.swift
//  P04
//
//  Created by Guillaume Donzeau on 06/03/2021.
//

import Foundation

class Application {
    
    var state:State = .vertical
    
    
    enum State {
        case horizontal, vertical
    }
}
var application = Application()


