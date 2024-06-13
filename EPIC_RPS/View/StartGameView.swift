
import SwiftUI

struct StartGameView: View {
    //MARK: - PROPERTIES
    @ObservedObject var epicManager: GameManager
    @State private var handsAreStretched = false
   
    
    
    //MARK: - BODY
    var body: some View {
        
        NavigationView {
            VStack {
                ZStack{
                    Image(.fill1)
                        .resizable()
                        .scaledToFit()
                    HStack{
                        TimerView(epicManager: epicManager)
                            .frame(height: 300)
                            .padding(.leading, 5)
                        Spacer()
                        Text("Fight")
                            .textCase(.uppercase)
                            .font(.system(size: 60).bold())
                            .foregroundStyle(.yellowGame)
                        //                        Button{
                        //                            epicManager.gameTimer.isStop.toggle()
                        //                        }
                        //                    label: {
                        //                            Text("Stop")
                        //                    }
                        Spacer()
                        GameStatusView(barTotal: 6, barValueOne: Float(epicManager.computer.score), barValueTwo: Float(epicManager.people.score))
                            .frame(height: 400)
                            .padding(.trailing, 20)
                    }
                }
                //: ZSTACK
                .overlay(alignment: .leading) {
                    Image(.rectangle)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .padding(.leading, -1)
                        .padding(.top, -150)
                }
                // мужская рука снизу
                .overlay(alignment: .bottom) {
                    HStack {
                        Spacer()
                        Spacer()
                        if !epicManager.showClash || epicManager.topPlayerWin {
                            epicManager.currentBottomHand
                                .resizable()
                                .scaledToFit()
                                .frame(width: 155, height: 450)
                                .padding(.bottom, handsAreStretched ? -290 : -350)
                                .animation(.easeInOut(duration: 0.5), value: handsAreStretched)
                        }
                        Spacer()
                    }
                }//: OVERLAY
                // женская рука сверху
                .overlay(alignment: .top) {
                    HStack {
                        Spacer()
                        if !epicManager.showClash || !epicManager.topPlayerWin {
                            epicManager.currentTopHand
                                .resizable()
                                .scaledToFit()
                                .frame(width: 155, height: 450)
                                .padding(.top, handsAreStretched ? -190 : -350)
                                .animation(.easeInOut(duration: 0.5), value: handsAreStretched)
                            Spacer()
                            Spacer()
                        }
                    }
                }//: OVERLAY
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(RadialGradient(colors: [.gradientOne, .gradientTwo], center: .center, startRadius: .zero, endRadius: 350))
            .overlay(alignment: .bottom){
                GameButtons(epicManager: epicManager)
            }//: OVERLAY
            .ignoresSafeArea()
            
        }
        .onAppear{
            epicManager.ComputerSelectQuestion()
            print("Компьютер загадал - \(epicManager.computer.arr[epicManager.computer.randomSelect!])")
            
        }
        
        
        //MARK: - FUNCTIONS
        // пятно крови и проигравшая рука
        .overlay(alignment: epicManager.topPlayerWin ? .bottom : .top) {
            if epicManager.showClash {
                VStack(spacing: 0) {
                    if epicManager.topPlayerWin {
                        Image(.blood)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .padding(.bottom, -250)
                        Image(.femaleHandScissors)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 155, height: 650)
                            .padding(.top, -350)
                        
                    } else {
                        Image(.blood)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .padding(.bottom, -250)
                        Image(.maleHandRock)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 155, height: 650)
                            .padding(.bottom, -350)
                        
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(RadialGradient(colors: [.gradientOne, .gradientTwo], center: .center, startRadius: .zero, endRadius: 350))
    }
    
}
    
    //MARK: - FUNCTIONS
    


//MARK: - PREVIEW
#Preview {
//    StartGameView(epicManager: GameManager.testState())
    StartGameView(epicManager: GameManager())
}
