//
//  ViewController.swift
//  GoogleMap&GooglePlacesApp
//
//  Created by Ahmed  on 1/20/18.
//  Copyright © 2018 Ahmed . All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}
class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate, UITextFieldDelegate {
    
    //var myMapview: GMSMapView!
    
    let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    var chosenPlace: MyPlace?
    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    
    override func viewDidLoad() {
        
        //myMapview = GMSMapView()
        super.viewDidLoad()
        self.title = "Home"
        self.view.backgroundColor = .white
        myMapview.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        setupViews()
        initGoogleMaps()
        
        textFieldSearch.delegate = self
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        self.locationManager.stopUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        return false
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude
        
        showPartyMarkers(lat: lat, long: long)
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        myMapview.camera = camera
        textFieldSearch.text = place.formattedAddress
        chosenPlace = MyPlace(name: place.formattedAddress!, lat: lat, long: long)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "\(place.name)"
        marker.snippet = "\(place.formattedAddress!)"
        marker.map = myMapview
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error Auto Complete \(error)")
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 31.305222, longitude: 30.299236, zoom: 17.0)
        self.myMapview.camera = camera
        self.myMapview.delegate = self
        self.myMapview.isMyLocationEnabled = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let lat = (location?.coordinate.latitude)!
        let long = (location?.coordinate.longitude)!
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        self.myMapview.animate(to: camera)
        showPartyMarkers(lat: lat, long: long)
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarkerView = marker.iconView as? MarkerCustomView else {return false}
        let img = customMarkerView.img!
        let customMarker = MarkerCustomView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
        marker.iconView = customMarker
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        guard let customMarkerView = marker.iconView as? MarkerCustomView else {return nil}
        //let data = perviewDemoData[customMarkerView.tag]
        addressView.setAddress(address: "شارع الملك الاشرف")
        return addressView
    }
 
    func showPartyMarkers(lat: Double, long: Double) {
        myMapview.clear()
        for i in 0..<3 {
            let randNum = Double(arc4random_uniform(30)/10000)
            let marker = GMSMarker()
            let customMarker = MarkerCustomView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: #imageLiteral(resourceName: "icn-nav-marvel"), borderColor: .darkGray, tag: i)
            marker.iconView = customMarker
            let randInt = arc4random_uniform(4)
            if randInt == 0 {
                marker.position = CLLocationCoordinate2D(latitude: lat + randNum, longitude: long + randNum)
            } else if randInt == 1 {
                marker.position = CLLocationCoordinate2D(latitude: lat - randNum, longitude: long + randNum)
            } else if randInt == 2 {
                marker.position = CLLocationCoordinate2D(latitude: lat - randNum, longitude: long - randNum)
            } else {
                marker.position = CLLocationCoordinate2D(latitude: lat + randNum, longitude: long + randNum)
            }
            marker.map = self.myMapview
        }
    }
 
    @objc func btnMyLocationAction() {
        let location: CLLocation? = myMapview.myLocation
        if location != nil {
            myMapview.animate(toLocation: (location?.coordinate)!)
        }
    }
    
    func setupTextField(textField: UITextField, img: UIImage) {
        textField.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = img
        let paddingView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        paddingView.addSubview(imageView)
        textField.leftView = paddingView
    }
    func setupViews() {
        view.addSubview(myMapview)
        NSLayoutConstraint.activate([
            myMapview.topAnchor.constraint(equalTo: view.topAnchor),
            myMapview.leftAnchor.constraint(equalTo: view.leftAnchor),
            myMapview.rightAnchor.constraint(equalTo: view.rightAnchor),
            myMapview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 60)
            ])
        self.view.addSubview(textFieldSearch)
        NSLayoutConstraint.activate([
            textFieldSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textFieldSearch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            textFieldSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            textFieldSearch.heightAnchor.constraint(equalToConstant: 35)
            ])
        setupTextField(textField: textFieldSearch, img: #imageLiteral(resourceName: "icn-nav-marvel"))
        
        addressView = AddressView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 190))
        
        self.view.addSubview(btnMyLocation)
        NSLayoutConstraint.activate([
            btnMyLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            btnMyLocation.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            btnMyLocation.widthAnchor.constraint(equalToConstant: 50),
            btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor)
            ])
        
        
    }
    
    
    
    lazy var myMapview: GMSMapView = {
        let v = GMSMapView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let textFieldSearch: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.placeholder = "Search for a location"
        return tf
    }()
    let btnMyLocation: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.backgroundColor = .white
        btn.setImage(#imageLiteral(resourceName: "directionIcon"), for: .normal)
        btn.clipsToBounds = true
        //btn.tintColor = UIColor.gray
        btn.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
        return btn
    }()
    
    
    var addressView: AddressView = {
        let v = AddressView()
        return v
    }()
    
    
}

