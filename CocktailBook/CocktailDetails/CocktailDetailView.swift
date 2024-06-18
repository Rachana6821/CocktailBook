import SwiftUI

struct CocktailDetailView: View {
    var cocktail: Cocktail
    var navigationTitle: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
               
                Text(cocktail.name)
                    .font(.largeTitle)
                    .padding(.bottom, 5)
                
                HStack{
                    Image(systemName: "clock")
                    .foregroundColor(.gray)
                    Text("\(cocktail.preparationMinutes) mins")
                }
                Image(cocktail.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text(cocktail.longDescription)
                    .font(.body)
                    .padding(.bottom, 5)
                Text("Ingredients")
                    .font(.title)
                    .padding(.bottom, 5)
                
                ForEach(cocktail.ingredients, id: \.self) { ingredient in
                    HStack{
                        Image(systemName: "arrowtriangle.right.fill")
                        .foregroundColor(.gray)
                        Text(ingredient)
                            .font(.body)
                            .padding(.bottom, 2)
                    }
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    private var backButton: some View {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("\(navigationTitle)")
                }
                .foregroundColor(.black)
            }
        }

}

