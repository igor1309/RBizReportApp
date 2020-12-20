//
//  TengizReportView.swift
//  RBizReportApp
//
//  Created by Igor Malyarov on 20.12.2020.
//

import SwiftUI

struct TengizReportView: View {

    @ObservedObject var document: ReportDocument

    @State private var showingDatePicker = false
    @State private var showingNote = false

    var body: some View {
        List {
            reportPeriodAndDateView()

            VStack(alignment: .leading, spacing: 3) {
                FinRowView(title: "Revenue", amount: document.tengizReport.revenue)
                FinRowView(title: "Daily Average", amount: document.tengizReport.dailyAverageRevenue)
                FinRowView(title: "Total Expenses", amount: document.tengizReport.totalExpenses)

                if !document.tengizReport.isTotalExpensesMatch {
                    VStack(alignment: .leading, spacing: 1) {
                        FinRowView(title: "Calculated", amount: document.tengizReport.calculatedTotalExpenses)
                        FinRowView(title: "Total Expenses error".uppercased(), amount: document.tengizReport.totalExpensesDelta)
                    }
                    .foregroundColor(Color(UIColor.systemRed))
                }

                Divider()
                FinRowView(title: "Balance", amount: document.tengizReport.balance)
                    .if(document.tengizReport.balance < 0) { $0.foregroundColor(Color(UIColor.systemRed))
                    }
                FinRowView(title: "Running Ballance", amount: document.tengizReport.runningBallance)
                    .if(document.tengizReport.runningBallance < 0) { $0.foregroundColor(Color(UIColor.systemRed))
                    }
            }
            .padding(.trailing)

            ForEach(document.tengizReport.sections, content: sectionView)
        }
        .font(.system(.footnote, design: .monospaced))
        .navigationTitle(document.tengizReport.company)
        .sheet(item: $document.sheetID, content: sheetView)
        .environmentObject(document)
    }

    // MARK: - Sheets

    @ViewBuilder
    private func sheetView(sheetID: ReportDocument.SheetID) -> some View {
        switch sheetID {
            case .rowEditor: Text("TBD")
        }
    }

    // MARK: - Views

    private func sectionView(section: TengizSection) -> some View {
        DisclosureGroup {
            if !section.note.isEmpty {
                Label(section.note, systemImage: "square.and.pencil")
                    .foregroundColor(.secondary)
            }

            ForEach(section.rows, content: TengizRowView.init)
        } label: {
            sectionLabel(section: section)
        }

    }

    private func sectionLabel(section: TengizSection) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            FinRowView(title: section.name, amount: section.amount)
                // .font(.system(.subheadline, design: .monospaced))

            Group {
                if !section.isAmountMatch {
                    VStack(alignment: .leading, spacing: 1) {
                        FinRowView(title: "Calculated", amount: section.amountCalculated)
                        FinRowView(title: "Amount error".uppercased(), amount: section.amountDelta)
                    }
                    .foregroundColor(Color(UIColor.systemRed))
                }

                if let target = section.target {
                    VStack(alignment: .leading, spacing: 1) {
                        FinRowView(title: "Target", amount: target * 100, percentage: true)

                        if document.tengizReport.totalExpenses > 0 {
                            FinRowView(
                                title: "Reality",
                                amount: section.amount / document.tengizReport.totalExpenses * 100,
                                percentage: true
                            )
                        }
                    }
                }
            }
            .font(.system(.caption, design: .monospaced))
        }
    }

    private func reportPeriodAndDateView() -> some View {
        HStack(alignment: .firstTextBaseline) {
            Label("\(document.tengizReport.period.month, specifier: "%02d").\(String(document.tengizReport.period.year))", systemImage: "calendar") // swiftlint:disable:this line_length
                .foregroundColor(Color(UIColor.systemTeal))

            Spacer()

            Text(document.tengizReport.date, style: .date)
                .foregroundColor(.secondary)
                .font(.system(.footnote, design: .monospaced))
                .onTapGesture {
                    showingDatePicker = true
                }
                .sheet(isPresented: $showingDatePicker) {
                    VStack {
                        DatePicker("Report Date",
                                   selection: $document.tengizReport.date,
                                   displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())

                        Spacer()
                    }
                    .padding()
                }

            Button {
                withAnimation {
                    showingNote.toggle()
                }
            } label: {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(document.tengizReport.note.isEmpty ? .secondary : Color(UIColor.systemOrange))
            }
            .foregroundColor(.secondary)
            .font(.system(.subheadline, design: .monospaced))
            .lineLimit(1)
            .sheet(isPresented: $showingNote) {
                TextEditor(text: $document.tengizReport.note)
                    .padding()
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct TengizReportView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            TengizReportView(document: ReportDocument(tengizReport: TengizReport.sample()))
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)
        }
        .environment(\.colorScheme, .dark)
    }
}
