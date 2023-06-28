import Foundation

// MARK: - List of movie

fileprivate enum MovieList: String, CaseIterable {
    
    case movieOne = "tt3896198"
    case movieTwo = "tt0120737"
    case movieThree = "tt0265086"
    case movieFour = "tt0093058"
    case movieFive = "tt0111161"
    case movieSix = "tt0068646"
    case movieSeven = "tt0108052"
    case movieEight = "tt0109830"
    case movieNine = "tt1375666"
    case movieTen = "tt0133093"
    case movieElewen = "tt0120815"
    case movieTwelve = "tt0110357"
}

// MARK: - Movie list FetchHelper

protocol FetchHelperProtocol: AnyObject {
    
    var view: MovieListViewProtocol? { get set }
    var data: [Movie] { get set }
    
    init(view: MovieListViewProtocol, networkService: NetworkServiceProtocol)
    
    func getData(completion: @escaping () -> Void)
}

final class FetchHelper: FetchHelperProtocol {
    
    weak var view: MovieListViewProtocol?
    let networkService: NetworkServiceProtocol!
    var data: [Movie] = []
    
    required init(view: MovieListViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func getData(completion: @escaping () -> Void) {
        
        let group = DispatchGroup()
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        var data: [Movie] = []
        
        for film in MovieList.allCases {
            group.enter()
            networkService.getMovieData(film: film.rawValue) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let model):
                    if let model = model {
                        queue.addOperation {
                            data.append(model)
                        }
                    }
                case .failure(let error):
                    self.view?.failure(error: error)
                    data = DataCaretaker.loadMovieList() ?? []
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.data = data
            self.view?.success()
            DataCaretaker.saveMovieList(data)
            completion()
        }
    }
}
