# PriceFilter

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)
- [Contributing](#contributing)

## Overview

PriceFilter: Price Range Selection View for SwiftUI

## Features

* Displays a title, min & max price values, and two sliders for selecting the desired range.
* Automatically formats price values with currency and decimal formatting.
* Updates price range dynamically as sliders are moved.
* Shows an "Apply Filter" button when the range is changed.
* Provides customisation options for various visual aspects.

## Requirements

- Xcode 15.0+
- Swift 5.5+

## Usage

1. Add the PriceFilter package to your project using Swift Package Manager.
2. Import the `PriceFilter` module in your SwiftUI views.
3. Use the `PriceFilter` view with desired configurations.

**Example:**

```swift
import PriceFilter
import SwiftUI

struct ContentView: View {
    var body: some View {
		ZStack {
			Color.gray.opacity(0.4)
				.ignoresSafeArea()
			PriceFilter(
				viewModel: .init(minPrice: 14, maxPrice: 123),
				font: .headline,
				fontWeight: .regular,
				textColor: .black,
				refreshIconColor: .green,
				containerHeight: 140,
				containerColor: .white,
				baseBarColor: .gray.opacity(0.2),
				rangeBarColor: .black,
				leftSliderColor: .black,
				rightSliderColor: .black,
				priceFont: .subheadline,
				priceColor: .black) { minPriceRange, maxPriceRange in
					print(minPriceRange)
					print(maxPriceRange)
				}
		}
    }
}

#Preview {
    ContentView()
}
```

## Contribution

Contributions to `PriceFilter` are always welcome! If you find a bug or have a feature request, please open an issue on the [GitHub repository](https://github.com/valdal14/PriceFilter.git).
