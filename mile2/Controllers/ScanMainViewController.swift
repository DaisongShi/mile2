//
//  ScanMainViewController.swift
//  mile2
//
//  Created by Joseph Du on 2021-10-6.
//
// This is the main function of scanning part

import UIKit
import Firebase


class ScanMainViewController: UIViewController {
    
    var firstRun = true

    //call imagePredictor class
    let imagePredictor = ImagePredictor()

    //show 2 highest breeds results
    let predictionsToShow = 2

    //UI initialization
    @IBOutlet weak var startupPrompts: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!

}

extension ScanMainViewController {
    //open camera
    @IBAction func singleTap() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            present(photoPicker, animated: false)
            return
        }

        present(cameraPicker, animated: false)
    }

    //open photo library
    @IBAction func doubleTap() {
        present(photoPicker, animated: false)
    }
}

extension ScanMainViewController {
    //show image in imageView
    func updateImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

    //print result
    func updatePredictionLabel(_ message: String) {
        DispatchQueue.main.async {
            self.predictionLabel.text = message
        }

        if firstRun {
            DispatchQueue.main.async {
                self.firstRun = false
                self.predictionLabel.superview?.isHidden = false
                self.startupPrompts.isHidden = true
            }
        }
    }
    
    //open photo in image view from photo library
    func userSelectedPhoto(_ photo: UIImage) {
        updateImage(photo)
        updatePredictionLabel("Making predictions for the photo...")

        DispatchQueue.global(qos: .userInitiated).async {
            self.classifyImage(photo)
        }
    }

}

extension ScanMainViewController {
    //check the breeds
    private func classifyImage(_ image: UIImage) {
        do {
            try self.imagePredictor.makePredictions(for: image,
                                                    completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }

    //call imagePrediction Handler
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        guard let predictions = predictions else {
            updatePredictionLabel("No predictions. (Check console log.)")
            return
        }

        let formattedPredictions = formatPredictions(predictions)

        let predictionString = formattedPredictions.joined(separator: "\n")
        updatePredictionLabel(predictionString)
    }

    //formatPredictions as breed name + breed percentage
    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
            //the breed of dog
            var name = prediction.classification

            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }
            
            

            return "\(name) - \(prediction.confidencePercentage)%"
        }

        return topPredictions
    }
}
