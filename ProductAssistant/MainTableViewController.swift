//
//  MainTableViewController.swift
//  ProductAssistant
//
//  Created by Илья Халяпин on 02.04.2018.
//  Copyright © 2018 Ilya Khalyapin. All rights reserved.
//

import UIKit

final class MainTableViewController: UITableViewController {
    
    // MARK: - Outlet
    
    /// Переключатель состояния
    @IBOutlet
    private weak var stateSwitch: UISwitch!
    /// Значение "Интервал"
    @IBOutlet
    private weak var intervalValueLabel: UILabel!
    /// Итератор "Интервал"
    @IBOutlet
    private weak var intervalStepper: UIStepper!
    /// Значение "Количество"
    @IBOutlet
    private weak var countValueLabel: UILabel!
    /// Итератор "Количество"
    @IBOutlet
    private weak var countStepper: UIStepper!
    
    /// Кнопка "Создать"
    @IBOutlet
    private weak var createButton: UIButton!
    
}


// MARK: - Приватные свойства

private extension MainTableViewController {
    
    /// Интервал
    var interval: Int {
        return Int(self.intervalStepper.value)
    }
    
    /// Количество
    var count: Int {
        return Int(self.countStepper.value)
    }
    
}


// MARK: - UIViewController

extension MainTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка
        self.intervalValueLabel.text = "\(self.interval)"
        self.countValueLabel.text = "\(self.count)"
    }
    
}


// MARK: - UITableViewDelegate

extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


// MARK: - Action

private extension MainTableViewController {
    
    /// Изменено положение переключателя состояния
    @IBAction
    func stateSwitchValueChanged() { }
    
    /// Изменено значение итератора "Интервал"
    @IBAction
    func intervalStepperValueChanged() {
        self.intervalValueLabel.text = "\(self.interval)"
    }
    
    /// Изменено значение итератора "Количество"
    @IBAction
    func countStepperValueChanged() {
        self.countValueLabel.text = "\(self.count)"
    }
    
    /// Нажата кнопка "Создать"
    @IBAction
    func createButtonTapped() { }
    
}
