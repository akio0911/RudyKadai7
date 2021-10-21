//
//  ContentView.swift
//  Kadai7
//

import SwiftUI

struct ContentView: View {
    @State var addition: OperatorType = .addition
    @State var subtraction: OperatorType = .subtraction

    var body: some View {
        TabView {
            AddtionOrSubtructionPage(operatorType: $addition)
                .tabItem { Text("Item 1") }
            AddtionOrSubtructionPage(operatorType: $subtraction)
                .tabItem { Text("Item 2") }
        }
    }
}

enum OperatorType {
    case addition
    case subtraction

    func calcTextNum(type: OperatorType, _ stringNum1: String, _ stringNum2: String) -> String {
        guard let num1 = Int(stringNum1) else { return "Label" }
        guard let num2 = Int(stringNum2) else { return "Label" }

        switch type {
        case.addition:
            return String(num1 + num2)
        case.subtraction:
            return String(num1 - num2)
        }
    }

    func color() -> Color {
        switch self {
        case .addition:
            return Color.red
        case .subtraction:
            return Color.green
        }
    }
}

struct AddtionOrSubtructionPage: View {
    @State private var stringNum1: String = ""
    @State private var stringNum2: String = ""
    @State private var textAnsewr: String = "Label"
    @Binding var operatorType: OperatorType

    var body: some View {
        ZStack {
            operatorType.color()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.65)
                .onTapGesture {
                    UIApplication.shared.closeKeyboard()
                }
            VStack(spacing: 30) {
                InputNumField(stringNum: $stringNum1)
                InputNumField(stringNum: $stringNum2)
                Button(action: {
                    textAnsewr = operatorType.calcTextNum(type: operatorType, stringNum1, stringNum2)
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
