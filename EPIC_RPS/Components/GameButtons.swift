import SwiftUI

struct SelectedButton: View {
    var epicManager: GameManager
    @State var isPressed: Bool = false
    
    
    let image: ImageResource
    let data: ChoseData
//
    var body: some View {
        ZStack{
            Circle()
                .opacity(isPressed ? 0.2 : 1)
                .foregroundStyle(.white)
                .frame(width: 80, height: 80)
            Button {
                isPressed.toggle()
//                print("Btn click \(image)")
                epicManager.StartGame(data: data)
                isPressed.toggle()
            } label: {
                Image(image)
            }
        }
    }
}

struct GameButtons: View {
    var epicManager: GameManager
    //скрытая кнопка дополнительного задания
    @State private var isHiddenButton = false
    @State private var isPressedPeople = true
    
    @State private var isPressedPaper = true
    @State private var isPressedStone = true
    @State private var isPressedScissors = true
    
    @State private var currentTopHand = Image(.femaleHand)
    @State private var currentBottomHand = Image(.maleHand)
    
    var body: some View {
        ZStack {
            VStack{
                SelectedButton(epicManager: epicManager, isPressed: isPressedPaper, image: .paper, data: .paper)
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
                SelectedButton(epicManager: epicManager, isPressed: isPressedStone, image: .stone, data: .rock)
                Spacer()
                SelectedButton(epicManager: epicManager, isPressed: isPressedScissors, image: .scissors, data: .scissors)
            }
        }
        .frame(width: 272, height: 160)
        .background(.clear)
    }
}

#Preview{
    GameButtons(epicManager: GameManager())
}

//Button("AnimationTest") {
//    withAnimation(.easeInOut(duration: 1)) {
//        handsAreStretched.toggle()
//    }
//    
//    // Пример логики изменения рук в зависимости от состояния игры
//    currentTopHand = Image(.femaleHandScissors) // или другой нужный образ
//    currentBottomHand = Image(.maleHandRock) // или другой нужный образ
//    
//    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
//        withAnimation(.easeInOut(duration: 1)) {
//            showClash.toggle()
//        }
//    }
//}
