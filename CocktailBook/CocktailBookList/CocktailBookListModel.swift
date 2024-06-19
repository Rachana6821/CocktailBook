import Foundation
///Model Created for Coctail API
struct Cocktail: Identifiable, Decodable {
    let id: String
    var isFavorite: Bool = false
    let name: String
    let type: String
    let shortDescription: String
    let longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case shortDescription
        case longDescription
        case preparationMinutes
        case imageName
        case ingredients
    }
    
    ///Initialising the data from API
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
        
        type = try container.decode(String.self, forKey: .type)
        
        shortDescription = try container.decode(String.self, forKey: .shortDescription)
        
        longDescription = try container.decode(String.self, forKey: .longDescription)
        
        preparationMinutes = try container.decode(Int.self, forKey: .preparationMinutes)
        
        imageName = try container.decode(String.self, forKey: .imageName)
        
        ingredients = try container.decode([String].self, forKey: .ingredients)
        
    }
}
