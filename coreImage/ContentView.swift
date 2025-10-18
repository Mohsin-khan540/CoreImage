//
//  ContentView.swift
//  coreImage
//
//  Created by Mohsin khan on 18/10/2025.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image : Image?
    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()
        }
            .onAppear(perform: loadImage)
    }
    func loadImage(){
        let inputImage = UIImage(resource: .araf)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        
        let Currentfilter = CIFilter.sepiaTone()
        
        Currentfilter.inputImage = beginImage
        let amount = 1.0
        
        let inputKeys = Currentfilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            Currentfilter.setValue(amount, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { Currentfilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { Currentfilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = Currentfilter.outputImage else {return}
        guard let cgImage = context.createCGImage(outputImage , from: outputImage.extent)
        else{return}
        
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
        
    }
}

#Preview {
    ContentView()
}
