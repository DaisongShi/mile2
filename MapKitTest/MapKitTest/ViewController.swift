//
//  ViewController.swift
//  MapKitTest
//
//  Created by Boqian Wen on 2021-09-20.
//

import UIKit
import MapKit
class ViewController: UIViewController {

    private let locationManger = CLLocationManager()
    private var currentCoordinate : CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureLocationServises()
    }

    private func configureLocationServises(){
        locationManger.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined{
            locationManger.requestAlwaysAuthorization()
        }else if status == .authorizedAlways || status == .authorizedWhenInUse{
            beginLocationUpdates(locationManager: locationManger)
        }
        
    }
    private func beginLocationUpdates(locationManager: CLLocationManager){
        mapView.showsUserLocation = true
        
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.startUpdatingLocation()
    }
    
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegion(center: coordinate,latitudinalMeters: 10000,longitudinalMeters: 10000)
        
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    private func addAnnotation(){
        
        let animalServiceAnnotation = MKPointAnnotation()
        animalServiceAnnotation.title = "Mississauga Animal Service"
        animalServiceAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.5743, longitude: -79.6476)
        
        let animalAidAnnotation = MKPointAnnotation()
        animalAidAnnotation.subtitle = "Animal Aid Foundation"
        animalAidAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.5288, longitude: -79.6740)
        
        let dogDreamAnnotation = MKPointAnnotation()
        dogDreamAnnotation.title = "A Dog's Dream Rescue"
        dogDreamAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.4675, longitude: -79.6877)
        
        let torontoAnmServiceAnnotation = MKPointAnnotation()
        torontoAnmServiceAnnotation.title = "Toronto Animal Service"
        torontoAnmServiceAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.7535, longitude: -79.4829)
        
        let petValuAnnotation = MKPointAnnotation()
        petValuAnnotation.title = "Pet Valu"
        petValuAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.6081, longitude: -79.6959)
        
        let petValuAnnotation2 = MKPointAnnotation()
        petValuAnnotation2.title = "Pet Valu"
        petValuAnnotation2.coordinate = CLLocationCoordinate2D(latitude: 43.6560793, longitude: -79.8138402)
   
        let petSmartAnnotation = MKPointAnnotation()
        petSmartAnnotation.title = "PetSmart"
        petSmartAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.6133, longitude: -79.6872)
        
        let dogGodAnnotation = MKPointAnnotation()
        dogGodAnnotation.subtitle = "Dogs & Goddesses Inc."
        dogGodAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.6258, longitude: -79.7288)
        
        mapView.addAnnotation(animalServiceAnnotation)
        mapView.addAnnotation(animalAidAnnotation)
        mapView.addAnnotation(dogDreamAnnotation)
        mapView.addAnnotation(torontoAnmServiceAnnotation)
        mapView.addAnnotation(petValuAnnotation)
        mapView.addAnnotation(petValuAnnotation2)
        mapView.addAnnotation(petSmartAnnotation)
        mapView.addAnnotation(dogGodAnnotation)
    }
}
extension ViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("Did get latesr location")
        guard let latestLocation = locations.first else { return }
        
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
            addAnnotation()
        }
        currentCoordinate = latestLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    print("status changed")
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            beginLocationUpdates(locationManager: manager)
        }
    }
}
