//
//  WidgetTitleView.swift
//
//  Created by Valerio D'ALESSIO on 13/2/24.
//

import SwiftUI

struct WidgetTitleView: View {
	let title: String
	let font: Font
	let fontWeight: Font.Weight
	let color: Color
	
    var body: some View {
		HStack {
			Text(title)
				.font(font)
				.fontWeight(fontWeight)
				.foregroundStyle(color)
				.padding()
			Spacer()
		}
        
    }
}

// MARK: - Preview
struct WidgetTitleView_Previews: PreviewProvider {
	static var previews: some View {
		WidgetTitleView(
			title: "Price",
			font: .headline,
			fontWeight: .bold,
			color: .black
		)
	}
}
