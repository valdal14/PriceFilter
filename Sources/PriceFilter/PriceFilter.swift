// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct PriceFilter: View {
	public typealias PriceFilterCallback = (_ minValue: Double, _ maxValue: Double, _ wasRangeChanged: Bool) async throws -> Void
	
	@AptiveFeedback private var aptiveFeedback
	
	private static let sliderSize: CGFloat = 30
	/// keep track of the price
	private static let minValue: CGFloat = 20
	private static let maxValue: CGFloat =  UIScreen.main.bounds.width - Self.sliderSize
	/// sliders default position
	@State private var leftSliderPosX: CGFloat = Self.minValue
	@State private var rightSliderPosX: CGFloat = Self.maxValue
	
	/// keep track of the previous state
	@State private var previousLeftSliderPosX: CGFloat = Self.minValue
	@State private var previousRightSliderPosX: CGFloat = Self.maxValue
	
	/// Calculate the total price range
	@State private var priceRange: Double = 0
	@State private var desiredSliderMovement: CGFloat = 0
	@State private var sliderMovementRatio: CGFloat = 0
	
	/// This property can be used to decide whether
	/// the range state has changed compared to the
	/// the init time. If the range has not change its
	/// state this property can be used to disable or
	/// enable a CTA button for instance.
	@State private var isValidRange: Bool = false
	
	/// title
	public let viewModel: PriceFilterModel
	public let font: Font
	public let fontWeight: Font.Weight
	public let textColor: Color
	/// container
	public let containerHeight: CGFloat
	public let containerColor: Color
	/// bars
	public let baseBarColor: Color
	public let rangeBarColor: Color
	/// sliders
	public let leftSliderColor: Color
	public let rightSliderColor: Color
	/// price
	public let priceFont: Font
	public let priceColor: Color
	
	/// callback closure
	let onFilterApplied: PriceFilterCallback
	
	
	public init(viewModel: PriceFilterModel,
		 font: Font,
		 fontWeight: Font.Weight,
		 textColor: Color,
		 containerHeight: CGFloat,
		 containerColor: Color,
		 baseBarColor: Color,
		 rangeBarColor: Color,
		 leftSliderColor: Color,
		 rightSliderColor: Color,
		 priceFont: Font,
		 priceColor: Color,
		 onFilterApplied: @escaping PriceFilterCallback
	) {
		self.viewModel = viewModel
		self.font = font
		self.fontWeight = fontWeight
		self.textColor = textColor
		self.containerHeight = containerHeight
		self.containerColor = containerColor
		self.baseBarColor = baseBarColor
		self.rangeBarColor = rangeBarColor
		self.leftSliderColor = leftSliderColor
		self.rightSliderColor = rightSliderColor
		self.priceFont = priceFont
		self.priceColor = priceColor
		self.onFilterApplied = onFilterApplied
	}
	
	public var body: some View {
		ContainerView(height: containerHeight, backgroundColor: containerColor) {
			VStack(alignment: .leading) {
				WidgetTitleView(
					title: viewModel.title,
					font: font,
					fontWeight: fontWeight,
					color: textColor
				)
				
				PriceView(
					minPriceText: .constant(viewModel.minPriceText),
					maxPriceText: .constant(viewModel.maxPriceText),
					font: .subheadline,
					color: .black
				)
				
				WidgetContainer {
					GeometryReader { _ in
						RectangleBarView(
							sliderOnePosX: $leftSliderPosX,
							sliderTwoPosX: $rightSliderPosX,
							baseBarColor: baseBarColor,
							rangeBarColor: rangeBarColor
						)
						SliderGripView(
							posX: $leftSliderPosX,
							oppositeSliderPosition: $rightSliderPosX,
							backgroundColor: leftSliderColor,
							direction: .right, 
							onSlideCompleted: {
								Task {
									try await executeCallback()
								}
							}
						)
						SliderGripView(
							posX: $rightSliderPosX,
							oppositeSliderPosition: $leftSliderPosX,
							backgroundColor: rightSliderColor,
							direction: .left) {
								Task {
									try await executeCallback()
								}
							}
					}
				}
			}
			.onAppear {
				priceRange = viewModel.maxPrice - viewModel.minPrice
				desiredSliderMovement = (Self.maxValue - Self.minValue)
				sliderMovementRatio = priceRange / desiredSliderMovement
			}
		}
		.onChange(of: leftSliderPosX, perform: { value in
			let movement = (value - previousLeftSliderPosX) * sliderMovementRatio
			viewModel.minRangePrice += movement
			previousLeftSliderPosX = value
			self._aptiveFeedback.sendFeeback()
			isValidRange = true
		})
		.onChange(of: rightSliderPosX, perform: { value in
			let movement = (value - previousRightSliderPosX) * sliderMovementRatio
			viewModel.maxRangePrice += movement
			previousRightSliderPosX = value
			self._aptiveFeedback.sendFeeback()
			isValidRange = true
		})
		.onChange(of: leftSliderPosX.isEqual(to: Self.minValue), perform: { _ in
			viewModel.minRangePrice = viewModel.minPrice
			canApplyFilter()
		})
		.onChange(of: rightSliderPosX.isEqual(to: Self.maxValue), perform: { _ in
			viewModel.maxRangePrice = viewModel.maxPrice
			canApplyFilter()
		})
	}
	
	// MARK: - Helpers
	private func canApplyFilter() {
		if leftSliderPosX.isEqual(to: Self.minValue) && rightSliderPosX.isEqual(to: Self.maxValue) {
			isValidRange = false
		} else {
			isValidRange = true
		}
	}
	
	private func executeCallback() async throws {
		let (min, max) = viewModel.calculateRange()
		try await onFilterApplied(min, max, isValidRange)
	}
}


// MARK: - Preview
struct PriceFilter_Previews: PreviewProvider {
	static var previews: some View {
		PriceFilter(
			viewModel: .mock,
			font: .headline,
			fontWeight: .bold,
			textColor: .black,
			containerHeight: 140,
			containerColor: .gray.opacity(0.3),
			baseBarColor: .black.opacity(0.3),
			rangeBarColor: .black,
			leftSliderColor: .black,
			rightSliderColor: .black,
			priceFont: .subheadline,
			priceColor: .black,
			onFilterApplied: ({ _,_,_ in
				/// callback closure
			})
		)
	}
}

