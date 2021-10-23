//
//  ContentView.swift
//  Kadai7
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AddtionOrSubtructionPage(calculation: +, backgroundColor: .red)
                .tabItem { Text("Item 1") }
            AddtionOrSubtructionPage(calculation: -, backgroundColor: .green)
                .tabItem { Text("Item 2") }
        }
    }
}

struct AddtionOrSubtructionPage: View {
    private func calcTextNum(_ stringNum1: String, _ stringNum2: String, calculation: (Int, Int) -> Int) -> String {
        guard let num1 = Int(stringNum1) else { return "Label" }
        guard let num2 = Int(stringNum2) else { return "Label" }

        return String(calculation(num1, num2))
    }

    @State private var stringNum1: String = ""
    @State private var stringNum2: String = ""
    @State private var textAnsewr: String = "Label"

    let calculation: (Int, Int) -> Int
    let backgroundColor: Color

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
                .opacity(0.65)
                .onTapGesture {
                    UIApplication.shared.closeKeyboard()
                }
            VStack(spacing: 30) {
                InputNumField(stringNum: $stringNum1)
                InputNumField(stringNum: $stringNum2)
                Button(action: {
                    textAnsewr = calcTextNum(stringNum1, stringNum2, calculation: calculation)
                    UIApplication.shared.closeKeyboard()
                }, label: {
                    Text("Button")
                })
                Text(textAnsewr)
            }.padding()
        }
    }
}

struct InputNumField: View {
    @Binding var stringNum: String

    var body: some View {
        TextField("", text: Binding(
                    get: { self.stringNum },
                    set: { self.stringNum = $0.filter {"0123456789".contains($0)} }))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .frame(width: 150)
    }
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
