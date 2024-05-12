//
//  OffSetKey.swift
//  Slider
//
//  Created by Sarthak on 26/04/24.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce (value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
