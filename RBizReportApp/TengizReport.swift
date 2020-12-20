//
//  TengizReport.swift
//  RBizReportApp
//
//  Created by Igor Malyarov on 20.12.2020.
//

import SwiftUI

struct TengizReport: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var company: String
    var period: Period
    var revenue: Double
    var dailyAverageRevenue: Double
    var sections: [TengizSection]
    var totalExpenses: Double
    var calculatedTotalExpenses: Double {
        sections.map(\.amountCalculated).reduce(0, +)
    }
    var totalExpensesDelta: Double {
        totalExpenses - calculatedTotalExpenses
    }
    var isTotalExpensesMatch: Bool {
        totalExpenses == calculatedTotalExpenses
    }
    var balance: Double
    var runningBallance: Double
    //  FIXME: FINISH THIS: How to add runningBallance check?
    var note: String
}

struct TengizSection: Identifiable, Codable {
    var id = UUID()
    var name: String
    var rows: [TengizRow]
    var amount: Double
    var amountCalculated: Double {
        rows.map(\.amount).reduce(0,+)
    }
    var amountDelta: Double { amount - amountCalculated }
    var isAmountMatch: Bool { amount == amountCalculated }
    var target: Double?
    var note: String
}

extension TengizReport {
    static func sample() -> TengizReport {
        let components = DateComponents(year: 2020, month: 11, day: 16)
        let calendar = Calendar.current
        let date = calendar.date(from: components)!

        let company = "Саперави Аминьевка"
        let period = Period(month: 10, year: 2020)

        let mainExpenses = [
            TengizRow(
                rowNumber: "1",
                title: "Аренда торгового помещения",
                amount: 200_000 + 400_000,
                economicRows: [],
                hasIssue: false,
                note: " 200.000 (за август) +400.000 (за сентябрь)"
            ),
            TengizRow(
                rowNumber: "5",
                title: "Аренда головного офиса",
                amount: 11_500,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "6",
                title: "Аренда головного склада",
                amount: 8_000,
                economicRows: [],
                hasIssue: false,
                note: ""
            )
        ]
        #warning("intensional error above!! it's 7_000")

        let salary = [
            TengizRow(
                rowNumber: "1",
                title: "ФОТ",
                amount: 1_147_085,
                economicRows: [],
                hasIssue: false,
                note: " 1.147.085( за вторую часть сентября и первую  часть октября)"
            ),
            TengizRow(
                rowNumber: "2",
                title: "ФОТ Бренд, логистика, бухгалтерия",
                amount: 99_000,
                economicRows: [],
                hasIssue: false,
                note: ""
            )
        ]

        let otherExpenses = [
            TengizRow(
                rowNumber: "1",
                title: "Налоговые платежи ",
                amount: 35_311,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "2",
                title: "Банковское обслуживание",
                amount: 6_279,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "3",
                title: "Юридическое сопровождение",
                amount: 40_000,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "4",
                title: "Банковская комиссия 1.6% за эквайринг",
                amount: 31_587,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "6",
                title: "Обслуживание кассовой программы Айко",
                amount: 8_435,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "8",
                title: "Обслуживание мобильного приложения",
                amount: 9_200,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "9",
                title: "Реклама и IT поддержка",
                amount: 85_000,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "14",
                title: "Вышивка логотипа на одежде",
                amount: 2_836,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "15",
                title: "Аренда зарядных устройств и раций",
                amount: 10_000,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "16",
                title: "Текущие мелкие расходы ",
                amount: 5_460,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "18",
                title: "Аренда оборудования д/питьевой воды",
                amount: 5_130,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "19",
                title: "Ремонт оборудования",
                amount: 6_610,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "20",
                title: "Чистка вентиляции",
                amount: 35_000,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "21",
                title: "Обслуживание банкетов",
                amount: 5_625,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "22",
                title: "Хэдхантер (подбор пероснала)",
                amount: 4_227,
                economicRows: [],
                hasIssue: false,
                note: ""
            ),
            TengizRow(
                rowNumber: "23",
                title: "Аудит кантора (Бухуслуги)",
                amount: 60_000,
                economicRows: [],
                hasIssue: false,
                note: ""
            )
        ]

        let sections = [
            TengizSection(
                name: "Основные расходы",
                rows: mainExpenses,
                amount: 618_500,
                target: 0.2, // 20%
                note: "Примечание по основным расходам"
            ),
            TengizSection(
                name: "Зарплата",
                rows: salary,
                amount: 1_246_085,
                target: 0.2, // 20%
                note: "Примечание по блоку/разделу Зарплата"
            ),
            TengizSection(
                name: "Фактический приход товара и оплата товара",
                rows: [
                    TengizRow(
                        rowNumber: "1",
                        title: "Приход товара по накладным",
                        amount: 628_215.74,
                        economicRows: [],
                        hasIssue: false,
                        note: "907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого-628.215р 74к)"
                    )
                ],
                amount: 628_215.74,
                target: 0.25, // 25%
                note: ""
            ),
            TengizSection(
                name: "Прочие расходы",
                rows: otherExpenses,
                amount: 350_700,
                target: 0.15, // 15%
                note: ""
            ),
            TengizSection(
                name: "Расходы на доставку",
                rows: [
                    TengizRow(
                        rowNumber: "1",
                        title: "Курьеры",
                        amount: 0,
                        economicRows: [],
                        hasIssue: false,
                        note: ""
                    ),
                    TengizRow(
                        rowNumber: "2",
                        title: "Агрегаторы",
                        amount: 21_541,
                        economicRows: [],
                        hasIssue: false,
                        note: ""
                    )
                ],
                amount: 21_541,
                target: nil,
                note: ""
            )
        ]

        let note = "Минус 277.306р 74к. Переходит минус с сентября 642.997р 43к"

        return TengizReport(
            date: date,
            company: company,
            period: period,
            revenue: 2_587_735,
            dailyAverageRevenue: 83_475,
            sections: sections,
            totalExpenses: 2_865_042.74,
            balance: -277_306.74,
            runningBallance: -920_304.17,
            note: note
        )
    }
}
