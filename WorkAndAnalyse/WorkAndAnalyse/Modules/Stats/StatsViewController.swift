//
//  StatsViewController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.05.2021.
//

import UIKit

class StatsViewController: BaseViewController {
    
    enum State: Int {
        case isPresentingTimeline = 0
        case isPresentingOverview = 1
    }
    
    var viewModel: StatsViewModelProtocol!
    
    private var state: State = .isPresentingTimeline {
        didSet {
            switch state {
            case .isPresentingTimeline:
                tableView.isHidden = true
            case .isPresentingOverview:
                tableView.isHidden = false
            }
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let segmentControl = UISegmentedControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true

        configureSegmentControl()
        
        // Configure table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OutlinedCell.self, forCellReuseIdentifier: String(describing: OutlinedCell.self))
        
        view.addSubview(tableView)
        view.addSubview(segmentControl)
        
        segmentControl.snp.makeConstraints { (make) in
            make.topMargin.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalTo(tableView.snp.top).offset(-10)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottomMargin.equalToSuperview()
        }
    }
    
    private func configureSegmentControl() {
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.addTarget(self, action: #selector(didSegmentIndexChanged(sender:)), for: .valueChanged)
        for model in viewModel.segmentData {
            segmentControl.insertSegment(withTitle: model.title, at: model.index, animated: true)
            segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: CustomFonts.openSans(size: 18, style: .semibold)], for: .normal)
        }
        
        segmentControl.selectedSegmentTintColor = CustomColors.lightOrangeColor
        
        segmentControl.selectedSegmentIndex = 0
    }

    @objc private func didSegmentIndexChanged(sender: UISegmentedControl) {
        state = State(rawValue: sender.selectedSegmentIndex) ?? .isPresentingTimeline
        viewModel.clearData()
        viewModel.loadData(at: sender.selectedSegmentIndex)
    }
}

extension StatsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = viewModel.summaryData[indexPath.section].cells[indexPath.row]
        guard let model = element as? SummaryViewModel else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OutlinedCell.self), for: indexPath) as? OutlinedCell
        
        cell?.configure(text: model.title, rightDetailText: model.rightDetailText, style: .normal)
        
        return cell ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.summaryData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.summaryData[section].cells.count
    }
}

extension StatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        LabelSectionHeaderView.getView(with: viewModel.summaryData[section].title ?? "")
    }
}

extension StatsViewController: StatsViewModelDelegate {
    func didLoadSummaryData() {
        tableView.reloadData()
    }
}
