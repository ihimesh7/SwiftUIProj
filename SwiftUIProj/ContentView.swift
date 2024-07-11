//
//  ContentView.swift
//  SwiftUIProj
//
//  Created by Himesh on 2/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var uniVM = UniversityVM()
    @StateObject var sleepStatsVM = SleepStatsVM()
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
        UINavigationBar.appearance().barTintColor = UIColor(Color.blue.opacity(0.3))
        UINavigationBar.appearance().backgroundColor = UIColor(Color.blue.opacity(0.3))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color.blue
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 40)
                border
            }
            ZStack {
                NavigationView {
                    if #available(iOS 15.0, *) {
                        universityList15
                            .onAppear {
                                uniVM.combineGetAPI(.post)
                            }
                            .navigationTitle("Universities List")
                            .navigationBarTitleDisplayMode(.automatic)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    EditButton()
                                }
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    if uniVM.isAnimating {
                                        ProgressView()
                                    } else {
                                        Button {
                                            uniVM.combineGetAPI(.get)
                                        } label: {
                                            Image(systemName: "arrow.clockwise")
                                        }
                                    }
                                }
                            }
                    } else {
                        // Fallback on earlier versions
                        universityList
                            .onAppear {
                                uniVM.combineGetAPI(.post)
                            }
                            .navigationTitle("Universities List")
                            .navigationBarTitleDisplayMode(.automatic)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    EditButton()
                                }
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    if uniVM.isAnimating {
                                        ProgressView()
                                    } else {
                                        Button {
                                            uniVM.combineGetAPI(.get)
                                        } label: {
                                            Image(systemName: "arrow.clockwise")
                                        }
                                    }
                                }
                            }
                    }
                }
                .alert(isPresented: $uniVM.presentAlert) {
                    .init(title: Text(AppInfo.AppName),
                          message: Text(uniVM.errorMsg),
                          primaryButton: Alert.Button.cancel(),
                          secondaryButton: Alert.Button.default(
                            Text("Retry"),
                            action: {
                                uniVM.combineGetAPI(.get)
                            }))
                }
                if uniVM.isAnimating && uniVM.universitiesList.isEmpty {
                    spinner
                }
            }
        }
    }
    //MARK: - Actions
    private func onDelete(offset: IndexSet) {
        uniVM.universitiesList.remove(atOffsets: offset)
    }
    private func onMove(_ from: IndexSet, _ to: Int) {
        uniVM.universitiesList.move(fromOffsets: from, toOffset: to)
    }
    
    
}
extension ContentView {
    var universityList: some View {
        List {
            ForEach(uniVM.universitiesList) { university in
                VStack(alignment: .leading, spacing: 8) {
                    Text(university.country?.rawValue ?? "")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    HStack {
                        Text(university.name ?? "")
                            .font(.body)
                            .fontWeight(.bold)
                        Text(university.stateProvince ?? "")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                }
            }
            .onDelete(perform: onDelete)
            .onMove(perform: onMove)
        }
    }
    @available(iOS 15.0, *)
    var universityList15: some View {
        List {
            ForEach(uniVM.universitiesList) { university in
                VStack(alignment: .leading, spacing: 8) {
                    Text(university.country?.rawValue ?? "")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    HStack {
                        Text(university.name ?? "")
                            .font(.body)
                            .fontWeight(.bold)
                        Text(university.stateProvince ?? "")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                }
            }
            .onDelete(perform: onDelete)
            .onMove(perform: onMove)
        }
        .refreshable {
            uniVM.combineGetAPI(.get)
        }
    }
    var spinner: some View {
        VStack {
            ProgressView()
            //                        .padding(.top, -20.0)
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(3)
            Text("Loading")
                .padding()
                .font(.system(size: 24))
        }
    }
    var border: some View {
        VStack(spacing: 0) {
            Spacer()
            ZStack {
                HStack {
                    Button {
                        print("Back")
                    } label: {
                        Text("Back")
                            .foregroundColor(.red)
                            .padding(.leading)
                    }
                    Spacer()
                }
                Text("Custom Navigation Bar")
                    .bold()
            }
            Spacer()
            Color.blue
                .frame(height: 2)
        }
        .frame(height: 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

