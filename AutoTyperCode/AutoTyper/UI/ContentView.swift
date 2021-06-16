//
//  ContentView.swift
//  AutoTyper
//
//  Created by 李挺 on 2021/2/13.
//

import SwiftUI

struct ContentView: View {
    @State var seed: String = ""
    @State var generation: String = ""
    var body: some View {
        
        VStack {
            TextField("Seed Text", text: $seed)
            Button("Generate with GPT"){
                self.generate()
            }
            Text("\(generation)")
        }
        .padding()
        
    }
    func generate() {
        let gpt = GPT2(strategy: .topK(5))
        DispatchQueue.global().async {
            gpt.generate(text: seed) {
                (text, _)->Void in
                DispatchQueue.main.async {
                    self.generation = text
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
