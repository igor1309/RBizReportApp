//
//  TengizRowView.swift
//  RBizReportApp
//
//  Created by Igor Malyarov on 19.12.2020.
//

import SwiftUI

struct TengizRowView: View {

    @EnvironmentObject private var document: ReportDocument

    //@Binding var isExpanded: Bool
    @State private var isExpanded: Bool = false
    var row: TengizRow

    @State private var showingRowDetail = false

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded, content: content, label: rowLabel)
    }

    private func content() -> some View {
        func noteColor() -> Color {
            row.hasIssue ? Color(UIColor.systemYellow) : Color(UIColor.systemTeal)
        }

        func editButton() -> some View {
            Button("EDIT") {
                Ory.withHapticsAndAnimation {
                    document.sheetID = .rowEditor
                }
            }
            .padding(3)
            .padding(.horizontal, 5)
            .foregroundColor(Color(UIColor.systemOrange))
            .font(.caption2)
            .background(
                Capsule()
                    .fill(Color(UIColor.tertiarySystemBackground))
            )
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing)
            .padding(.top, 2)
        }

        return VStack(alignment: .leading, spacing: 2) {
            ForEach(row.economicRows, content: economicRowView)

            if !row.note.isEmpty {
                Label(row.note, systemImage: "square.and.pencil")
                    .foregroundColor(noteColor())
                    .padding(.top, 3)
            }

            HStack {
                if !row.isAmountMatch {
                    Text("Split don't match.")
                        .foregroundColor(Color(UIColor.systemRed))
                }
                Spacer()
                editButton()
            }
        }
        .foregroundColor(.secondary)
    }

    private func economicRowView(_ economicRow: EconomicRow) -> some View {
        let title = "\(String(format: "%02d", economicRow.period.month)).\(String(economicRow.period.year))"

        return FinRowView(
            title: "\(title) \(economicRow.sense.simple)",
            amount: economicRow.amount
        )
        .padding(.trailing)
    }

    private func rowLabel() -> some View {
        func icon() -> String {
            switch (row.hasIssue, row.isAmountMatch) {
                case (true, _):
                    return "exclamationmark.triangle.fill"
                case (false, false):
                    return "rectangle.and.arrow.up.right.and.arrow.down.left.slash"
                case (false, true):
                    return "checkmark.circle"
            }
        }

        func iconColor() -> Color {
            switch (row.hasIssue, row.isAmountMatch) {
                case (true, _):       return Color(UIColor.systemYellow)
                case (false, false):  return Color(UIColor.systemRed)
                case (false, true):   return Color.secondary //(UIColor.systemGreen).opacity(0.7)
            }
        }

        return Label {
            FinRowView(title: "\(row.rowNumber) \(row.title)", amount: row.amount)
        } icon: {
            Image(systemName: icon())
                .foregroundColor(iconColor())
                .frame(width: 25, height: 25, alignment: .center)
        }
    }
}

struct TengizRowView_Testing: View {

    // @State private var isExpanded = true

    var body: some View {
        NavigationView {
            List {
                TengizRowView(row: TengizRow.sampleWithIssue())
                TengizRowView(row: TengizRow.sampleNoIssueNoMatch())
                TengizRowView(row: TengizRow.sampleNoIssueMatch())
            }
//            .toolbar {
//                ToolbarItem(placement: .primaryAction) {
//                    Button {
//                        withAnimation {
//                            isExpanded.toggle()
//                        }
//                    } label: {
//                        Image(systemName: isExpanded ? "chevron.right.circle" : "chevron.down.circle")
//                            .frame(width: 44, height: 44, alignment: .trailing)
//                    }
//                }
//            }
        }
    }
}

struct TengizRowView_Previews: PreviewProvider {
    static var previews: some View {
        TengizRowView_Testing()
            .accentColor(Color(UIColor.systemOrange))
            .environmentObject(ReportDocument(tengizReport: TengizReport.sample()))
            .environment(\.colorScheme, .dark)
    }
}
