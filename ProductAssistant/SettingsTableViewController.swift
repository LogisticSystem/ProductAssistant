//
//  SettingsTableViewController.swift
//  ProductAssistant
//
//  Created by Илья Халяпин on 02.04.2018.
//  Copyright © 2018 Ilya Khalyapin. All rights reserved.
//

import UIKit

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
            newValue.isHidden = true
        }
    }
    
    /// Кнопка "Очистить склад"
    @IBOutlet
    private weak var cleanStorageButton: UIButton!
    /// Индикатор активности очистки склада
    @IBOutlet
    private weak var cleanStorageActivityIndicatorView: UIActivityIndicatorView! {
        willSet {
            newValue.isHidden = true
        }
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
    func logSwitchValueChanged() { }
    
    /// Нажата кнопка "Очистить товар"
    @IBAction
    func cleanProductButtonTapped() { }
    
    /// Нажата кнопка "Очистить склад"
    @IBAction
    func cleanStorageButtonTapped() { }
    
}
