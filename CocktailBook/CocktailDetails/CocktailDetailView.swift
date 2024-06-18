import SwiftUI

struct CocktailDetailView: View {
    var cocktail: Cocktail

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(cocktail.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding()

                Text(cocktail.name)
                    .font(.largeTitle)
                    .padding(.bottom, 5)
                
                Text("Type: \(cocktail.type.capitalized)")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Text("Description")
                    .font(.title) // Use .title instead of .title2
                    .padding(.bottom, 5)
                
                Text(cocktail.longDescription)
                    .font(.body)
                    .padding(.bottom, 5)
                
                Text("Preparation Time: \(cocktail.preparationMinutes) minutes")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Text("Ingredients")
                    .font(.title) // Use .title instead of .title2
                    .padding(.bottom, 5)
                
                ForEach(cocktail.ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                        .font(.body)
                        .padding(.bottom, 2)
                }
            }
            .padding()
        }
        .navigationBarTitle(Text(cocktail.name), displayMode: .inline)
    }
}
