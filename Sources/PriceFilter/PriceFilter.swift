// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct PriceFilter: View {
	public typealias PriceFilterCallback = (_ minValue: Double, _ maxValue: Double, _ wasMoved: Bool) async throws -> Void
	
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
	
	/// title
	@StateObject public var viewModel: PriceFilterModel
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
	public let ringColor: Color
	/// price
	public let priceFont: Font
	public let priceColor: Color
	
	/// callback closure
	let onFilterApplied: PriceFilterCallback
	
	
	public init(viewModel: StateObject<PriceFilterModel>,
		 font: Font,
		 fontWeight: Font.Weight,
		 textColor: Color,
		 containerHeight: CGFloat,
		 containerColor: Color,
		 baseBarColor: Color,
		 rangeBarColor: Color,
		 leftSliderColor: Color,
		 rightSliderColor: Color,
		 ringColor: Color,
		 priceFont: Font,
		 priceColor: Color,
		 onFilterApplied: @escaping PriceFilterCallback
	) {
		self._viewModel = viewModel
		self.font = font
		self.fontWeight = fontWeight
		self.textColor = textColor
		self.containerHeight = containerHeight
		self.containerColor = containerColor
		self.baseBarColor = baseBarColor
		self.rangeBarColor = rangeBarColor
		self.leftSliderColor = leftSliderColor
		self.rightSliderColor = rightSliderColor
		self.ringColor = ringColor
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
							ringColor: ringColor,
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
							ringColor: ringColor,
							direction: .left,
							onSlideCompleted: {
								Task {
									try await executeCallback()
								}
							}
						)
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
			moveSlider(direction: .left, value: value)
		})
		.onChange(of: rightSliderPosX, perform: { value in
			moveSlider(direction: .right, value: value)
		})
	}
	
	// MARK: - Helpers
	private func executeCallback() async throws {
		let (min, max) = viewModel.calculateRange()
		try await onFilterApplied(min, max, viewModel.wasPriceSliderRangeMoved)
	}
	
	/// Moves the slider in the specified direction.
	///
	/// - Parameters:
	///   - direction: The direction in which to move the slider. It can be either `.left` or `.right`.
	///   - value: The new position value of the slider.
	///
	/// This function updates the slider position based on the given direction and value. If the slider
	/// reaches the minimum or maximum price limit, it stops at that limit.
	private func moveSlider(direction: Direction, value: CGFloat) {
		switch direction {
		case .left:
			let movement = (value - previousLeftSliderPosX) * sliderMovementRatio
			viewModel.minRangePrice += movement
			if viewModel.minRangePrice <= viewModel.minPrice {
				viewModel.minRangePrice = viewModel.minPrice
			}
			previousLeftSliderPosX = value
		case .right:
			let movement = (value - previousRightSliderPosX) * sliderMovementRatio
			viewModel.maxRangePrice += movement
			if viewModel.maxRangePrice >= viewModel.maxPrice {
				viewModel.maxRangePrice = viewModel.maxPrice
			}
			previousRightSliderPosX = value
		}
	}
}


// MARK: - Preview
struct PriceFilter_Previews: PreviewProvider {
	static var previews: some View {
		PriceFilter(
			viewModel: StateObject(wrappedValue: .mock),
			font: .headline,
			fontWeight: .bold,
			textColor: .black,
			containerHeight: 140,
			containerColor: .gray.opacity(0.3),
			baseBarColor: .black.opacity(0.3),
			rangeBarColor: .black,
			leftSliderColor: .black,
			rightSliderColor: .black, 
			ringColor: .white,
			priceFont: .subheadline,
			priceColor: .black,
			onFilterApplied: ({ _, _, _ in
				/// callback closure
			})
		)
	}
}

