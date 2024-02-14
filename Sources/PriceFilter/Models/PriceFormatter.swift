//
//  PriceFormatter.swift
//
//  Created by Valerio D'ALESSIO on 14/2/24.
//

import Foundation

public typealias PriceRange = (min: Double, max: Double)

public enum PriceFormatter: String {
	case dot = "."
	case comma = ","
}
