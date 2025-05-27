//
//  APIService.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import SwiftUI

struct APIServiceView: View {
    @StateObject var viewModel = APIServiceViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.indigo.opacity(0.8), Color.purple.opacity(0.9)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 4)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.25), lineWidth: 1)
                            )
                    }
                    Spacer()
                    Text("API Service View")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Spacer()
                }
                if viewModel.items.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "tray")
                            .font(.system(size: 48))
                            .foregroundColor(Color.white.opacity(0.25))
                        Text("No items available")
                            .font(.title3)
                            .foregroundColor(Color.white.opacity(0.25))
                        Spacer().frame(height: 55)
                        DashboardButton(title: "Import Now", systemImage: "square.and.arrow.down") {
                            viewModel.importFromAPI()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else {
                    List {
                        ForEach(viewModel.items, id: \.self) { item in
                            VStack(alignment: .leading, spacing: 8) {
                                // Temporary state for editing
                                      @State var editedName = item.name
                                      
                                      TextField("Enter name", text: Binding(
                                          get: { editedName },
                                          set: {
                                              editedName = $0
                                              item.name = $0
                                              viewModel.update(item, newName: item.name)
                                          }
                                      ))
                                      .textFieldStyle(RoundedBorderTextFieldStyle())
                                      .font(.headline)
                                if let dataString = item.data,
                                   let decoded = try? JSONDecoder().decode([String: String].self, from: Data(base64Encoded: dataString) ?? Data()) {
                                    ForEach(decoded.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                        HStack {
                                            Text(key + ":")
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.secondary)
                                            Spacer()
                                            Text(value)
                                                .font(.caption)
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                            .listRowBackground(Color.clear)
                        }
                        .onDelete { indexSet in
                            indexSet.map { viewModel.items[$0] }.forEach(viewModel.delete)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                Spacer()
            }
            .padding()
            .onAppear {
                viewModel.loadItems()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    APIServiceView()
}
