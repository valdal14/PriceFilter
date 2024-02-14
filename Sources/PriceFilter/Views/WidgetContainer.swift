//
//  WidgetContainer.swift
//
//  Created by Valerio D'ALESSIO on 13/2/24.
//

import SwiftUI

struct WidgetContainer<T: View>: View {
	let contentView: T
	
	init(@ViewBuilder content: () -> T) {
		self.contentView = content()
	}
	
	var body: some View {
		ZStack {
			GeometryReader(content: { geometry in
				HStack {
					contentView
						.padding([.leading, .trailing], 4)
				}
				.padding(.top, geometry.size.height / 2)
			})
		}
	}
}

struct WidgetContainer_Previews: PreviewProvider {
	static var previews: some View {
		WidgetContainer<AnyView> {
			AnyView(Color.red)
		}
	}
}
