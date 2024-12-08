//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by saeed shaikh on 02/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countryList = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Spain","UK","Ukraine","US"].shuffled()
    @State private var correctAns = Int.random(in: 0...2)
    
    @State private var showAlert = false
    @State private var showTitle = ""
    @State private var score = 0
    @State private var numberOfQuestion = 10
    
    func flagTapped(number: Int){
        
            numberOfQuestion -= 1
        
        
            if number == correctAns {
                showTitle = "Correct"
                score += 1
                
                if(numberOfQuestion == 0){
                    numberOfQuestion = 10
                    showTitle = "Your final Score \(score) / 10"
                    score = 0
                    showAlert = true
                    return
                }
                
                
            }else{
                showTitle = "Wrong! That’s the flag of \(countryList[correctAns])”"
                
//                if score >= 1{
//                    score -= 1
//                }
                
            }
            
        showAlert = true
        
    }
    
    func askQuestion(){
        countryList.shuffle()
        correctAns = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack{
//            LinearGradient(
//                colors: [Color.blue, Color.purple],
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.35, blue: 0.25), location: 0.3)
            ],center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            //            Color.blue
            //                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                
                VStack(spacing:15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.bold))
                        Text(countryList[correctAns])
                            .foregroundStyle(.secondary)
                            .font(.title.weight(.semibold))
                    }
                    
                    ForEach(0...2, id: \.self) { number in
                        Button{
                            flagTapped(number: number)
                        }label: {
                            Image(countryList[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 8)
                        }
                        .alert("\(showTitle)", isPresented: $showAlert) {
                            Button("OK",action: askQuestion)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial.opacity(0.85))
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
