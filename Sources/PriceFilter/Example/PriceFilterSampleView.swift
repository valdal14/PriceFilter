//
//  PriceFilterSampleView.swift
//
//
//  Created by Valerio D'ALESSIO on 9/6/24.
//

import SwiftUI

struct PriceFilterSampleView: View {
	@State private var minPrice: Double = 14
	@State private var maxPrice: Double = 78
	/// newRangeMin & newRangeMax represents an example of values you may get
	/// in a callback if applying the price filters gets back from your backend
	/// the new price range after applying the filter
	@State private var newRangeMin: Int = 0
	@State private var newRangeMax: Int = 0
	
    var body: some View {
		ZStack {
			Color.gray.opacity(0.4).ignoresSafeArea()
			
			VStack {
				PriceFilter(
					viewModel: PriceFilterModel(
						minPrice: minPrice,
						maxPrice: maxPrice,
						currency: .euro,
						decimalFormatter: .comma
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
				
				PriceFilter(
					viewModel: PriceFilterModel(
						minPrice: minPrice,
						maxPrice: maxPrice,
						currency: .czechKoruna,
						decimalFormatter: .comma
					),
					sliderStyle: .circle,
					font: .title2,
					fontWeight: .heavy,
					textColor: .black,
					containerHeight: 170,
					containerColor: .white,
					baseBarColor: .gray.opacity(0.2),
					rangeBarColor: .black,
					leftSliderColor: .black,
					rightSliderColor: .black,
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
				
				PriceFilter(
					viewModel: PriceFilterModel(
						minPrice: minPrice,
						maxPrice: maxPrice,
						currency: .yenOrYuan,
						decimalFormatter: .dot
					),
					sliderStyle: .circle,
					font: .title2,
					fontWeight: .heavy,
					textColor: .purple,
					containerHeight: 170,
					containerColor: .white,
					baseBarColor: .purple.opacity(0.2),
					rangeBarColor: .purple,
					leftSliderColor: .pink,
					rightSliderColor: .pink,
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
				
				PriceFilter(
					viewModel: PriceFilterModel(
						minPrice: minPrice,
						maxPrice: maxPrice,
						currency: .indianRupee,
						decimalFormatter: .comma
					),
					sliderStyle: .circle,
					font: .title2,
					fontWeight: .heavy,
					textColor: .brown,
					containerHeight: 170,
					containerColor: .orange.opacity(0.1),
					baseBarColor: .brown.opacity(0.4),
					rangeBarColor: .orange,
					leftSliderColor: .orange,
					rightSliderColor: .green,
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
				
				Spacer()
				
				Button(action: {
					print(minPrice)
					print(maxPrice)
				}, label: {
					RoundedRectangle(cornerRadius: 32)
						.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
						.foregroundStyle(.black)
						.overlay {
							Text("Apply Price Filter")
								.font(.headline)
								.foregroundStyle(.white)
						}
				})
				.padding()
			}
		}
    }
}

#Preview {
	PriceFilterSampleView()
}
