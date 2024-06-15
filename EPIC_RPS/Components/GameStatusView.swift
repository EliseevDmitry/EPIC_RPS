import SwiftUI

struct GameStatusView: View {
    //MARK: - PROPERTIES
    let barTotal: Float
    let barValueOne: Float
    let barValueTwo: Float
    
    var body: some View {

            GeometryReader { screen in
                ZStack{
                    ZStack(alignment: .top){
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(.orange)
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(.blue)
                            .frame(height: screen.size.height * CGFloat(barValueOne) / CGFloat(barTotal))
                    }//: ZSTACK ProgressBar
                    .frame(width: 12)
                    
                    
                    .overlay(alignment: .bottom){
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(.green)
                            .frame(height: screen.size.height * CGFloat(barValueTwo) / CGFloat(barTotal))
                    }
                    Rectangle()
                        .frame(width: 18, height: 2)
                        .foregroundStyle(.white)
                }
                Image(.player1)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .position(CGPoint(x: 9.0, y: (screen.size.height * CGFloat(barValueOne) / CGFloat(barTotal))))
                    .overlay(alignment: .bottom){
                        Image(.player2)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .position(CGPoint(x: 9.0, y:  ((screen.size.height)-(screen.size.height * CGFloat(barValueTwo) / CGFloat(barTotal)))))
                    }
                
            }
            .frame(width: 12)
        }
        
    }//: GeometryReader
    

#Preview {
    GameStatusView(barTotal: 6, barValueOne: 1, barValueTwo: 2)
}
