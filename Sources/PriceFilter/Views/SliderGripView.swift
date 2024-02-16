//
//  SliderGripView.swift
//
//  Created by Valerio D'ALESSIO on 13/2/24.
//

import SwiftUI

struct SliderGripView: View {
	private static let gripSize: CGFloat = 30
	private static let minPosition: CGFloat = 20
	private static let maxPosition: CGFloat = UIScreen.main.bounds.width - Self.gripSize
	
	@Binding var posX: CGFloat
	@State private var posY: CGFloat = 0
	
	@Binding var oppositeSliderPosition: CGFloat
	private let backgroundColor: Color
	private var direction: Direction
	private let onSlideCompleted: () -> Void
	
	init(
		posX: Binding<CGFloat>,
		oppositeSliderPosition: Binding<CGFloat>,
		backgroundColor: Color = .black,
		direction: Direction,
		onSlideCompleted: @escaping () -> Void
	) {
		self._posX = posX
		self._oppositeSliderPosition = oppositeSliderPosition
		self.backgroundColor = backgroundColor
		self.direction = direction
		self.onSlideCompleted = onSlideCompleted
	}
	
	var body: some View {
		Circle()
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
	}
	
	// MARK: - Helpers
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
			onSlideCompleted: {
				/// drag gesture completed
			}
		)
	}
}
