//
//  SliderGripView.swift
//
//  Created by Valerio D'ALESSIO on 13/2/24.
//

import SwiftUI

struct SliderGripView: View {
	private static let gripSize: CGFloat = 30
	private static let ringSize: CGFloat = 26
	private static let minPosition: CGFloat = 20
	private static let maxPosition: CGFloat = UIScreen.main.bounds.width - Self.gripSize
	
	@Binding var posX: CGFloat
	@State private var posY: CGFloat = 0
	
	@Binding var oppositeSliderPosition: CGFloat
	private let backgroundColor: Color
	private let ringColor: Color
	private var direction: Direction
	private let sliderStyle: SliderStyle
	private let onSlideCompleted: () -> Void
	
	init(
		posX: Binding<CGFloat>,
		oppositeSliderPosition: Binding<CGFloat>,
		backgroundColor: Color = .black,
		ringColor: Color = .white,
		direction: Direction,
		sliderStyle: SliderStyle,
		onSlideCompleted: @escaping () -> Void
	) {
		self._posX = posX
		self._oppositeSliderPosition = oppositeSliderPosition
		self.backgroundColor = backgroundColor
		self.ringColor = ringColor
		self.direction = direction
		self.sliderStyle = sliderStyle
		self.onSlideCompleted = onSlideCompleted
	}
	
	var body: some View {
		setShape(style: sliderStyle)
			.position(.init(x: posX, y: posY))
			.foregroundStyle(backgroundColor)
			.frame(width: Self.gripSize, height: Self.gripSize)
			.shadow(radius: 1)
			.gesture(
				DragGesture()
					.onChanged({ value in
						onDragValueChangedPerform(with: value)
					})
					.onEnded({ value in
						onSlideCompleted()
					})
			)
			.overlay {
				HStack(spacing: 3) {
					ForEach(0..<3) { _ in
						Rectangle()
							.foregroundStyle(ringColor.opacity(0.3))
							.frame(width: 1, height: Self.ringSize - 8)
					}
				}
				.position(.init(x: posX, y: posY))
			}
	}
	
	// MARK: - Helpers
	@ViewBuilder
	func setShape(style: SliderStyle) -> some View {
		switch style {
		case .circle:
			Circle()
		case .square:
			Rectangle()
		}
	}
	
	private func onDragValueChangedPerform(with value: DragGesture.Value) {
		let proposedPosX = value.location.x
		let minX = Self.minPosition
		let maxX = Self.maxPosition
		
		let clampedPosX = max(minX, min(maxX, proposedPosX))
		
		var minAllowedPosX: CGFloat
		var maxAllowedPosX: CGFloat
		switch direction {
		case .left:
			minAllowedPosX = oppositeSliderPosition + Self.gripSize
			maxAllowedPosX = maxX
		case .right:
			minAllowedPosX = minX
			maxAllowedPosX = oppositeSliderPosition - Self.gripSize
		}
		
		posX = min(maxAllowedPosX, max(minAllowedPosX, clampedPosX))
	}
}

struct SliderGripView_Previews: PreviewProvider {
	static var previews: some View {
		SliderGripView(
			posX: .constant(-150),
			oppositeSliderPosition: .constant(380),
			direction: .right,
			sliderStyle: .square,
			onSlideCompleted: {
				/// drag gesture completed
			}
		)
	}
}
