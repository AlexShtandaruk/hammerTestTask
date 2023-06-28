import UIKit

final class MovieDetailViewController: UIViewController {
    
    //MARK: - UI
    
    private let objectTableView = UITableView(frame: .zero, style: .plain)
    
    //MARK: - SET UI
    
    private lazy var subView = [
        objectTableView
    ]
    
    //MARK: - PROPERTIES
    
    var presenter: MovieDetailPresenterProtocol!
    private let alertService = AlertService()
    private var data: Movie?
    private let header = MovieDetailTableViewHeader()
    
    //MARK: - CONSTRAINT
    
    private lazy var factor = view.bounds.width / 5
    
    //MARK: - LIFE CYCLE
    
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

//MARK: - extension - ObjectViewProtocol

extension MovieDetailViewController: MovieDetailViewProtocol {
    
    func setData(data: Movie?) {
        self.data = data
    }
}

// MARK: - extension - UITableViewDelegate

extension MovieDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return factor * 3
        case 1:
            return factor / 1.2
        case 2:
            return factor * 3
        default:
            return factor
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return header.setUI()
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return factor
        default:
            return 0
        }
    }
}

// MARK: - extension - UITableViewDataSource

extension MovieDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier) as! MovieDetailTableViewCell
            cell.setUI(
                image: data?.poster,
                title: data?.title,
                year: data?.year,
                runtime: data?.runtime,
                descriptionMovie: data?.plot,
                actor: data?.actors,
                director: data?.director)
            cell.isUserInteractionEnabled = false
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: WatchTableViewCell.identifier) as! WatchTableViewCell
            cell.delegate = self
            cell.setUI()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieRecTableViewCell.identifier) as! MovieRecTableViewCell
            cell.setUI()
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - extension - ViewControllerProtocol

extension MovieDetailViewController: ViewControllerProtocol {
    
    func setUI()  {
        
        view.backgroundColor = CColor.custBlack
        
        objectTableView.translatesAutoresizingMaskIntoConstraints = false
        objectTableView.dataSource = self
        objectTableView.delegate = self
        objectTableView.register(MovieDetailTableViewCell.self, forCellReuseIdentifier: MovieDetailTableViewCell.identifier)
        objectTableView.register(WatchTableViewCell.self, forCellReuseIdentifier: WatchTableViewCell.identifier)
        objectTableView.register(MovieRecTableViewCell.self, forCellReuseIdentifier: MovieRecTableViewCell.identifier)
        objectTableView.backgroundColor = CColor.custBlack
        objectTableView.separatorColor = .clear
        objectTableView.separatorInset = .zero
        
        setView(view: view, subView: subView)
        setConstraint()
    }
    
    func setConstraint()  {
        NSLayoutConstraint.activate([
            objectTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            objectTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            objectTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            objectTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - extension - MovieDetailTableViewDidSelected

extension MovieDetailViewController: MovieDetailTableViewDidSelected {
    
    func didSelectedToTapBack() {
        presenter.tapBack()
    }
    
    func didSelectedToLogOut() {
        presenter.tapLogOut()
    }
}

// MARK: - extension - WatchTableViewCellDidSelected

extension MovieDetailViewController: WatchTableViewCellDidSelected {
    
    func watchTableViewCellDidSelected() {
        alertService.alertForUser(with: .tryToWatchMovie, view: self, text: nil, code: nil)
    }
}
