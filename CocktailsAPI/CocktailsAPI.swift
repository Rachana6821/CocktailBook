import Foundation
import Combine

//protocol CocktailsAPI: AnyObject {
//
//    var cocktailsPublisher: AnyPublisher<Data, CocktailsAPIError> { get }
//    func fetchCocktails(_ handler: @escaping (Result<Data, CocktailsAPIError>) -> Void)
//}
import Foundation
import Combine

class CocktailsAPI {
    func fetchCocktails(completion: @escaping (Result<Data, Error>) -> Void) {
        // Ensure the sample.json file is in the main bundle
        guard let url = Bundle.main.url(forResource: "sample", withExtension: "json") else {
            completion(.failure(NSError(domain: "Invalid file URL", code: -1, userInfo: nil)))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }
}
