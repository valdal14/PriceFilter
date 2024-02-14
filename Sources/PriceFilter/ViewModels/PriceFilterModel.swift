//
//  PriceFilterModel.swift
//
//  Created by Valerio D'ALESSIO on 13/2/24.
//

import Foundation

public class PriceFilterModel: ObservableObject {
	private static let LOCALISED_TITLE_KEY = "PRICE"
	
	public let title: String
	public var minPrice: Double
	public var maxPrice: Double
	public let currency: Currency
	public let decimalFormatter: PriceFormatter
	
	@Published private(set) public var minPriceText: String = ""
	@Published private(set) public var maxPriceText: String = ""
	
	@Published public var minRangePrice: Double = 0 {
		didSet {
			minPriceText = currency.rawValue + " " + String(format: "%.2f", minRangePrice).replacingOccurrences(of: ".", with: decimalFormatter.rawValue)
		}
	}
	@Published public var maxRangePrice: Double = 0 {
		didSet {
			maxPriceText = currency.rawValue + " " + String(format: "%.2f", maxRangePrice).replacingOccurrences(of: ".", with: decimalFormatter.rawValue)
		}
	}
	
	public init(
		title: String = PriceFilterModel.localise(),
		minPrice: Double,
		maxPrice: Double,
		currency: Currency = .euro,
		decimalFormatter: PriceFormatter = .comma
	) {
		self.title = title
		self.minPrice = minPrice
		self.maxPrice = maxPrice
		self.currency = currency
		self.decimalFormatter = decimalFormatter
		self.minRangePrice = minPrice
		self.maxRangePrice = maxPrice
	}
	
	func calculateRange() -> PriceRange {
		let min = Int(minRangePrice)
		let max = Int(maxRangePrice)
		
		return (Double(min), Double(max))
	}
	
	public static func localise() -> String {
		let table = "Localizable"
		let bundle = Bundle.module
		let value = bundle.localizedString(forKey: Self.LOCALISED_TITLE_KEY, value: nil, table: table)
		if value == Self.LOCALISED_TITLE_KEY {
			return "Price"
		}
		return value
	}
}

extension PriceFilterModel {
	static let mock: PriceFilterModel = .init(
		title: "Price",
		minPrice: 14.89,
		maxPrice: 84.20,
		currency: .euro,
		decimalFormatter: .comma
	)
}
