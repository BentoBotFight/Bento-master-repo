# bento-controller-private
This repository contains the Flutter mobile client code for the Bentobot remote control app,
as well as the code for each of the Bentobot's that listen to commands from the app.


## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
  - [Firebase Configuration](#firebase-configuration)
  - [bento_client](#bento_client)
  - [bento_arena](#bento_arena)
- [Directory Structure](#directory-structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview
This repository contains two primary components for real-time control and monitoring of the Bento Bot:

- **bento_arena**: A Flutter application (web, desktop, and mobile) providing a user interface to send commands and visualize bot status.
- **bento_client**: Python scripts and a Dart client library that interface with Firebase to process and relay movement and weapon controls in real time.

## Prerequisites
- Flutter SDK (>=3.4.3 <4.0.0)
- Dart SDK (bundled with Flutter)
- Python 3.8+
- Firebase CLI (for deployment)
- tmux (optional, for running multiple Python sessions)

## Setup

### Firebase Configuration
1. Create or select a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
2. Enable Firestore, Realtime Database, and Hosting.
3. Configure FlutterFire in `bento_arena`:
   ```bash
   cd bento_arena
   flutterfire configure
   ```
4. Authenticate and initialize Hosting:
   ```bash
   firebase login
   firebase init hosting
   ```

### bento_client
```bash
cd bento_client/cyclop
python3 -m venv myenv      # or your preferred virtual environment
# macOS/Linux
env/bin/activate
# Windows PowerShell
myenv\Scripts\Activate.ps1
pip install -r requirements_no_versions.txt
```
Run processors in separate terminals:
```bash
tmux new -s movement
python realtime.py

# In a second session:
tmux new -s weapon
python realtime2.py
```
See `bento_client/README.md` for more details.

### bento_arena
```bash
cd bento_arena
flutter pub get
```
**Development** (local/debug):
```bash
flutter run -d chrome
```
**Production** (web release):
```bash
flutter build web --web-renderer canvaskit --release
firebase deploy
```

## Directory Structure
```
.
├── bento_arena/          # Flutter front-end application
│   ├── lib/              # Dart source code and UI
│   ├── assets/           # Static assets (images, SVGs)
│   ├── web/              # Web entry points
│   └── pubspec.yaml      # Dependencies and metadata
├── bento_client/         # Python and Dart client modules
│   ├── client.dart       # Dart listener for Firebase RT Database
│   └── cyclop/           # Python real-time processors
│       ├── realtime.py
│       ├── realtime2.py
│       └── requirements_no_versions.txt
└── README.md             # This documentation
```

## Usage
1. Start the Python processors (`bento_client`) to feed commands and sensor data into Firebase.
2. Launch the Flutter app (`bento_arena`) to interact with the Bento Bot UI in real time.
3. Use on-screen controls to send movement or weapon commands; monitor live updates.

## Contributing
1. Fork this repository.
2. Create a feature branch: `git checkout -b feature/your-feature`.
3. Commit your changes: `git commit -m "Add your feature description"`.
4. Push to GitHub: `git push origin feature/your-feature`.
5. Open a Pull Request and request reviews.
