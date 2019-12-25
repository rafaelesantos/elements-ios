//
//  MoreInfoViewController.swift
//  Elementos
//
//  Created by Rafael Escaleira on 24/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import SafariServices

class MoreInfoViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discoveredByLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var atomicMassLabel: UILabel!
    @IBOutlet weak var atomicNumberLabel: UILabel!
    @IBOutlet weak var electroConfigurationLabel: UILabel!
    @IBOutlet weak var wikipediaButton: UIButton!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var phaseLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var elementInfoView: UIView!
    
    var element: ElementsCodable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoryLabel.text = self.element?.category?.uppercased()
        self.nameLabel.text = self.element?.name?.lowercased().capitalized
        self.discoveredByLabel.text = self.element?.discovered_by?.lowercased().capitalized
        self.summaryLabel.text = self.element?.summary
        self.symbolLabel.text = self.element?.symbol
        self.atomicMassLabel.text = String(format: "Atomic Mass: %.3f", self.element?.atomic_mass ?? 0).replacingOccurrences(of: ".", with: ",")
        self.atomicNumberLabel.text = String(format: "Atomic Number: %d", self.element?.number ?? 0)
        self.electroConfigurationLabel.text = self.element?.electron_configuration
        self.periodLabel.text = String(format: "%d", self.element?.period ?? 0)
        self.phaseLabel.text = self.element?.phase?.lowercased().capitalized
        
        self.symbolLabel.backgroundColor = UIColor.hexStringToUIColor(hex: self.element?.color ?? UIColor(named: "elements")!.toHexString)
        self.wikipediaButton.setTitleColor(self.symbolLabel.backgroundColor, for: .normal)
        self.categoryLabel.textColor = self.symbolLabel.backgroundColor
        self.shareButton.tintColor = self.symbolLabel.backgroundColor
    }
    
    // MARK: Actions
    
    @IBAction func wikipediaButtonAction(_ sender: UIButton) {
        
        guard let url = URL(string: self.element?.source ?? "") else { return }
        let controller = SFSafariViewController(url: url)
        controller.modalPresentationStyle = .popover
        guard let popoverController = controller.popoverPresentationController else { return }
        popoverController.sourceView = sender
        popoverController.sourceRect = sender.bounds
        popoverController.permittedArrowDirections = .any
        popoverController.delegate = self
        
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonAction(_ sender: UIButton) {
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(self.nameLabel.text ?? "Info").png")
        guard let _ = try? self.createImage(view: self.elementInfoView).write(to: path) else { return }
        let activityController = UIActivityViewController(activityItems: [path], applicationActivities: [])
        self.present(activityController, animated: true, completion: nil)
    }
    
    private func createImage(view: UIView) -> Data {
        
        var image = UIImage();
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 10.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        image = UIGraphicsGetImageFromCurrentImageContext()!;
        
        UIGraphicsEndImageContext();
        
        let imageView = UIImageView(frame: CGRect(x: 30, y: 30, width: image.size.width, height: image.size.height))
        imageView.image = image
        
        let viewNew = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + 60, height: image.size.height + 60))
        viewNew.addSubview(imageView)
        
        UIGraphicsBeginImageContextWithOptions(viewNew.frame.size, false, 10.0)
        viewNew.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        image = UIGraphicsGetImageFromCurrentImageContext()!;
        
        UIGraphicsEndImageContext();
        
        return image.pngData() ?? Data()
    }
}
