# MultiBank iOS Demo

I am Shehzad Sulaiman, Software Engineer, and this is my SwiftUI training/demo project for MultiBank.

## About This Project

This app is built around a real-time market feed experience:
- 25 stock symbols in a live feed
- websocket echo-based updates (`wss://ws.postman-echo.com/raw`)
- feed + symbol details navigation
- light/dark theme support

## Tech Stack

- SwiftUI + (100%)
- MVVM
- Combine
- URLSession and WebSocket
- XCTest + UI Tests

## Project Structure

```
multibank
├─ App
├─ Core
├─ Features
│  └─ Market
│     ├─ Data
│     ├─ Domain
│     └─ Presentation
├─ Assets
├─ multibankTests
└─ multibankUITests
```

## Implemented Features

- Live feed screen with start/stop control
- Connection status indicator
- Sorted prices (highest first)
- Symbol details screen
- Shared stream state between feed/details - proper use for @EnvironmentObject avoid duplicate calls
- Custom app icon + designed launch screen - (my passion)
- Theme toggle from footer - Appstorage and @State

## Run

1. Open `multibank.xcodeproj`
2. Select iOS Simulator
3. Run (`Cmd + R`)

## Tests

- Unit tests: `multibankTests`
- UI tests: `multibankUITests`
