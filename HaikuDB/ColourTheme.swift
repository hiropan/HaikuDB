//
//  ColorTheme.swift
//  HaikuDB
//
//  Created by Yuhei Hirose on 2025/05/22.
//

import SwiftUI

let standardTheme = ColourTheme(
    name: "Standard",
    lightColours: ThemeColours(
        background: .white,
        primary: .black,
        accent: .blue,
        secondary: .gray
    ),
    darkColours: ThemeColours(
        background: .black,
        primary: .white,
        accent: .blue,
        secondary: .gray
    )
)

let japandiTheme = ColourTheme(
    name: "Japandi",
    lightColours: ThemeColours(
        background: Color(red: 0.97, green: 0.95, blue: 0.90),
        primary: Color(red: 0.20, green: 0.18, blue: 0.15),
        accent: Color(red: 0.65, green: 0.45, blue: 0.30),
        secondary: Color.gray.opacity(0.6)
    ),
    darkColours: ThemeColours(
        background: Color(red: 0.12, green: 0.11, blue: 0.10),
        primary: Color(red: 0.92, green: 0.90, blue: 0.85),
        accent: Color(red: 0.75, green: 0.55, blue: 0.35),
        secondary: Color.gray.opacity(0.4)
    )
)

let mountainTheme = ColourTheme(
    name: "Mountain",
    lightColours: ThemeColours(
        background: Color(red: 0.95, green: 0.98, blue: 1.00), // snow white
        primary: Color(red: 0.15, green: 0.25, blue: 0.30),    // pine green
        accent: Color(red: 0.50, green: 0.60, blue: 0.70),     // slate blue
        secondary: Color(red: 0.30, green: 0.35, blue: 0.40)   // stone grey
    ),
    darkColours: ThemeColours(
        background: Color(red: 0.07, green: 0.10, blue: 0.15),
        primary: Color(red: 0.85, green: 0.90, blue: 0.95),
        accent: Color(red: 0.55, green: 0.65, blue: 0.75),
        secondary: Color(red: 0.45, green: 0.50, blue: 0.55)
    )
)

let pastelTheme = ColourTheme(
    name: "Pastel",
    lightColours: ThemeColours(
        background: Color(red: 1.00, green: 0.99, blue: 0.97),
        primary: Color(red: 0.45, green: 0.45, blue: 0.45),
        accent: Color(red: 0.90, green: 0.70, blue: 0.85),  // lilac
        secondary: Color(red: 0.70, green: 0.85, blue: 0.90) // mint blue
    ),
    darkColours: ThemeColours(
        background: Color(red: 0.15, green: 0.15, blue: 0.15),
        primary: Color(red: 0.95, green: 0.95, blue: 0.95),
        accent: Color(red: 0.80, green: 0.60, blue: 0.75),
        secondary: Color(red: 0.60, green: 0.75, blue: 0.80)
    )
)

let noirTheme = ColourTheme(
    name: "Noir",
    lightColours: ThemeColours(
        background: Color.white,
        primary: Color.black,
        accent: Color(red: 0.90, green: 0.00, blue: 0.20),
        secondary: Color.gray
    ),
    darkColours: ThemeColours(
        background: Color.black,
        primary: Color.white,
        accent: Color(red: 1.00, green: 0.25, blue: 0.40),
        secondary: Color.gray.opacity(0.7)
    )
)

let sakuraTheme = ColourTheme(
    name: "Sakura",
    lightColours: ThemeColours(
        background: Color(red: 1.00, green: 0.98, blue: 0.98), // pale pink
        primary: Color(red: 0.40, green: 0.35, blue: 0.35),    // cherry wood
        accent: Color(red: 0.95, green: 0.70, blue: 0.80),     // blossom pink
        secondary: Color(red: 0.75, green: 0.85, blue: 0.70)   // leaf green
    ),
    darkColours: ThemeColours(
        background: Color(red: 0.10, green: 0.08, blue: 0.10),
        primary: Color(red: 0.90, green: 0.88, blue: 0.90),
        accent: Color(red: 0.90, green: 0.50, blue: 0.65),
        secondary: Color(red: 0.55, green: 0.70, blue: 0.55)
    )
)

let momijiTheme = ColourTheme(
    name: "Momiji",
    lightColours: ThemeColours(
        background: Color(red: 1.00, green: 0.98, blue: 0.95), // paper-like cream
        primary: Color(red: 0.45, green: 0.25, blue: 0.25),    // deep red-brown
        accent: Color(red: 0.85, green: 0.35, blue: 0.20),     // maple red
        secondary: Color(red: 0.90, green: 0.75, blue: 0.55)   // warm ochre
    ),
    darkColours: ThemeColours(
        background: Color(red: 0.08, green: 0.06, blue: 0.04),
        primary: Color(red: 0.95, green: 0.90, blue: 0.88),
        accent: Color(red: 0.90, green: 0.40, blue: 0.30),
        secondary: Color(red: 0.70, green: 0.55, blue: 0.40)
    )
)

let matchaTheme = ColourTheme(
    name: "Matcha",
    lightColours: ThemeColours(
        background: Color(red: 0.97, green: 0.98, blue: 0.94), // matcha cream
        primary: Color(red: 0.30, green: 0.35, blue: 0.25),    // dark green
        accent: Color(red: 0.65, green: 0.80, blue: 0.60),     // tea green
        secondary: Color(red: 0.80, green: 0.85, blue: 0.75)   // soft grey-green
    ),
    darkColours: ThemeColours(
        background: Color(red: 0.10, green: 0.12, blue: 0.08),
        primary: Color(red: 0.90, green: 0.95, blue: 0.90),
        accent: Color(red: 0.70, green: 0.85, blue: 0.65),
        secondary: Color(red: 0.50, green: 0.55, blue: 0.45)
    )
)

let allThemes: [ColourTheme] = [
    standardTheme,
    japandiTheme,
    mountainTheme,
    pastelTheme,
    noirTheme,
    sakuraTheme,
    momijiTheme,
    matchaTheme
]
