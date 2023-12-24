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
    @Binding var isDraw: Bool
    @Binding var type: PKInkingTool.InkType
    @Binding var color: Color
    
    var ink : PKInkingTool {
        return PKInkingTool(type, color: UIColor(color))
    }
    
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDraw ? ink : eraser
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // updating tool whenever main view updates
        uiView.tool = isDraw ? ink : eraser
    }
}

struct HomeView: View {
    @State private var canvas = PKCanvasView()
    @State private var isDraw = true
    @State private var color:Color = .black
    @State private var toolInkType: PKInkingTool.InkType = .pen
    @State private var colorPicker = false
    
    var body: some View {
        NavigationStack {
            DrawingView(canvas: $canvas, isDraw: $isDraw, type: $toolInkType, color: $color)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            // saving image
                            saveImage()
                        }, label: {
                            Image(systemName: "square.and.arrow.down.fill")
                                .font(.title)
                        })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(spacing: 10) {
                            Button(action: {
                                // eraser tool
                                isDraw = false
                            }, label: {
                                if isDraw {
                                    Image(systemName: "pencil")
                                        .font(.title)
                                } else {
                                    Image(systemName: "eraser.fill")
                                        .font(.title)
                                }
                            })
                            
                            Menu {
                                // Color Picker
                                Button(action: {
                                    colorPicker.toggle()
                                }, label: {
                                    Label {
                                        Text("Color")
                                    } icon: {
                                        Image(systemName: "eyedropper.full")
                                    }
                                })
                                
                                Button(action: {
                                    isDraw = true
                                    toolInkType = .pencil
                                    
                                }, label: {
                                    Label {
                                        Text("Pencil")
                                    } icon: {
                                        Image(systemName: "pencil")
                                    }
                                })
                                
                                Button(action: {
                                    isDraw = true
                                    toolInkType = .pen
                                }, label: {
                                    Label {
                                        Text("Pen")
                                    } icon: {
                                        Image(systemName: "pencil.tip")
                                    }
                                })
                                
                                Button(action: {
                                    isDraw = true
                                    toolInkType = .marker
                                }, label: {
                                    Label {
                                        Text("Marker")
                                    } icon: {
                                        Image(systemName: "highlighter")
                                    }
                                })
                                
                            } label: {
                                Image(systemName: "ellipsis")
                                    .rotationEffect(.degrees(90))
                                    .font(.title)
                            }
                            
                        }
                    }
                }
                .sheet(isPresented: $colorPicker) {
                    ColorPicker("Pick Color", selection: $color)
                        .padding()
                }
            
        }
    }
}

// MARK: - Methods
extension HomeView {
    func saveImage() {
        // getting image from canvas
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        
        // saving to album
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

#Preview {
    HomeView()
}
