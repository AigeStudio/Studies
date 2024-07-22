//
//  Emoji_ArtApp.swift
//  Emoji Art
//
//  Created by AigeStudio on 22/7/2024.
//

import SwiftUI

@main
struct Emoji_ArtApp: App {
    @StateObject var defaultDocument = EmojiArtDocument()
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: defaultDocument)
        }
    }
}
