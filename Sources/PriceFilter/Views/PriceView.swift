//
//  PriceView.swift
//
//  Created by Valerio D'ALESSIO on 13/2/24.
//

import SwiftUI

struct PriceView: View {
	@Binding var minPriceText: String
	@Binding var maxPriceText: String
	let font: Font
	let color: Color
	
    var body: some View {
		HStack {
			Text(minPriceText)
			Spacer()
			Text(maxPriceText)
		}
		.font(font)
		.foregroundStyle(color)
		.padding([.leading, .trailing], 10)
    }
}

// MARK: - Preview
struct PriceView_Previews: PreviewProvider {
	static var previews: some View {
		PriceView(
			minPriceText: .constant("€ 14.14"),
			maxPriceText: .constant("€ 38.90"),
			font: .subheadline,
			color: .black
		)
	}
}
