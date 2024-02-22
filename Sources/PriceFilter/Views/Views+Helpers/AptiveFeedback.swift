//
//  AptiveFeedback.swift
//
//  Created by Valerio D'ALESSIO on 22/2/24.
//

import CoreHaptics
import SwiftUI

@propertyWrapper
struct AptiveFeedback: DynamicProperty {
	@State var feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
	var wrappedValue: UIImpactFeedbackGenerator {
		get { feedbackGenerator }
	}
	
	func sendFeeback() {
		self.feedbackGenerator.impactOccurred()
	}
}
