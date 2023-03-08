import UIKit

class CookingViewController: UIViewController {

    private let cookingHeaderView: CookingHeaderView =  {
        let view = CookingHeaderView()
        view.translates()
        return view
    }()

    private let cookingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translates()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraints()
        configureTableView()
    }

    private func configureTableView() {
        cookingTableView.dataSource = self
        cookingTableView.delegate = self
        cookingTableView.separatorStyle = .none
        cookingTableView.register(NameOfRecipeTableViewCell.self, forCellReuseIdentifier: "NameOfRecipeTableViewCell")
        cookingTableView.register(CookingFooterTableViewCell.self, forCellReuseIdentifier: "CookingHeaderTableViewCell")
        cookingTableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: "IngredientsTableViewCell")
        cookingTableView.register(InstructionsTableViewCell.self, forCellReuseIdentifier: "InstructionsTableViewCell")

    }
}

extension CookingViewController {
    private func setupLayout() {
        view.addSubview(cookingHeaderView)
        view.addSubview(cookingTableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cookingHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            cookingHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cookingHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            cookingTableView.topAnchor.constraint(equalTo: cookingHeaderView.bottomAnchor),
            cookingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cookingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cookingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

    }
}

extension CookingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategorieTableViewCell", for: indexPath) as! CategorieTableViewCell
        return cell
    }
}
