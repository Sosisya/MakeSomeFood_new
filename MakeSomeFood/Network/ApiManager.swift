import Foundation

struct ApiManager {
    
    enum ApiError: Error {
        case unknownError
    }
    
    func getCategoryList(completion: @escaping (Result<CategoriesList, Error>) -> Void) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/categories.php"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(.failure(error ?? ApiError.unknownError))
                return
            }
            do {
                let categories = try JSONDecoder().decode(CategoriesList.self, from: data)
                completion(.success(categories))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
