//
//  ContentView.swift
//  RBizReportApp
//
//  Created by Igor Malyarov on 19.12.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TengizReportView(document: ReportDocument(tengizReport: TengizReport.sample()))
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
