//
//  FinRowView.swift
//  RBizReportApp
//
//  Created by Igor Malyarov on 20.12.2020.
//

import SwiftUI

struct FinRowView: View {
    let title: String
    let amount: Double
    var percentage : Bool = false

    var specifier: String {
        percentage ? "%.0f%%" : "%.2f"
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
            Spacer()
            Text("\(amount, specifier: specifier)")
        }
    }
}

