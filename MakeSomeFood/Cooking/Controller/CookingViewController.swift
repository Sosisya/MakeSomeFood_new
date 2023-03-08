import UIKit

enum Section: Int, CaseIterable {
    case nameOfrecipe
    case ingredientFooter
    case ingredients
    case instructionsFooter
    case instructions
}

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
        cookingTableView.register(CookingFooterTableViewCell.self, forCellReuseIdentifier: "CookingFooterTableViewCell")
        cookingTableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: "IngredientsTableViewCell")
        cookingTableView.register(InstructionsTableViewCell.self, forCellReuseIdentifier: "InstructionsTableViewCell")
        cookingTableView.allowsSelection = false
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .nameOfrecipe:
            return 1
        case .ingredientFooter:
            return 1
        case .ingredients:
            return 5
        case .instructionsFooter:
            return 1
        case .instructions:
            return 1
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .nameOfrecipe:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameOfRecipeTableViewCell", for: indexPath) as! NameOfRecipeTableViewCell
            return cell
        case .ingredientFooter:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CookingFooterTableViewCell", for: indexPath) as! CookingFooterTableViewCell
            cell.headerView.headerLabel.text = "Ingredients"
            return cell
        case .ingredients:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell", for: indexPath) as! IngredientsTableViewCell
            return cell
        case .instructionsFooter:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CookingFooterTableViewCell", for: indexPath) as! CookingFooterTableViewCell
            cell.headerView.headerLabel.text = "Instructions"
            return cell
        case .instructions:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionsTableViewCell", for: indexPath) as! InstructionsTableViewCell
            return cell
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
