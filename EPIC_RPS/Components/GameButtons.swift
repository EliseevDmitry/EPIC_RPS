//
//  GameButtons.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 11.06.2024.
//

import SwiftUI

struct SelectedButton: View {
    @State var isPressed: Bool = false
    let image: ImageResource
    
    var body: some View {
        ZStack{
            Circle()
                .opacity(isPressed ? 0.2 : 1)
                .foregroundStyle(.white)
                .frame(width: 80, height: 80)
            Button {
                isPressed.toggle()
                print("Btn click \(image)")
            } label: {
                Image(image)
            }
        }
    }
}

struct GameButtons: View {
    //скрытая кнопка дополнительного задания
    @State private var isHiddenButton = false
    @State private var isPressedPeople = true
    
    @State private var isPressedPaper = true
    @State private var isPressedStone = true
    @State private var isPressedScissors = true
    var body: some View {
        ZStack {
            VStack{
                SelectedButton(isPressed: isPressedPaper, image: .paper)
                Spacer()
                
                //Кнопка к доп. заданию
                    Button {
                        print("randomSelector")
                        isPressedPeople.toggle()
                    } label: {
                            Image(isPressedPeople ? .randomSelector : .randomSelectorSelect)
                    }
                    .opacity(isHiddenButton ? 0 : 1)
                //Кнопка к доп. заданию
                
            }
            HStack{
                SelectedButton(isPressed: isPressedStone, image: .stone)
                Spacer()
                SelectedButton(isPressed: isPressedScissors, image: .scissors)
            }
        }
        .frame(width: 272, height: 160)
        .background(.clear)
    }
}

#Preview{
    GameButtons()
}
