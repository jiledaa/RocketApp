//
//  File.swift
//  
//
//  Created by David Jilek on 13.09.2022.
//

import Foundation

extension String {

    var url: URL? {
        URL(string: self)
    }
}
