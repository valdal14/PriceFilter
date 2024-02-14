//
//  ContainerView.swift
//
//  Created by Valerio D'ALESSIO on 13/2/24.
//

import SwiftUI

struct ContainerView<T: View>: View {
	let height: CGFloat
	let backgroundColor: Color
	let contentView: T
	
	init(
		height: CGFloat,
		backgroundColor: Color = .white,
		@ViewBuilder content: () -> T
	) {
		self.height = height
		self.backgroundColor = backgroundColor
		self.contentView = content()
	}
	
	var body: some View {
		Rectangle()
			.foregroundStyle(backgroundColor)
			.frame(
				maxWidth: .infinity,
				minHeight: height,
				maxHeight: height
			)
			.overlay {
				contentView
			}
	}
}

// MARK: - Preview
struct ContainerView_Previews: PreviewProvider {
	static var previews: some View {
		ContainerView<AnyView>(height: 100, backgroundColor: .blue) {
			AnyView(
				Text("Hello World!")
					.foregroundStyle(.white)
			)
		}
	}
}
