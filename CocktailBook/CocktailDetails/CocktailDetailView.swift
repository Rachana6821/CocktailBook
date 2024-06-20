import SwiftUI

struct CocktailDetailView: View {
    var cocktail: Cocktail //Instance of Cocktail Model
    var navigationTitle: String //Navigation title based on the filter selected
    @Environment(\.presentationMode) var presentationMode //Presentation mode in order to pop the screen on click of back
    @ObservedObject var viewModel: CocktailBookListViewModel//Instance of viewmodel
    ///Method to get index based on UUID of model
    func getIndex() -> Int {
        return viewModel.cocktails.firstIndex(where: ({$0.id == cocktail.id})) ?? 0
    }
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
        .navigationBarItems(trailing: favButton)
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
    
    private var favButton: some View  {
        FavoriteButton(isFavorite: $viewModel.cocktails[getIndex()].isFavorite, tag: viewModel.cocktails[getIndex()].id)}
    
}

