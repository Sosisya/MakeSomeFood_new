import UIKit
import Kingfisher

enum Section: Int, CaseIterable {
    case nameOfrecipe
    case ingredientFooter
    case ingredients
    case instructionsFooter
    case instructions
}

class CookingViewController: UIViewController {
    struct Spec {}

    var recipe: Recipe?

    private let cookingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translates()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupConstraints()
        configureTableView()
        configureStrechyHeader()
        configureNavigationBar()
        addShareBarButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBarTint()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = .specialBlack
    }
}

extension CookingViewController {
    private func setupLayout() {
        view.addSubview(cookingTableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cookingTableView.topAnchor.constraint(equalTo: view.topAnchor),
            cookingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cookingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cookingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureTableView() {
        cookingTableView.dataSource = self
        cookingTableView.delegate = self
        cookingTableView.separatorStyle = .none
        cookingTableView.allowsSelection = false
        cookingTableView.register(NameOfRecipeTableViewCell.self, forCellReuseIdentifier: "NameOfRecipeTableViewCell")
        cookingTableView.register(CookingFooterTableViewCell.self, forCellReuseIdentifier: "CookingFooterTableViewCell")
        cookingTableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: "IngredientsTableViewCell")
        cookingTableView.register(InstructionsTableViewCell.self, forCellReuseIdentifier: "InstructionsTableViewCell")
    }

    private func configureStrechyHeader() {
        let headerView = CookingHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 280))
        let url = URL(string: recipe?.thumb ?? "")
        headerView.recipeImageView.kf.setImage(with: url)
        cookingTableView.tableHeaderView = headerView
    }

    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func updateNavigationBarTint() {
        let isScrolled = cookingTableView.contentOffset.y + cookingTableView.adjustedContentInset.top > 0
        navigationController?.navigationBar.tintColor = isScrolled ? .specialBlack : .white
    }

   private func addShareBarButtonItem() {
       let shareButton = UIBarButtonItem(image: UIImage(named: "square.and.arrow.up"), style: .done, target: self, action: #selector(shareButtonPressed))
        self.navigationItem.rightBarButtonItem = shareButton
    }

    @objc func shareButtonPressed() {
        print("Share")
    }
}

// -MARK: UIScrollViewDelegate
extension CookingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = cookingTableView.tableHeaderView as! CookingHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
        updateNavigationBarTint()
    }
}

// - MARK: UITableViewDelegate, UITableViewDataSource
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
            return recipe?.ingredients.count ?? 0
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
            cell.nameOfRecipeLabel.text = recipe?.name
            cell.areaTagLabel.text = recipe?.area
            cell.categoryTagLabel.text = recipe?.category
            return cell
        case .ingredientFooter:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CookingFooterTableViewCell", for: indexPath) as! CookingFooterTableViewCell
            cell.headerView.headerLabel.text = "Ingredients"
            return cell
        case .ingredients:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell", for: indexPath) as! IngredientsTableViewCell
            cell.ingredientLabel.text = recipe?.ingredients[indexPath.row]
            cell.quantityOfIngredientsLabel.text = recipe?.measures[indexPath.row]
            return cell
        case .instructionsFooter:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CookingFooterTableViewCell", for: indexPath) as! CookingFooterTableViewCell
            cell.headerView.headerLabel.text = "Instructions"
            return cell
        case .instructions:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionsTableViewCell", for: indexPath) as! InstructionsTableViewCell
            cell.instructionsLabel.text = recipe?.instruction
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
