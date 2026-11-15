//
//  ContentView.swift
//  CoupleTracker
//
//  Created by petre bagashvili on 14.11.26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                if let location = locationManager.location {
                    
                    Map(
                        initialPosition: .region(
                            MKCoordinateRegion(
                                center: location.coordinate,
                                span: MKCoordinateSpan(
                                    latitudeDelta: 0.01,
                                    longitudeDelta: 0.01
                                )
                            )
                        )
                    ) {
                        
                        Annotation(
                            "You ❤️",
                            coordinate: location.coordinate
                        ) {
                            ZStack {
                                Circle()
                                    .fill(.pink)
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.white)
                                    .font(.title2)
                            }
                        }
                    }
                    
                    VStack {
                        Spacer()
                        
                        LocationCard(location: location)
                            .padding()
                    }
                    
                } else {
                    
                    VStack(spacing: 20) {
                        
                        Image(systemName: "location.circle.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(.pink)
                        
                        Text("Your Location")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Allow location access to see yourself on the map.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        
                        Button {
                            locationManager.requestPermission()
                        } label: {
                            Text("Allow Location")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.pink)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        .padding(.horizontal, 40)
                    }
                }
            }
            .navigationTitle("❤️ Together")
        }
    }
}

struct LocationCard: View {
    
    let location: CLLocation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Circle()
                    .fill(.green)
                    .frame(width: 10, height: 10)
                
                Text("Location Active")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "location.fill")
                    .foregroundStyle(.pink)
            }
            
            Divider()
            
            Text("Latitude")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text("\(location.coordinate.latitude)")
                .font(.system(.body, design: .monospaced))
            
            Text("Longitude")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text("\(location.coordinate.longitude)")
                .font(.system(.body, design: .monospaced))
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ContentView()
}
