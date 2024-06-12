//Khabibullokh's Task

import SwiftUI


struct RulesView: View {
    var textBlue = "500 баллов"
    var body: some View {
     
        
        VStack(alignment: .leading, spacing: 16) {
           
                 
            Text("Rules")
                .font(.largeTitle)
                
              
                .padding(.top)
            RuleItem(number: 1, text: "Игра проводится между игроком и компьютером.")
            
            RuleItem(number: 2, text: "Жесты:")
                            .padding(.top)

                        VStack(alignment: .leading, spacing: 8) {
                            GestureItem( text: "Кулак > Ножницы", image2: "Paper")
                            GestureItem( text: "Бумага > Кулак", image2: "Scissors")
                            GestureItem(text: "Ножницы > Бумага", image2: "Stonestone")
                        }
                        .padding(.leading, 32)

            RuleItem(number: 3, text: "У игрока есть 30 сек. для выбора жеста.")
            RuleItem(number: 4, text: "Игра ведётся до трёх побед одного из участников.")
            RuleItem(number: 5, text: "За каждую победу игрок получает \(textBlue), которые можно посмотреть на доске лидеров.")

                        Spacer()
                    }
                    .padding()
                    .navigationBarTitle("", displayMode: .large)
                    
                
            
        }
        
    }

    

struct RuleItem: View {
    let number: Int
    let text: String

    var body: some View {
        HStack(alignment: .top) {
            ZStack{
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 30, height: 30)
                Text("\(number)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(width: 30)
                    
                
            }
            Text(text)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
                .shadow(color: .gray, radius: 2, x: 0, y: 1)
            

        }
    }
}

struct GestureItem: View {
    //let icon: String
    let text: String
    let image2: String
    var body: some View {
        HStack(alignment: .center) {
            Image("\(image2)")
                .foregroundColor(.blue)
                .font(.title2)
                .frame(width: 30)
            
            Text(text)
                .font(.body)
                .shadow(color: .gray, radius: 2, x: 0, y: 1)

        }
    }
}

