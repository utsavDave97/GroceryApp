//
//  PayViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-11-23.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit
import Stripe

class PayViewController: UIViewController
{
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()
    lazy var payButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.setTitle("Pay", for: .normal)
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [cardTextField, payButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 2),
        ])

        // Do any additional setup after loading the view.
    }
    
    @objc func pay()
    {
        // Create an STPCardParams instance
        let cardParams = STPCardParams()
        cardParams.number = cardTextField.cardNumber
        cardParams.expMonth = cardTextField.expirationMonth
        cardParams.expYear = cardTextField.expirationYear
        cardParams.cvc = cardTextField.cvc

        // Pass it to STPAPIClient to create a Token
        STPAPIClient.shared().createToken(withCard: cardParams) { token, error in
            guard let token = token else {
                // Handle the error
                return
            }
            let tokenID = token.tokenId
            // Send the token identifier to your server...
            
            StripeClient.shared.completeCharge(with: token, amount: Int(CheckoutCart.shared.total)) { (result) in
                switch result {
                // 1
                case .success:

                  let alertController = UIAlertController(title: "Congrats",
                                        message: "Your payment was successful!",
                                        preferredStyle: .alert)
                  let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                  })
                  alertController.addAction(alertAction)
                  self.present(alertController, animated: true)
                // 2
                case .failure(let error):
                    print("ERROR HERE" + error.localizedDescription)
                    let alertController = UIAlertController(title: "FAILED",
                                          message: "Your payment didnt went through!",
                                          preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .destructive, handler: { _ in
                      self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                }
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
