//
//  LoggerViewController.swift
//  SwiftMagic
//
//  Created by Zhihui Tang on 2018-01-10.
//

import UIKit
import MessageUI


private let screenWidth = UIScreen.main.bounds.width
private let screenHeight = UIScreen.main.bounds.height
private let keyWindow = UIApplication.shared.keyWindow
private let yearLH: CGFloat = 126.0
private let sureVH: CGFloat = 44.0
private let margin: CGFloat = 10.0

class LoggerViewController: UIViewController {

    var label: UILabel = {
        let view = UILabel(frame: CGRect(x: 10, y: 20, width: 100, height: 100))
        view.text = "Hello logger"
        //view.backgroundColor = UIColor.red
        return view
    }()
    
    var button: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 50, y: 200, width: 150, height: 50)
        button.backgroundColor = UIColor.red
        button.setTitle("send email", for: .normal)
        return button
    }()    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(label)
        
        button.addTarget(self, action: #selector(sendEmail(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        /*
        let yearL = UILabel(frame: CGRect(x: margin, y: screenHeight, width: screenWidth - margin * 2, height: yearLH))
        yearL.transform = CGAffineTransform.identity
        yearL.isUserInteractionEnabled = true
        yearL.backgroundColor = .white
        yearL.textColor = UIColor.hex(hex: 0xE9ECF2)
        yearL.textAlignment = NSTextAlignment.center
        yearL.font = UIFont.systemFont(ofSize: 110)
        yearL.adjustsFontSizeToFitWidth = true
        self.view.addSubview(yearL)
        yearL.roundedCorners(cornerRadius: 10, rectCorner: UIRectCorner([.topLeft, .topRight]))

        let sureView = UIButton(type: UIButtonType.system)
        sureView.frame = CGRect(x: margin, y: yearL.y + yearL.height, width: yearL.width, height: sureVH)
        sureView.transform = CGAffineTransform.identity
        sureView.setTitle("确认", for: UIControlState.normal)
        sureView.setTitleColor(.white, for: UIControlState.normal)
        //sureView.addTarget(self, action: #selector(sureDate(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(sureView)
 */
        
    }
    
    @objc func sendEmail(_ button: UIButton) {
        //Check to see the device can send email.
        guard MFMailComposeViewController.canSendMail() == true else {
            self.showAlert(withTitle: "No email client", message: "Please configure your email client first")
            return
        }

        guard let url = Logger.shared.logUrl else { return }
        
        print("Can send email.")
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        //Set the subject and message of the email
        mailComposer.setSubject("Have you heard a swift?")
        mailComposer.setMessageBody("This is what they sound like.", isHTML: false)

        if let data = try? Data(contentsOf: url) {
            mailComposer.addAttachmentData(data, mimeType: "text/txt", fileName: "SwiftMagic.txt")
        }
        self.present(mailComposer, animated: true, completion: nil)
    }
}
    
extension LoggerViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        print("send mail result: \(result.rawValue)")
        
        switch result {
        case .cancelled:
            break
        case .sent:
            break
        case .failed:
            break
        case .saved:
            break
        }
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
