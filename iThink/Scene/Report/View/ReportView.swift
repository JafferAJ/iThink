//
//  ReportView.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import SwiftUI

struct ReportView: View {
    @StateObject private var viewModel = ReportViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            // MARK: - Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.indigo.opacity(0.6), Color.purple.opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // MARK: - Header Section
                VStack(spacing: 6) {
                    // Report icon
                    Image(systemName: "doc.richtext")
                        .font(.system(size: 40))
                        .foregroundColor(.white)

                    // Title text
                    Text("Balance Sheet Report")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)

                    // Subtitle with year range
                    Text("2024 - 2025")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 10)
                .padding(.horizontal)
                // Slight scaling animation for subtle emphasis
                .scaleEffect(viewModel.animate ? 1.02 : 1)
                .onAppear {
                    // Animate scale effect indefinitely with autoreverse
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                        viewModel.animate.toggle()
                    }
                }

                // MARK: - PDF Viewer Section
                PDFViewer(url: viewModel.pdfURL)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            }
            .padding(.top, 40)

            // MARK: - Back Button Overlay
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
                    .padding(.leading)
                    .padding(.top, 60)

                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ReportView()
}
