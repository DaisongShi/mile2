//
//  RealObjectScanningController.swift
//  mile2
//
//  Created by Kirito24K Shi on 021-03-17.
//

import UIKit
import AVKit
import Vision
import CoreML
import AVFoundation

class RealObjectScanningController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var viewLable: UILabel!
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateLable(newLable: "new lable")
        
        //Start the Camera
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
    
        // get back camera as Video Capture Device
        guard let captureDevice = AVCaptureDevice.default(for: .video)
            else { self.quickErr(myLine: #line,inputStr: "") ; return }
        
        try? captureDevice.lockForConfiguration()
        captureDevice.activeVideoMinFrameDuration =  CMTimeMake(value: 1, timescale: 2)
        captureDevice.activeVideoMaxFrameDuration =  CMTimeMake(value: 1, timescale: 2)
            captureDevice.unlockForConfiguration()
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice)
            else { self.quickErr(myLine: #line,inputStr: "") ; return }
        captureSession.addInput(input)
        captureSession.startRunning()
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer?.frame.size = self.innerView.frame.size
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.innerView.layer.addSublayer(self.previewLayer!)
        self.previewLayer?.frame = view.frame
    
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//        label.center = CGPoint(x: 160, y: 285)
//        label.textAlignment = .center
//        label.text = "I'am a test label"
//        self.view.addSubview(label)
//        label.text = ""
        
        //get access to video frames
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VideoQueue"))
        captureSession.addOutput(dataOutput)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.previewLayer?.frame.size = self.innerView.frame.size
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //print("Camera was able to capture a frame ", Date())
        
        guard let pixcelBuffer:CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
            else { self.quickErr(myLine: #line,inputStr: "") ; return }
        guard let model =  try? VNCoreMLModel(for: Resnet50().model)
            else { self.quickErr(myLine: #line,inputStr: "") ; return }
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            //check err
            //print(finishedReq.results)
        guard let results = finishedReq.results as? [VNClassificationObservation]
            else { self.quickErr(myLine: #line,inputStr: "") ; return }
        guard let firstObservation = results.first
            else { self.quickErr(myLine: #line,inputStr: "") ; return }
        var myMessage = ""
        var myConfident = 0
            
            if (firstObservation.confidence > 0.2 ) {
                myConfident = Int ( firstObservation.confidence * 100 )
                let myIdentifier = firstObservation.identifier.split(separator: ",")
                myMessage = "I am \(myConfident) % confidence this object is : \(myIdentifier[0]) "
            } else {
                myMessage = "I am not confidence to detect this object"
            }
            
            print(myMessage)
            self.updateLable(newLable: myMessage)
            if ( myConfident >= 97 ){
                self.readyMe(myText: myMessage, myLang: "en_EN")
            }
        }

        // Anaylize image
        try? VNImageRequestHandler(cvPixelBuffer: pixcelBuffer, options: [:]).perform([request])
    }

    func readyMe(myText :String , myLang : String ) {
        let uttrace = AVSpeechUtterance(string: myText )
        uttrace.voice = AVSpeechSynthesisVoice(language: myLang)
        uttrace.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(uttrace)
    }
    
    
    func quickErr(myLine: Int , inputStr : String = "" ) {
        print("===> Guard Error \(inputStr) :\n    file:\(#file)\n    line:\(myLine)\n    function:\(#function) ")
    }
    
    func updateLable(newLable: String){
        
        DispatchQueue.main.async { // Correct
            self.viewLable?.text = "[ " + newLable + " ]"
        }
    }
    
}

