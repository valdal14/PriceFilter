//
//  PriceFilterSampleView.swift
//
//
//  Created by Valerio D'ALESSIO on 9/6/24.
//

import SwiftUI

struct PriceFilterSampleView: View {
	@State private var minPrice: Double = 0
	@State private var maxPrice: Double = 0
	
    var body: some View {
		ZStack {
			Color.gray.opacity(0.4).ignoresSafeArea()
			
			VStack {
				PriceFilter(
					viewModel: PriceFilterModel(
						minPrice: 14,
						maxPrice: 27,
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
					newRange: (16, 18)) { minValue, maxValue, wasMoved in
						if wasMoved {
							minPrice = minValue
							maxPrice = maxValue
						}
					}
				
				PriceFilter(
					viewModel: PriceFilterModel(
						minPrice: 14,
						maxPrice: 27,
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
					newRange: (16, 18)) { minValue, maxValue, wasMoved in
						if wasMoved {
							minPrice = minValue
							maxPrice = maxValue
						}
					}
				
				PriceFilter(
					viewModel: PriceFilterModel(
						minPrice: 14,
						maxPrice: 27,
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
					newRange: (16, 18)) { minValue, maxValue, wasMoved in
						if wasMoved {
							minPrice = minValue
							maxPrice = maxValue
						}
					}
				
				PriceFilter(
					viewModel: PriceFilterModel(
						minPrice: 14,
						maxPrice: 27,
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
					newRange: (16, 18)) { minValue, maxValue, wasMoved in
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
