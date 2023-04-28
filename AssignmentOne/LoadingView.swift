//
//  LoadingView.swift
//  AssignmentOne
//
//  Created by wsq on 15/4/2023.
//

import SwiftUI
/**
 # Loading View
 
 This page is showing the loading process to users containing "Loading" text and a animition of loading while loding data. When finishing loading data, this view will be turn off.
 
 - Tag: LoadingViewExample
 
 ## Example
 
 LoadingView()
 */
struct LoadingView: View {
    var body: some View {
        VStack{
            //when first open app, this page will be shown entil the data loding is finished
            Text("Loading...")
                .font(.largeTitle)
                .foregroundColor(.primary)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
