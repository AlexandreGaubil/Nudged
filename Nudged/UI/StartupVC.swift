//
//  StarupVC.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-26.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

class StartupVC: UIViewController {
    
    //MARK: Labels
    @IBOutlet weak var welcome_lb: UILabel!
    @IBOutlet weak var thank_you_lb: UILabel!
    @IBOutlet weak var please_lb: UILabel!
    @IBOutlet weak var size_house_lb: UILabel!
    @IBOutlet weak var inhabitants_house_lb: UILabel!
    @IBOutlet weak var kind_house_lb: UILabel!
    
    //MARK: Buttons and text fields
    @IBOutlet weak var continue_button: UIButton!
    @IBOutlet weak var house_size: UITextField!
    @IBOutlet weak var number_of_inhabitants: UITextField!
    @IBOutlet weak var type_of_house: UISegmentedControl!
    
    @IBAction func dismiss_keyboards_gesture(_ sender: Any) {
        house_size.resignFirstResponder()
        number_of_inhabitants.resignFirstResponder()
    }
    
    @IBAction func continue_button(_ sender: Any) {
        
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: house_size.text ?? "a")) && house_size.text != "" {
            if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: number_of_inhabitants.text ?? "a")) && number_of_inhabitants.text != "" {
                let defaults = UserDefaults.standard
                defaults.set(Int(number_of_inhabitants.text ?? "1") ?? 1, forKey: UserDefaultsKeys.number_of_inhabitants)
                defaults.set(Double(house_size.text ?? "100") ?? 100.0, forKey: UserDefaultsKeys.house_size)
                switch type_of_house.selectedSegmentIndex {
                case 0: defaults.set("apartment", forKey: UserDefaultsKeys.type_of_house)
                case 1: defaults.set("separate_house", forKey: UserDefaultsKeys.type_of_house)
                case 2: defaults.set("house_sharing_walls", forKey: UserDefaultsKeys.type_of_house)
                default: break
                }
                defaults.set(true, forKey: UserDefaultsKeys.logged_in)
                self.dismiss(animated: true, completion: nil)
            } else {
                self.present(create_alert_view(title: "Please enter a valid number of inhabitants", message: nil, okButtonTitle: "OK"), animated: true, completion: nil)
            }
        } else {
            self.present(create_alert_view(title: "Please enter a valid house size", message: nil, okButtonTitle: "OK"), animated: true, completion: nil)
        }
    }
    
    //MARK: Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.logged_in) == true {
            self.dismiss(animated: true, completion: nil)
        } else {
            for element in [welcome_lb, thank_you_lb, please_lb, size_house_lb, inhabitants_house_lb, kind_house_lb, continue_button, house_size, number_of_inhabitants, type_of_house] {
                element?.isHidden = true
                element?.alpha = 0.0
            }
            
            continue_button.make_button_inverted()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.welcome_lb.fadeIn()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.thank_you_lb.fadeIn()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.please_lb.fadeIn()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                self.size_house_lb.fadeIn()
                self.house_size.fadeIn()
                self.inhabitants_house_lb.fadeIn()
                self.number_of_inhabitants.fadeIn()
                self.kind_house_lb.fadeIn()
                self.type_of_house.fadeIn()
                self.continue_button.fadeIn()
            }
            
        }
    }
}
