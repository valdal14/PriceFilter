import XCTest
@testable import PriceFilter

final class PriceFilterTests: XCTestCase {
    
	func testInitSetupsTheRightValues() {
		let sut = makeSUT()
		let expectedObject: PriceFilterModel = .init(
			title: "Price",
			minPrice: 14.89,
			maxPrice: 84.20
		)
		
		XCTAssertEqual(sut.title, expectedObject.title)
		XCTAssertEqual(sut.minPrice, expectedObject.minPrice)
		XCTAssertEqual(sut.maxPrice, expectedObject.maxPrice)
	}
	
	func testInitDeliversTheRightCurrencyValue() {
		let sut = makeSUT()
		XCTAssertEqual(sut.currency.rawValue, "€")
	}
	
	func testInitGeneratesTheRightPriceStringWithCurrency() {
		let sut = makeSUT()
		XCTAssertEqual(sut.minPriceText, "€ 14,67")
		XCTAssertEqual(sut.maxPriceText, "€ 36,23")
	}
	
	func testOnMinOrMaxPriceChangesAValidPriceStringWithCurrencyIsGenerated() {
		let sut = makeSUT()
		
		sut.minRangePrice = 12.00
		sut.maxRangePrice = 30.00
		
		XCTAssertEqual(sut.minPriceText, "€ 12,00")
		XCTAssertEqual(sut.maxPriceText, "€ 30,00")
	}
	
	func testCalculateRangeReturnsTheRightMinAndMaxPrice() {
		let sut = makeSUT()
		
		sut.minRangePrice = 14.67
		sut.maxRangePrice = 36.23
		
		let (min, max) = sut.calculateRange()
		
		XCTAssertEqual(min, 14)
		XCTAssertEqual(max, 36)
	}
	
	func testInitWithDecimalFormatterValueReturnsTheRightFormattedPrice() {
		let sut = PriceFilterModel(
			title: "Price",
			minPrice: 20.45,
			maxPrice: 76.99,
			currency: .euro,
			decimalFormatter: .dot
		)
		
		sut.minRangePrice = 20.45
		sut.maxRangePrice = 76.99
		
		XCTAssertEqual(sut.minPriceText, "€ 20.45")
		XCTAssertEqual(sut.maxPriceText, "€ 76.99")
	}
	
	func testInitCurrencyChangeDeliversTheRightValue() {
		let sut = PriceFilterModel(
			title: "Price",
			minPrice: 20.45,
			maxPrice: 76.99,
			currency: .hongKongDollar,
			decimalFormatter: .comma
		)
		
		sut.minRangePrice = 20.45
		sut.maxRangePrice = 76.99
		
		XCTAssertEqual(sut.minPriceText, "HK$ 20,45")
		XCTAssertEqual(sut.maxPriceText, "HK$ 76,99")
	}
	
	func testInitSuccessfullyLocalisedWidgetTitle() {
		let sut = PriceFilterModel(minPrice: 14.00, maxPrice: 28.00)
		XCTAssertEqual(sut.title, localized("PRICE"))
	}
	
	func testWasPriceSliderRangeMovedReturnFalse() {
		let sut = PriceFilterModel(minPrice: 14.00, maxPrice: 28.00)
		XCTAssertFalse(sut.wasPriceSliderRangeMoved)
	}
	
	func testWasPriceSliderRangeMovedReturnsTrueWhenTheLeftSliderWasMoved() {
		let sut = PriceFilterModel(minPrice: 14.00, maxPrice: 28.00)
		sut.minPrice = 17.34
		XCTAssertTrue(sut.wasPriceSliderRangeMoved)
	}
	
	func testWasPriceSliderRangeMovedReturnsFalseWhenTheRightSliderWasMoved() {
		let sut = PriceFilterModel(minPrice: 14.00, maxPrice: 28.00)
		sut.maxPrice = 25.34
		XCTAssertTrue(sut.wasPriceSliderRangeMoved)
	}
	
	func testWasPriceSliderRangeMovedReturnsFalseAfterResettingTheSlidersToTheirOriginalValue() {
		let sut = PriceFilterModel(minPrice: 14.00, maxPrice: 28.00)
		sut.minPrice = 17.34
		sut.maxPrice = 25.34
		XCTAssertTrue(sut.wasPriceSliderRangeMoved, "Expected slider to be moved")
		sut.minPrice = 14.00
		sut.maxPrice = 28.00
		XCTAssertFalse(sut.wasPriceSliderRangeMoved, "Expected slider to be back to the original position")
	}
	
	// MARK: - Helpers
	func makeSUT() -> PriceFilterModel {
		return PriceFilterModel.mock
	}
	
	private func localized(_ key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
		let table = "Localizable"
		let bundle = Bundle.main
		let value = bundle.localizedString(forKey: key, value: nil, table: table)
		if value == key {
			XCTFail("Missing localised string for key: \(key) in table: \(table)", file: file, line: line)
		}
		return value
	}
}
