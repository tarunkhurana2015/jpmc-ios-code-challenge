//
//  RemoteImage.swift
//  Weather
//
//  Created by Tarun Khurana on 2/21/24.
//

import Foundation
import SwiftUI

struct AyncImageView: View {
    @ObservedObject var imageLoader: ImageLoader

    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            ProgressView()
        }
    }
}
