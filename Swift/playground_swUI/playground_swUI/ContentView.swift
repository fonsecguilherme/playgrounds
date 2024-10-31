import SwiftUI

struct ContentView: View {
    
    @State private var tapCount = 0
    @State private var name = ""
    
    private var students = ["Guilherme", "Nicole", "Bichano"]
    
    @State private var selectedStudent = "Bichano"
    
    @State private var username: String = ""
    
    let names: [String] = ["Guilherme", "Nicole", "Bichano", "Selma", "Genivaldo"]
    
    
    let imageURL = URL(string: "https://preview.redd.it/meu-gato-é-praticamente-o-gato-do-meme-v0-n9dleoj8dgfc1.jpg?width=640&crop=smart&auto=webp&s=52de2578fe227e639db822d551bba33c6d28a2f1")
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            TextField("Apenas números =)", text: $username)
            Text(username)
        }.textFieldStyle(.roundedBorder)
        .padding()
        
        AsyncImage(url: imageURL) { imgResult in
            if let image = imgResult.image {
                image.resizable()
            }else if imgResult.error != nil{
                Text("erro ao obter a imagem")
            }else {
                ProgressView()
            }
        }.frame(width: 200, height: 200)
        
        
        Button(action: {
            username = names.randomElement()!
            print("bati no botão \(username)")},
               label: {
            Label("Meu boão", systemImage: "cloud.rain")
        }).buttonStyle(MyCustomButton())
        
//        Button(action: {
//            print("bati no botão")}
//        ) {
//            Text("Bordered")
//                .buttonStyle(.bordered)
//                .controlSize(.regular)
//                .buttonBorderShape(.automatic)
//        }
        
        //        Form{
        //            TextField("type your name", text: $name)
        //                .autocorrectionDisabled(true) //two way binding valor lido e escrito de volta
        //                .background(.green)
        //                .border(.red, width: 5)
        //
        //            Text("Your name is: \(name)")
        //        }.padding(EdgeInsets(top: 25, leading:90, bottom: 30, trailing: 0))
        //            .background(.red)
        //
        //        Button("Tap count \(tapCount)"){
        //            tapCount += 1
        //        }
                
                NavigationStack{
                    Form{
                        Picker("Pick one", selection: $selectedStudent, content: {
                            ForEach(students, id: \.self){ student in
                                Text(student)
                            }
                        })
                    }.navigationTitle("Select a student")
                }
        
    }
}

#Preview {
    ContentView()
}

struct MyCustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.red)
            .foregroundColor(.black)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        
    }
}
