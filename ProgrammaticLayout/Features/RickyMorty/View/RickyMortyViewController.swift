
import UIKit
import SnapKit

protocol RickyMortyOutput {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
}

final class RickyMortyViewController: UIViewController {
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private lazy var results: [Result] = []
    
    lazy var viewModel: IRickyMortyViewModel = RickyMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
    private func configure() {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        drawDesign()
        makeLabel()
        makeIndicator()
        makeTableView()
    }
    
    private func drawDesign() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickyMortyTableViewCell.self, forCellReuseIdentifier: RickyMortyTableViewCell.Identifier.custom.rawValue)
        
        tableView.rowHeight = self.view.frame.size.height * 0.33
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
            self.labelTitle.text = "FurkanSakiz"
            self.loadingIndicator.color = .gray
        }
        loadingIndicator.startAnimating()
    }

}

extension RickyMortyViewController: RickyMortyOutput {
    
    func changeLoading(isLoad: Bool) {
        isLoad ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
    }
    
    func saveDatas(values: [Result]) {
        results = values
        tableView.reloadData()
    }
    
}

extension RickyMortyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RickyMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickyMortyTableViewCell.Identifier.custom.rawValue) as? RickyMortyTableViewCell else {
            return UITableViewCell()
        }
        cell.saveModel(model: results[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rickyMortyDetailVC = RickyMortyDetailViewController()
        rickyMortyDetailVC.character = results[indexPath.row]
        navigationController?.pushViewController(rickyMortyDetailVC, animated: true)
    }
    
    
}

extension RickyMortyViewController {
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
        }
    }
    
    private func makeIndicator() {
        loadingIndicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
    
    private func makeLabel() {
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
}
