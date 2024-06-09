# PriceFilter

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)
- [Contributing](#contributing)

## Overview

PriceFilter: Price Range Selection View for SwiftUI

![Start](https://github.com/valdal14/PriceFilter/blob/develop/Samples/priceFilter.png?raw=true "PriceFilter example")

## Features

* Displays a title, min & max price values, and two sliders for selecting the desired range.
* Automatically formats price values with currency and decimal formatting.
* Updates price range dynamically as sliders are moved.
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
	@State private var minPrice: Double = 0
	@State private var maxPrice: Double = 0
	@State private var newRangeMin: Int = 0
	@State private var newRangeMax: Int = 0
	
    var body: some View {
		PriceFilter(
			viewModel: PriceFilterModel(
			minPrice: minPrice,
			maxPrice: maxPrice
		),
			sliderStyle: .square,
			font: .title2,
			fontWeight: .heavy,
			textColor: .blue,
			containerHeight: 170,
			containerColor: .cyan.opacity(0.2),
			baseBarColor: .gray.opacity(0.2),
			rangeBarColor: .blue,
			leftSliderColor: .cyan,
			rightSliderColor: .cyan,
			ringColor: .white,
			priceFont: .subheadline,
			priceColor: .black,
			wasRestored: .constant(false),
			newRange: (newRangeMin, newRangeMax)) { minValue, maxValue, wasMoved in
		if wasMoved {
			minPrice = minValue
			maxPrice = maxValue
			}
		}
    }
}
```

**Note:**

* If you want to specify a currency and the decimal portion is rendered in the `PriceFilter` you can use the extra arguments like so: 

```swift
PriceFilterModel = .init(
	title: "Price",
	minPrice: 14.89,
	maxPrice: 84.20,
	currency: .euro,
	decimalFormatter: .comma
)
```


## Contribution

Contributions to `PriceFilter` are always welcome! If you find a bug or have a feature request, please open an issue on the [GitHub repository](https://github.com/valdal14/PriceFilter.git).
