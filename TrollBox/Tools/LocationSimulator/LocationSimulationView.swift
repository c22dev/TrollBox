//
//  LocationSimulationView.swift
//  TrollTools
//
//  Created by Constantin Clerc on 21.12.2022.
//

import Map
import MapKit
import SwiftUI

struct EquatableCoordinate: Equatable {
    var coordinate: CLLocationCoordinate2D
    
    static func ==(lhs: EquatableCoordinate, rhs: EquatableCoordinate) -> Bool {
        lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}

struct LocationSimulationView: View {
    struct Location: Identifiable {
        var coordinate: CLLocationCoordinate2D
        var id = UUID()
    }
    @State var locations: [Location] = []
    @State private var long = ""
    @State private var lat = ""
    @State var directions: MKDirections.Response? = nil
    @State private var region = MKCoordinateRegion(.world)
    @State private var bookmarks: [String: (Double, Double)] = UserDefaults.standard.dictionary(forKey: "bookmarks") as? [String: (Double, Double)] ?? [:]
    @State private var currentListName = ""
    @State private var tappedCoordinate: EquatableCoordinate? = nil
    
    var body: some View {
    VStack {
        TextField("Enter latitude", text: $lat)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        
        TextField("Enter longitude", text: $long)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        let latitudeValue = Double(lat)
        let longitudeValue = Double(long)
        
        HStack {
            Button(action: {
                LocSimManager.startLocSim(location: .init(latitude: latitudeValue!, longitude: longitudeValue!))
                locations = [.init(coordinate: .init(latitude: latitudeValue!, longitude: longitudeValue! )),.init(coordinate: .init(latitude: latitudeValue!, longitude: longitudeValue!)),]
                calculateDirections()
                print("LOCSIM ENABLED for Latitude: \(lat), Longitude: \(long)")
            }) {
                Text("Apply")
            }
//            Button(action: {
//                let alert = UIAlertController(title: "Add to Bookmark", message: "Enter bookmark name", preferredStyle: .alert)
//                alert.addTextField { (textField) in
//                    textField.placeholder = "List Name"
//                }
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//                    let textField = alert?.textFields![0]
//                    self.currentListName = textField?.text ?? ""
//                    let latitudeValue = Double(lat)
//                    let longitudeValue = Double(long)
//                    self.bookmarks[self.currentListName] = (latitudeValue!, longitudeValue!)
//                    UserDefaults.standard.set(self.bookmarks, forKey: "bookmarks")
//                }))
//                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
//            }) {
//                Text("Add to Bookmark")
//            }
//            Button(action: {
//                            let alert = UIAlertController(title: "Bookmarks", message: "Choose a list", preferredStyle: .alert)
//                            for (name, _) in bookmarks {
//                                alert.addAction(UIAlertAction(title: name, style: .default, handler: { (_) in
//                                    self.currentListName = name
//                                    let (lat, long) = self.bookmarks[self.currentListName]!
//                                    self.lat = "\(lat)"
//                                    self.long = "\(long)"
//                                    self.locations = [.init(coordinate: .init(latitude: lat, longitude: long ))]
//                                    calculateDirections()
//                                    LocSimManager.startLocSim(location: .init(latitude: lat, longitude: long))
//                                }))
//                            }
//                            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
//                        }) {
//                            Text("Bookmarks")
//                        }
        }
        Button(action: {
            LocSimManager.stopLocSim()
            print("ohno")
        }) {
            Text("Stop")
        }
        CustomMapView(tappedCoordinate: $tappedCoordinate)
            .onAppear {
                CLLocationManager().requestAlwaysAuthorization()
            }
    }
    .onChange(of: tappedCoordinate) { newValue in
                if let coordinate = newValue {
                    lat = String(coordinate.coordinate.latitude)
                    long = String(coordinate.coordinate.longitude)
                }
            }
 }
        func calculateDirections() {
            guard locations.count >= 2 else { return }
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: locations[0].coordinate))
            request.destination = MKMapItem(placemark: .init(coordinate: locations[1].coordinate))
            request.transportType = .automobile
            
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                self.directions = response
    //            region = .init(response?.routes.first?.polyline.boundingMapRect)
            }
        }
    }

struct CustomMapView: UIViewRepresentable {
    @Binding var tappedCoordinate: EquatableCoordinate?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let tapRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(tapRecognizer)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: CustomMapView
        
        init(_ parent: CustomMapView) {
            self.parent = parent
        }
        
        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            let mapView = gesture.view as! MKMapView
            let touchPoint = gesture.location(in: mapView)
            let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            parent.tappedCoordinate = EquatableCoordinate(coordinate: coordinate)
        }
    }
}



struct LocationSimulationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSimulationView()
    }
}
