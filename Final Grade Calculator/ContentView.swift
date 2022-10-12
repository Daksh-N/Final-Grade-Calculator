//
//  ContentView.swift
//  Final Grade Calculator
//
//  Created by Daksh Nakra on 9/23/22.
//

import SwiftUI

struct ContentView: View {
    @State private var currentGradeTextField = ""
    @State private var finalWeightTextField = ""
    @State private var desiredGrade = 0.0
    @State private var requiredGrade = 0.0
    var body: some View {
        VStack {
            Text("Final Grade Calculator")
                .font(.title)
                .fontWeight(.bold)
            TextField("Current Semester Grade (%)", text: $currentGradeTextField)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 30, alignment: .center)
                .font(.body)
            TextField("Final Weight On Grade (%)", text: $finalWeightTextField)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 30, alignment: .center)
                .font(.body)
            Picker("Desired Semester Grade", selection: $desiredGrade) {
                Group {
                    Text("A+ (97%-100%)").tag(97.0)
                    Text("A (93%-97%)").tag(93.0)
                    Text("A- (90%-93%)").tag(90.0)
                    Text("B+ (87%-90%)").tag(87.0)
                    Text("B (83%-87%)").tag(83.0)
                    Text("B- (80%-83%)").tag(80.0)
                }
                Group
                {
                    Text("C+ (77%-80%)").tag(77.0)
                    Text("C (73%-77%)").tag(73.0)
                    Text("C- (70%-73%)").tag(70.0)
                    Text("D+ (67%-70%)").tag(67.0)
                    Text("D (63%-67%)").tag(63.0)
                    Text("D- (60%-63%)").tag(60.0)
                    Text("F (0%-60%)").tag(0.0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            Text("Required Grade On Final:")
                .font(.headline)
                .fontWeight(.none)
            Text(String(format: "%.2f", requiredGrade) + "%")
                .font(.title)
                .fontWeight(.bold)
        }
        .onChange(of: desiredGrade, perform: {newValue in calculateGrade()})
        .background(requiredGrade > 100 ? Color.red : Color.green.opacity(requiredGrade > 0 ? 1.0 : 0.0))
    }
    func calculateGrade() {
        if let currentGrade = Double(currentGradeTextField) {
            if let finalWeight = Double(finalWeightTextField) {
                if finalWeight < 100 && finalWeight > 0 {
                    let finalPercentage = finalWeight / 100.0
                    requiredGrade = max(0.0,(desiredGrade - (currentGrade * (1.0 - finalPercentage))) / finalPercentage)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
