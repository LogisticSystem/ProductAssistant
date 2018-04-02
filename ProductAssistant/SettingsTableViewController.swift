//
//  SettingsTableViewController.swift
//  ProductAssistant
//
//  Created by Илья Халяпин on 02.04.2018.
//  Copyright © 2018 Ilya Khalyapin. All rights reserved.
//

import UIKit
import Alamofire

final class SettingsTableViewController: UITableViewController {
    
    // MARK: - Outlet
    
    /// Переключатель состояния активации логирования
    @IBOutlet
    private weak var logSwitch: UISwitch!
    
    /// Кнопка "Очистить товар"
    @IBOutlet
    private weak var cleanProductButton: UIButton!
    /// Индикатор активности очистки товара
    @IBOutlet
    private weak var cleanProductActivityIndicatorView: UIActivityIndicatorView! {
        willSet {
            newValue.hidesWhenStopped = true
        }
    }
    
    /// Кнопка "Очистить склад"
    @IBOutlet
    private weak var cleanStorageButton: UIButton!
    /// Индикатор активности очистки склада
    @IBOutlet
    private weak var cleanStorageActivityIndicatorView: UIActivityIndicatorView! {
        willSet {
            newValue.hidesWhenStopped = true
        }
    }
    
}


// MARK: - UIViewController

extension SettingsTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Отображение данных
        self.logSwitch.setOn(Logger.shared.isSubscribed, animated: false)
    }
    
}


// MARK: - UITableViewDelegate

extension SettingsTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


// MARK: - Action

private extension SettingsTableViewController {
    
    /// Изменено положение переключателя состояния активации логирования
    @IBAction
    func logSwitchValueChanged() {
        if self.logSwitch.isOn {
            Logger.shared.subscribe()
        } else {
            Logger.shared.unsubscribe()
        }
    }
    
    /// Нажата кнопка "Очистить товар"
    @IBAction
    func cleanProductButtonTapped() {
        cleanProduct()
    }
    
    /// Нажата кнопка "Очистить склад"
    @IBAction
    func cleanStorageButtonTapped() {
        cleanStorage()
    }
    
}


// MARK: - Приватные методы

private extension SettingsTableViewController {
    
    /// Очистка товара
    func cleanProduct() {
        self.cleanProductButton.isEnabled = false
        self.cleanProductActivityIndicatorView.startAnimating()
        
        guard let url = URL(string: "\(API.baseUrl)/products") else { return }
        Alamofire.request(url, method: .put).response { [weak self] response in
            self?.cleanProductButton.isEnabled = true
            self?.cleanProductActivityIndicatorView.stopAnimating()
        }
    }
    
    /// Очистка склада
    func cleanStorage() {
        self.cleanStorageButton.isEnabled = false
        self.cleanStorageActivityIndicatorView.startAnimating()
        
        guard let url = URL(string: "\(API.baseUrl)/storages") else { return }
        Alamofire.request(url, method: .put).response { [weak self] response in
            self?.cleanStorageButton.isEnabled = true
            self?.cleanStorageActivityIndicatorView.stopAnimating()
        }
    }
    
}
