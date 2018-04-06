//
//  MainTableViewController.swift
//  ProductAssistant
//
//  Created by Илья Халяпин on 02.04.2018.
//  Copyright © 2018 Ilya Khalyapin. All rights reserved.
//

import UIKit
import Alamofire

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
    private weak var createProductButton: UIButton!
    /// Индикатор активности создания товара
    @IBOutlet
    private weak var createProductActivityIndicatorView: UIActivityIndicatorView! {
        willSet {
            newValue.hidesWhenStopped = true
        }
    }
    
    
    // MARK: - Приватные свойства
    
    /// URL метода создания товара
    private lazy var createProductUrl: URL = {
        guard let url = URL(string: "\(API.baseUrl)/products/new") else { preconditionFailure() }
        return url
    }()
    
    /// Таймер
    private weak var timer: Timer?
    
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
    func stateSwitchValueChanged() {
        self.intervalStepper.isEnabled = !self.stateSwitch.isOn
        self.intervalStepper.superview?.alpha = self.stateSwitch.isOn ? 0.6 : 1
        
        self.countStepper.isEnabled = !self.stateSwitch.isOn
        self.countStepper.superview?.alpha = self.stateSwitch.isOn ? 0.6 : 1
        
        if self.stateSwitch.isOn {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
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
    func createButtonTapped() {
        createProduct()
    }
    
}


// MARK: - Приватные методы

private extension MainTableViewController {
    
    /// Запуск таймера
    func startTimer() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.interval), repeats: true) { timer in
            guard timer.isValid else { return }
            
            DispatchQueue.main.async {
                DispatchQueue.concurrentPerform(iterations: self.count) { [weak timer] _ in
                    guard timer?.isValid ?? false else { return }
                    
                    Alamofire.request(self.createProductUrl, method: .get).resume()
                }
            }
        }
    }
    
    /// Остановка таймера
    func stopTimer() {
        self.timer?.invalidate()
    }
    
    /// Создание товара
    func createProduct() {
        self.createProductButton.isEnabled = false
        self.createProductActivityIndicatorView.startAnimating()
        
        Alamofire.request(self.createProductUrl, method: .get).response { [weak self] response in
            self?.createProductButton.isEnabled = true
            self?.createProductActivityIndicatorView.stopAnimating()
        }
    }
    
}
