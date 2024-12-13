//
//  HomeViewController.swift
//  NearbyApp NLW
//
//  Created by Emanuel on 10/12/2024.
//

import Foundation
import UIKit
import MapKit

class HomeViewController: UIViewController {
    private var places: [Place] = []
    private let homeView = HomeView()
    private var homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        homeView.mapView.delegate = self
        defineInitialLocation()
    }
    
    private func defineInitialLocation() {
        let initialLocation = CLLocationCoordinate2D(latitude: -23.561187293883442, longitude: -46.656451388116494)
        homeView.mapView.setRegion(MKCoordinateRegion(center: initialLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var identifier = "CustomPin" // 56 min
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKAnnotationView
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if let pinImage = UIImage(named: "mapPin") {
                annotationView?.image = pinImage
                annotationView?.frame.size = CGSize(width: 28, height: 32)
            }
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? PlaceAnnotation else { return }
    }
}
