//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Vegesna, Vijay V EX1 on 11/15/20.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var selectedFacility: Facility?
    @EnvironmentObject var favorites: Favorites
    
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("by \(resort.imageCredit)")
                                    .padding()
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .background(Color.black.opacity(0.75))
                                    .clipShape(Rectangle())
                            }
                        }
                    )
                Group {
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack { ResortDetailView(resort: resort) }
                            VStack { SkiDetailsView(resort: resort) }
                            Spacer()
                        } else {
                            ResortDetailView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                    Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                        if self.favorites.contains(self.resort) {
                            self.favorites.remove(self.resort)
                        } else {
                            self.favorites.add(self.resort)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
