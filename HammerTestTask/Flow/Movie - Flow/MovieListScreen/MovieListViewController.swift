import UIKit

final class MovieListViewController: UIViewController {
    
    // MARK: - UI
    
    private let movieListTableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - PROPERTIES
    
    var presenter: MovieListViewPresenterProtocol!
    private let header = CategoryTableViewHeader()
    private let alertService = AlertService()
    private lazy var subView = [ movieListTableView ]
    
    //MARK: - CONSTRAINT
    
    private lazy var factor = view.bounds.width / 5
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        header.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        presenter.getData()
    }
}

// MARK: - extension - MovieListViewProtocol

extension MovieListViewController: MovieListViewProtocol {
    
    func success() {
        movieListTableView.reloadData()
    }
    
    func failure(error: BackendError) {
        
        switch error {
        case .information(let text, let code), .redirection(let text, let code), .authError(let text, let code), .clientError(let text, let code), .serverError(let text, let code), .unresolved(let text, let code):
            //just for saving time
            alertService.alertForUser(with: .failureNetwork, view: self, text: text, code: code)
        case .decodeError(description: let text):
            alertService.alertForUser(with: .failureNetwork, view: self, text: text, code: 0)
        }
    }
}

// MARK: - extension - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        switch indexPath.section {
        case 2:
            let data = presenter.filtredData[indexPath.row]
            presenter.tapOnData(data: data)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return factor/1.3
        case 1:
            return factor * 1.7
        case 2:
            return factor * 2.5
        default:
            return factor
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 2:
            return header.setUI()
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 1:
            return 0
        case 2:
            return factor
        default:
            return 0
        }
    }
}

// MARK: - extension - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return presenter.filtredData.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieListLocationTableViewCell.identifier) as! MovieListLocationTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCollectionView.identifier) as! MovieListCollectionView
            cell.data = presenter.data
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier) as! MovieListTableViewCell
            let data = presenter.filtredData[indexPath.row]
            cell.setUI(radius: indexPath.row == 0 ? 20 : 0, title: data.title, plot: data.plot, duration: data.runtime, imageLink: data.poster)
            cell.backgroundColor = CColor.background
            return cell
        default :
            return UITableViewCell()
        }
    }
}

// MARK: - extension - ViewControllerProtocol

extension MovieListViewController: ViewControllerProtocol {
    
    func setUI()  {
        
        view.backgroundColor = CColor.background
        
        movieListTableView.translatesAutoresizingMaskIntoConstraints = false
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
        movieListTableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        movieListTableView.register(MovieListCollectionView.self, forCellReuseIdentifier: MovieListCollectionView.identifier)
        movieListTableView.register(MovieListLocationTableViewCell.self, forCellReuseIdentifier: MovieListLocationTableViewCell.identifier)
        movieListTableView.backgroundColor = CColor.background
        movieListTableView.sectionHeaderHeight = 0
        movieListTableView.sectionHeaderTopPadding = 0
        movieListTableView.separatorInset = .zero
        movieListTableView.separatorColor = CColor.background
        
        
        setView(view: view, subView: subView)
        setConstraint()
    }
    
    func setConstraint()  {
        NSLayoutConstraint.activate([
            movieListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - extension - CategoryTableViewGroupDidSelected

extension MovieListViewController: CategoryTableViewGroupDidSelected {
    
    func didSelectedModel(genre: Genre?) {
        presenter.filter = genre
    }
}
