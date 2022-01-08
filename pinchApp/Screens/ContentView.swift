//
//  ContentView.swift
//  pinchApp
//
//  Created by Mario Senatore on 03/01/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimating : Bool = false
    @State private var imageScale : CGFloat = 1
    @State private var imageOffset : CGSize = .zero
    @State private var isDraweOpen : Bool = false
    
    let pages : [Page] = pageData
    @State private var pageIndex : Int = 1
    
    func resetImageState(){
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    func currentImage() -> String{
        return pages[pageIndex - 1].imageName
    }
    
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color.clear
                
                Image(currentImage())
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 0 : 1)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                
                    .scaleEffect(imageScale)
                //MARK: TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        
                        if imageScale == 1{
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        }else{
                            resetImageState()
                            //                            withAnimation(.spring()){
                            //                                imageScale = 1
                            //                            } this code has been substitute to the func
                        }
                        
                    }) //END TAP GESTURE
                //MARK: DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                withAnimation(.linear(duration: 1)){
                                    imageOffset = value.translation
                                }
                            }
                            .onEnded{ _ in
                                if imageScale <= 1{
                                    resetImageState()
                                    //                                withAnimation(.spring()){
                                    //                                    imageScale = 1
                                    //                                    imageOffset = .zero
                                    //                                } this code has been substitute to the func
                                }
                                
                            }
                        
                    )
                    .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                            withAnimation(.linear(duration: 1)){
                                if imageScale >= 1 && imageScale <= 5{
                                    imageScale = value
                                }else if imageScale > 5{
                                    imageScale = 5
                                }
                            }
                            
                        }
                        .onEnded{ _ in
                            if imageScale > 5 {
                                imageScale = 5
                            }else if imageScale <= 1{
                                resetImageState()
                            }
                            
                        }
                    )
                
                
            } // end Zstack
            //MARK: -  INFOPANEL
            .overlay(
                InfoPannelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                ,alignment: .top
                
                
            )
            //MARK: - CONTROLS
            .overlay(
                Group{
                    HStack(spacing:20){
                        Button{
                            withAnimation(.spring()){
                                if imageScale < 5{
                                    imageScale += 1
                                    
                                    if imageScale > 5{
                                        imageScale = 5
                                    }
                                }
                            }
                            
                       
                        }label: {
                            Image(systemName: "plus.magnifyingglass")
                                .font(.system(size: 36))
                        }
                        
                        
                        Button{
                            withAnimation(.spring()){
                                if imageScale > 1{
                                    imageScale -= 1
                                    
                                    if imageScale <= 1{
                                        resetImageState()
                                    }
                                }
                            }
                        }label: {
                            ControllImageView(icon: "minus.magnifyingglass")
                           
                        }
                        
                        Button{
                            resetImageState()
                          
                        }label: {
                            ControllImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                            
                        }
                       
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 0 : 1)
//                    .frame(maxWidth: 120)
                   
                    
                }
                    .padding(.bottom, 30),
                alignment: .bottom
                    
            )
            
            //MARK: - DRAWER
            .overlay(
                HStack(spacing:12){
                    Image(systemName: isDraweOpen ? "chevron.compact.right" : "chevron.compact.left" )
                    
                        .resizable()
                        .scaledToFit()
                        .frame(height:40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture(perform: {
                            withAnimation(.easeOut){
                                isDraweOpen.toggle()
                            }
                        })
                    
                    //MARK : - THUMBNAILS
                    ForEach(pages){ item in
                        Image(item.thumbnailName)
                            
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .cornerRadius(10)
                            .shadow(radius: 4)
                            .opacity(isDraweOpen ? 1 : 0)
                            .animation(.easeOut(duration:0.5), value: isDraweOpen)
                            .onTapGesture(perform: {
                                isAnimating = false
                                pageIndex = item.id
                            })
                    }
                    Spacer()
                    
                    
                }
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 0 : 1)
                    .padding(.top,UIScreen.main.bounds.height / 12)
                    .offset(x: isDraweOpen ? 20 : 215)
                    .frame(width: 260),alignment: .topTrailing
            
            
            )
            
            .navigationTitle("Pinch & zoom")
            .navigationBarTitleDisplayMode(.inline)
            onAppear(perform: {
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
            })
            
              
        } // END NAVvIEW
        .navigationViewStyle(.stack)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().preferredColorScheme(.dark)
                
            
        }
    }
}
