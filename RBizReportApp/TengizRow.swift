//
//  TengizRow.swift
//  RBizReportApp
//
//  Created by Igor Malyarov on 19.12.2020.
//

import SwiftUI

struct Period: Codable {
    let month: Int
    let year: Int
}

struct Sense: Codable {
    var simple = "Economic sense"
}

struct EconomicRow: Identifiable, Codable {
    var id = UUID()

    var sense: Sense
    var amount: Double
    var period: Period
}

struct TengizRow: Identifiable, Codable {
    var id = UUID()

    var rowNumber: String
    var title: String
    var amount: Double

    var economicRows: [EconomicRow]

    var hasIssue: Bool
    var note: String

    var isAmountMatch: Bool {
        amount == economicRows.map(\.amount).reduce(0, +)
    }

}

// MARK: - TengizRow samples

extension TengizRow {
    static func sampleWithIssue() -> TengizRow {
        let period = Period(month: 10, year: 2020)
        let rowNumber = "1.1a"
        let title = "Выручка"
        let amount: Double = 1_234_567
        let economicRows: [EconomicRow] = [
            EconomicRow(
                sense: Sense(),
                amount: 1_100_000,
                period: period
            )
        ]

        return TengizRow(
            rowNumber: rowNumber,
            title: title,
            amount: amount,
            economicRows: economicRows,
            hasIssue: true,
            note: "Some Note goes here."
        )
    }

    static func sampleNoIssueMatch() -> TengizRow {
        let period = Period(month: 10, year: 2020)
        let rowNumber = "1.1a"
        let title = "Выручка"
        let amount: Double = 1_234_567
        let economicRows: [EconomicRow] = [
            EconomicRow(
                sense: Sense(),
                amount: 1_100_000,
                period: period
            ),
            EconomicRow(
                sense: Sense(),
                amount: 123_456,
                period: Period(month: 9, year: 2020)
            ),
            EconomicRow(
                sense: Sense(),
                amount: 11_111,
                period: Period(month: 8, year: 2020)
            )
        ]

        return TengizRow(
            rowNumber: rowNumber,
            title: title,
            amount: amount,
            economicRows: economicRows,
            hasIssue: false,
            note: ""
        )
    }

    static func sampleNoIssueNoMatch() -> TengizRow {
        let period = Period(month: 10, year: 2020)
        let rowNumber = "1.1a"
        let title = "Выручка от реализации"
        let amount: Double = 1_234_567
        let economicRows: [EconomicRow] = [
            EconomicRow(
                sense: Sense(),
                amount: 1_100_000,
                period: period
            ),
            EconomicRow(
                sense: Sense(),
                amount: 123_456,
                period: Period(month: 9, year: 2020)
            )
        ]

        return TengizRow(
            rowNumber: rowNumber,
            title: title,
            amount: amount,
            economicRows: economicRows,
            hasIssue: false,
            note: "Some Note goes here."
        )
    }

}
