//
//  ControllImageView.swift
//  pinchApp
//
//  Created by Mario Senatore on 04/01/22.
//

import SwiftUI

struct ControllImageView: View {
    let icon : String
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

struct ControllImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControllImageView(icon: "plus.magnifyingglass")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
