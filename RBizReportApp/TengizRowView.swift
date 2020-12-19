//
//  TengizRowView.swift
//  RBizReportApp
//
//  Created by Igor Malyarov on 19.12.2020.
//

import SwiftUI

struct TengizRowView: View {

    @Binding var isExpanded: Bool
    var row: TengizRow

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded, content: content, label: rowLabel)
            .font(.system(.footnote, design: .monospaced))
    }

    private func content() -> some View {
        func noteColor() -> Color {
            row.hasIssue ? Color(UIColor.systemYellow) : Color(UIColor.systemTeal)
        }

        return VStack(alignment: .leading, spacing: 2) {
            ForEach(row.economicRows, content: economicRowView)

            if !row.isAmountMatch {
                Text("Split don't match.")
                    .foregroundColor(Color(UIColor.systemRed))
            }

            if !row.note.isEmpty {
                Label(row.note, systemImage: "square.and.pencil")
                    .foregroundColor(noteColor())
                    .padding(.top, 3)
            }
        }
        .foregroundColor(.secondary)
        .padding(.leading)
        .padding(.leading)
    }

    private func economicRowView(_ economicRow: EconomicRow) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text("\(economicRow.period.month, specifier: "%02d").\(String(economicRow.period.year))")
            Text(economicRow.sense.simple)
            Spacer()
            Text("\(economicRow.amount, specifier: "%.0f")")
        }
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
            HStack {
                Text(row.rowNumber)
                Text(row.title)
                Spacer()
                Text("\(row.amount, specifier: "%.0f")")
            }
        } icon: {
            Image(systemName: icon())
                .foregroundColor(iconColor())
                .frame(width: 25, height: 25, alignment: .center)
        }
    }
}

struct TengizRowView_Testing: View {

    @State private var isExpanded = true

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TengizRowView(isExpanded: $isExpanded, row: TengizRow.sampleWithIssue())
                TengizRowView(isExpanded: $isExpanded, row: TengizRow.sampleNoIssueNoMatch())
                TengizRowView(isExpanded: $isExpanded, row: TengizRow.sampleNoIssueMatch())
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    } label: {
                        Image(systemName: isExpanded ? "chevron.right.circle" : "chevron.down.circle")
                            .frame(width: 44, height: 44, alignment: .trailing)
                    }
                }
            }
        }
    }
}

struct TengizRowView_Previews: PreviewProvider {
    static var previews: some View {
        TengizRowView_Testing()
            .accentColor(Color(UIColor.systemOrange))
            .environment(\.colorScheme, .dark)
    }
}
