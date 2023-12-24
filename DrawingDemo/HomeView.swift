//
//  HomeView.swift
//  DrawingDemo
//
//  Created by Shah Md Imran Hossain on 23/12/23.
//

import PencilKit
import SwiftUI

struct DrawingView: UIViewRepresentable {
    // to capture drawing for saving into albums...
    @Binding var canvas: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
}

struct HomeView: View {
    @State private var canvas = PKCanvasView()
    
    var body: some View {
        NavigationStack {
            DrawingView(canvas: $canvas)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
}
