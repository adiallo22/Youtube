//
//  CouponPage.swift
//  GifAPart
//
//  Created by Abdul Diallo on 8/11/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

private let cellIdentifier = "albumCell"

class CouponPage: UIViewController {
    
    //MARK: - properties
    
    private var tableView = UITableView()
    
    private let dealEndpoint = "https://gaa.giftapart.com/api/deals"
    
    private var searchController = UISearchController.init(searchResultsController: nil)
    
    private var coupons : [Coupon] = [] {
        didSet { tableView.reloadData() }
    }
    
    private var filteredCoupons : [Coupon] = [] {
        didSet { tableView.reloadData() }
    }
    
    private var bookmarkedCoupons : [Coupon] = [] {
        didSet { print(bookmarkedCoupons.count) }
    }
    
    private var listOfFollowedProviders: [String] = [] {
        didSet { print(listOfFollowedProviders.count)}
    }
    
    private var isInSearchMode : Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    private let feature = PromoFeauture()
    
    //MARK: - init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configTableView()
        configSearchController()
        configUIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchDeals()
    }
    
}

//MARK: - API

extension CouponPage {
    
    fileprivate func fetchDeals() {
        DealService.shared.fetchDeals(withEndpoint: dealEndpoint) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let coupons):
                self.coupons = coupons
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

//MARK: - helpers and configuration

extension CouponPage {
    
    fileprivate func configUIView() {
        view.addSubview(feature)
        feature.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                       left: view.leftAnchor,
                       bottom: tableView.topAnchor,
                       right: view.rightAnchor)
    }
    
    fileprivate func configTableView() {
        view.addSubview(tableView)
        tableView.anchor(left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor)
        tableView.dimension(height: (view.frame.size.height / 3) * 1.4)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(CouponCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    fileprivate func configSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.customSearchBar()
        definesPresentationContext = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
}

//MARK: - delegate and data source

extension CouponPage : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isInSearchMode ? filteredCoupons.count : coupons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CouponCell
        cell.coupon = isInSearchMode ? filteredCoupons[indexPath.row] : coupons[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}

//MARK: - UISearchResultsUpdating

extension CouponPage : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searched = searchController.searchBar.text else { return }
        filteredCoupons = coupons.filter({ $0.display_name.contains(searched) })
    }
    
}

//MARK: - ButtonActionDelegate

extension CouponPage : ButtonActionDelegate {
    
    func likePressed(_ cell: CouponCell) {
        guard let deal_id = cell.coupon?.deal_id else { return }
        let endpoint = dealEndpoint+"/\(deal_id)"
        DealService.shared.actionOnDeal(type: .like, of: endpoint, completion: { result in
            switch result {
            case .success(_):
                cell.coupon?.isLiked.toggle()
            case .failure(let error):
                print(error.description)
            }
        })
    }
    
    func dislikePressed(_ cell: CouponCell) {
        guard let deal_id = cell.coupon?.deal_id else { return }
        let endpoint = dealEndpoint+"/\(deal_id)"
        DealService.shared.actionOnDeal(type: .dislike, of: endpoint, completion: { result in
            switch result {
            case .success(_):
                cell.coupon?.isDisiked.toggle()
            case .failure(let error):
                print(error.description)
            }
        })
    }
    
    func followPressed(_ cell: CouponCell) {
        guard let coupon = cell.coupon else { return }
        let endpoint = dealEndpoint+"/\(coupon.deal_id)"
        DealService.shared.actionOnDeal(type: .follow, of: endpoint, completion: { [weak self] result in
            switch result {
            case .success(_):
                cell.coupon?.isFollowed.toggle()
                if cell.coupon?.isFollowed == true {
                    self?.listOfFollowedProviders.insert(coupon.display_name, at: 0)
                } else {
                    self?.listOfFollowedProviders.remove(at: 0)
                }
            case .failure(let error):
                print(error.description)
            }
        })
    }
    
    func bookmarkPressed(_ cell: CouponCell) {
        guard let coupon = cell.coupon else { return }
        let endpoint = dealEndpoint+"/\(coupon.deal_id)"
        DealService.shared.actionOnDeal(type: .bookmark, of: endpoint, completion: { [weak self] result in
            switch result {
            case .success(_):
                cell.coupon?.isBookmarked.toggle()
                if cell.coupon?.isBookmarked == true {
                    self?.bookmarkedCoupons.insert(coupon, at: 0)
                } else {
                    self?.bookmarkedCoupons.remove(at: 0)
                }
            case .failure(let error):
                print(error.description)
            }
        })
    }
    
}
