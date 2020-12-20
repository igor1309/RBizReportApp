//
//  ReportDocument.swift
//  RBizReportApp
//
//  Created by Igor Malyarov on 19.12.2020.
//

import SwiftUI

final class ReportDocument: ObservableObject {

    @Published var tengizReport: TengizReport

    init(tengizReport: TengizReport) {
        self.tengizReport = tengizReport
    }

    var json: Data? {
        try? JSONEncoder().encode(tengizReport)
    }

    // MARK: - Sheet Mngt

    @Published var sheetID: SheetID?

    enum SheetID: Identifiable {
        case rowEditor
        var id: Int { hashValue }
    }
}
