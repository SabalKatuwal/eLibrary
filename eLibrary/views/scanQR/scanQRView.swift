//
//  scanQRView.swift
//  eLibrary
//
//  Created by Sabal on 10/20/22.
//

import SwiftUI
import CodeScanner

struct scanQRView: View {
    @State private var isPresentingScanner = false
    @State var scannedResult:String = "Scanned code will appear here"
    
    var scannerSheet: some View{
        CodeScannerView(codeTypes: [.qr],
                        completion: { result in
            if case let .success(code) = result{
                self.scannedResult = code.string
                self.isPresentingScanner = false
            }
            
        })
    }
    
    
    
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
    }
}

struct scanQRView_Previews: PreviewProvider {
    static var previews: some View {
        scanQRView()
    }
}
