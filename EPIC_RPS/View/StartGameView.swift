
import SwiftUI

struct StartGameView: View {
    //MARK: - PROPERTIES
    @ObservedObject var epicManager: GameManager
    @State private var handsAreStretched = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    
    //MARK: - BODY
    var body: some View {
        
       // NavigationView {
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
                        Text(epicManager.winLabel)
                                   .textCase(.uppercase)
                                   .font(.system(size: 60).bold())
                                   .foregroundStyle(.yellowGame)
                                   .scaleEffect(epicManager.isLabelAnimating ? 2 : 1.0)
                                   .opacity(epicManager.isHidden ? 0 : 1)
                                   .onAppear {
                                   
                                   }
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
                                .animation(.easeInOut(duration: 0.9), value: handsAreStretched)
                            Spacer()
                            Spacer()
                        }
                    }
                }//: OVERLAY
                
                //когда выигрывает комп (epicManager.computer.win - true)
                NavigationLink(destination: FightResultView(epicManager: epicManager), isActive: $epicManager.computer.win) {
                    EmptyView()
                        .onAppear {
                            if epicManager.computer.win {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    epicManager.computer.win = true
                                }
                            }
                        }
                    
                }
                
                //когда выигрывает человек (epicManager.people.win - - true)
                NavigationLink(destination: FightResultView(epicManager: epicManager), isActive: $epicManager.people.win) {
                    EmptyView()
                }                      
                .onAppear {
                    if epicManager.computer.win {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            epicManager.computer.win = true
                        }
                    }
                }

            }//:
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(RadialGradient(colors: [.gradientOne, .gradientTwo], center: .center, startRadius: .zero, endRadius: 350))
            .overlay(alignment: .bottom){
                GameButtons(epicManager: epicManager)
            }//: OVERLAY
            .ignoresSafeArea()

//        }//: NAVVIEW
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                },
                       label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                    
                })
            }
            ToolbarItem(placement: .principal) {
                HStack{
                    Text("Game")
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Button(action: {
                        epicManager.gameTimer.isStop.toggle()
                        print("ButtonPressed")
                    })
                    {
                        Image(systemName: "pause.circle")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                }
            }
        }
       
        .onAppear{
            epicManager.ComputerSelectQuestion()
            print("Компьютер загадал - \(epicManager.computer.arr[epicManager.computer.randomSelect!])")
            
            withAnimation(.easeInOut(duration: 1)) {
                epicManager.winLabel = "Fight"
                epicManager.isLabelAnimating = true
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 3)) {
                    epicManager.isHidden = true
                }
            }
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
                        epicManager.currentTopHand
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
                        epicManager.currentBottomHand
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
