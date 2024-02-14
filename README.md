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
struct MyView: View {
    @State private var minPrice: Double = 20
    @State private var maxPrice: Double = 100

    var body: some View {
        PriceFilter(
            viewModel: PriceFilterModel(minPrice: minPrice, maxPrice: maxPrice),
            font: .system(size: 16),
            fontWeight: .semibold,
            textColor: .black,
            refreshIconColor: .gray,
            containerHeight: 120,
            containerColor: .white,
            baseBarColor: .gray.opacity(0.2),
            rangeBarColor: .blue,
            leftSliderColor: .blue,
            rightSliderColor: .blue,
            priceFont: .system(size: 14),
            priceColor: .black,
            onFilterApplied: { minValue, maxValue in
                // Handle filter application here
                print("Min price: \(minValue), Max price: \(maxValue)")
            }
        )
    }
}
```

## Contribution

Contributions to `PriceFilter` are always welcome! If you find a bug or have a feature request, please open an issue on the [GitHub repository](https://github.com/valdal14/PriceFilter.git).
