//
//  ViewController.swift
//  RXPiOS
//

import UIKit
import RXPiOS

class ViewController: UIViewController, HPPManagerDelegate {

	@IBOutlet weak var result_textView: UITextView!

	@IBOutlet weak var payButton: UIButton!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
		self.activityIndicator.isHidden = true

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func payButtonAction(_ sender: AnyObject) {

//        let hppManager = HPPManager()
//		hppManager.isEncoded = true
//		hppManager.HPPRequestProducerURL = URL(string: "https://www.example.com/HppRequestProducer")
//        hppManager.HPPURL = URL(string: "https://pay.sandbox.realexpayments.com/pay")
//		hppManager.HPPResponseConsumerURL = URL(string: "https://www.example.com/HppResponseConsumer")
//		self.activityIndicator.isHidden = false
//
//		activityIndicator.startAnimating()
//		self.payButton.isEnabled = false
//		activityIndicator.hidesWhenStopped = true
//        hppManager.delegate = self
//        hppManager.presentViewInViewController(self)

		self.payByLink()
    }

	//MARK: - Pay By Link
	func payByLink() {

		let hppManager = HPPManager()
		//hppManager.HPPRequestProducerURL = URL(string: "https://www.example.com/HppRequestProducer")
		hppManager.HPPResponseConsumerURL = URL(string: "https://www.example.com/HppResponseConsumer")
		hppManager.merchantId = "heartlandgpsandbox"
		hppManager.account = "3dsecure"
		hppManager.orderId = "N6qsk4kYRZihmPrTXWYS6g"
		hppManager.HPPURL = URL(string: "https://pay.sandbox.realexpayments.com/pay")
		hppManager.amount = "1001"
		hppManager.currency = "EUR"
		hppManager.sharedSecret = "secret"

		self.activityIndicator.isHidden = false
		activityIndicator.startAnimating()
		self.payButton.isEnabled = false
		activityIndicator.hidesWhenStopped = true
		hppManager.delegate = self
		hppManager.loadPayByLink(self)
	}


    //MARK: - HPPManagerDelegate
	func HPPManagerCompletedWithResult(_ result: Dictionary <String, Any>) {
        // success
        print(result)
		DispatchQueue.main.async() {
			self.DisplayResult(result: NSString(format: "%@", result) as String);
		}
	}

    func HPPManagerFailedWithError(_ error: NSError?) {
        // error
        if let hppError = error {
            print(hppError.localizedDescription)
			self.DisplayResult(result: hppError.localizedDescription)
        }
    }

    func HPPManagerCancelled() {
        // cancelled
        print("Cancelled by user.")
		self.DisplayResult(result: "Cancelled by User")
    }

	func DisplayResult(result : String)
	{
		DispatchQueue.main.async {

			self.result_textView.text = result
			self.result_textView.textAlignment = .left
			self.activityIndicator.stopAnimating();
			self.payButton.isEnabled = true;
		}
	}
}
