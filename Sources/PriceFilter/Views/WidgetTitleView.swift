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
	let iconColor: Color
	@Binding var isVisible: Bool
	let onTap: () -> Void
	
    var body: some View {
		HStack {
			Text(title)
				.font(font)
				.fontWeight(fontWeight)
				.foregroundStyle(color)
				.padding()
			Spacer()
			Button(action: {
				onTap()
			}, label: {
				Image(systemName: "arrow.clockwise.circle.fill")
					.resizable()
					.frame(width: 24, height: 24)
					.foregroundStyle(withAnimation(.spring, {
						isVisible ? iconColor : .gray.opacity(0.5)
					}))
					.padding(.trailing, 16)
			})
			.disabled(!isVisible)
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
			color: .black, 
			iconColor: .green,
			isVisible: .constant(false),
			onTap: {
				/// callback
			}
		)
	}
}
