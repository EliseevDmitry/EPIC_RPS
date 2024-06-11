//Khabibullokh's Task

import SwiftUI


struct RulesView: View {
    //MARK: - PROPERTIES
    
    
    //MARK: - BODY
    var body: some View {
      
        VStack(alignment: .leading, spacing: 16) {
            Text("Rules")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            RuleItem(number: 1, text: "Игра проводится между игроком и компьютером.")
            
            RuleItem(number: 2, text: "Жесты:")
                            .padding(.top)

                        VStack(alignment: .leading, spacing: 8) {
                            GestureItem(icon: "Paper", text: "Кулак > Ножницы")
                            GestureItem(icon: "Scissors", text: "Бумага > Кулак")
                            GestureItem(icon: "hand.scissors.fill", text: "Ножницы > Бумага")
                        }
                        .padding(.leading, 32)

                        RuleItem(number: 3, text: "У игрока есть 30 сек. для выбора жеста.")
                        RuleItem(number: 4, text: "Игра ведётся до трёх побед одного из участников.")
                        RuleItem(number: 5, text: "За каждую победу игрок получает 500 баллов, которые можно посмотреть на доске лидеров.")

                        Spacer()
                    }
                    .padding()
                    .navigationBarTitle("", displayMode: .inline)
                
            
            
        }
            
        
    }

    

struct RuleItem: View {
    let number: Int
    let text: String

    var body: some View {
        HStack(alignment: .top) {
            Text("\(number)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.yellow)
                .frame(width: 30)

            Text(text)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct GestureItem: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(alignment: .center) {
            Image("Paper")
                .foregroundColor(.blue)
                .font(.title2)
                .frame(width: 30)
            Image("Scissors")
                .foregroundColor(.blue)
                .font(.title2)
                .frame(width: 30)
            Image("Stonestone")
                .foregroundColor(.blue)
                .font(.title2)
                .frame(width: 30)
            

            Text(text)
                .font(.body)
        }
    }
}


//MARK: - PREVIEW
#Preview {
    RulesView()
}
