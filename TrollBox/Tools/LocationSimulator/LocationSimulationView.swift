//
//  LocationSimulationView.swift
//  TrollTools
//
//  Created by Constantin Clerc on 21.12.2022.
//

import Map
import MapKit
import SwiftUI

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
    
    var body: some View {
        TextField("Enter latitude", text: $lat)
            .textFieldStyle(RoundedBorderTextFieldStyle())

        TextField("Enter longitude", text: $long)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        let latitudeValue = Double(lat)
        let longitudeValue = Double(long)
        Button(action: {
            LocSimManager.startLocSim(location: .init(latitude: latitudeValue!, longitude: longitudeValue!))
            locations = [.init(coordinate: .init(latitude: latitudeValue!, longitude: longitudeValue! )),.init(coordinate: .init(latitude: latitudeValue!, longitude: longitudeValue!)),]
            calculateDirections()
            print("LOCSIM ENABLED YEAH")
        }) {
            Text("Apply")
        }
        Button(action: {
            LocSimManager.stopLocSim()
            print("ohno")
        }) {
            Text("Stop")
        }
        Map(
            coordinateRegion: $region,
            informationVisibility: .default.union(.userLocation),
            interactionModes: [.all],
            annotationItems: locations,
            annotationContent: { location in
                ViewMapAnnotation(coordinate: location.coordinate) {
                    Color.accentColor
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                }
            },
            overlays: directions?.routes.map { $0.polyline } ?? [],
            
            overlayContent: { overlay in
                RendererMapOverlay(overlay: overlay) { (mapView, overlay) in
                    guard let polyline = overlay as? MKPolyline else {
                        return MKOverlayRenderer(overlay: overlay)
                    }
                    let renderer = MKPolylineRenderer(polyline: polyline)
                    renderer.lineWidth = 4
                    renderer.strokeColor = .red
                    return renderer
                }
            }
        )
        .onAppear {
            CLLocationManager().requestAlwaysAuthorization()
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

struct LocationSimulationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSimulationView()
    }
}
