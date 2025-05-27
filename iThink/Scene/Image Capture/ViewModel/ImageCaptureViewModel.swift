//
//  ImageCaptureViewModel.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import Foundation
import UIKit

class ImageCaptureViewModel: ObservableObject {
    @Published var showImagePicker = false
    @Published var showCamera = false
    @Published var sourceTypeCamera: UIImagePickerController.SourceType = .camera
    @Published var sourceTypePhotoLibrary: UIImagePickerController.SourceType = .photoLibrary
    @Published var selectedImage: UIImage?
}
