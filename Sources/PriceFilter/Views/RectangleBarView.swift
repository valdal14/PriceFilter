//
//  SwiftUIView.swift
//  
//
//  Created by Valerio D'ALESSIO on 13/2/24.
//

import SwiftUI

struct RectangleBarView: View {
	@Binding var sliderOnePosX: CGFloat
	@Binding var sliderTwoPosX: CGFloat
	let baseBarColor: Color
	let rangeBarColor: Color
	
	private static let posY: CGFloat = 2
	
    var body: some View {
		Rectangle()
			.foregroundStyle(baseBarColor)
			.frame(
				maxWidth: .infinity,
				minHeight: 5,
				maxHeight: 5
			)
			.padding([.leading, .trailing])
			.overlay {
				Rectangle()
					.foregroundStyle(rangeBarColor)
					.frame(
						maxWidth: (sliderTwoPosX - sliderOnePosX),
						minHeight: 5,
						maxHeight: 5
					)
					.position(
						x: (sliderTwoPosX + sliderOnePosX) / Self.posY,
						y: Self.posY
					)
			}
    }
}

// MARK: - Preview
struct RectangleBarView_Previews: PreviewProvider {
	static var previews: some View {
		RectangleBarView(
			sliderOnePosX: .constant(100),
			sliderTwoPosX: .constant(300),
			baseBarColor: .gray.opacity(0.1),
			rangeBarColor: .black
		)
	}
}
