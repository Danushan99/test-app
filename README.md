# order3000-flutter

A Flutter mobile application inside the [Kolaveri Nx monorepo](https://github.com/kolaveri-labs/kadal).  
We use [Nx](https://nx.dev) minimally — just to wrap Flutter commands like `flutter run` using `npx nx run`.

---

## 🚀 Quick Start

````sh
# 1. Clone the monorepo
git clone https://github.com/kolaveri-labs/kadal.git
cd kadal

# 2. Install Dart & Flutter dependencies
npx nx run order3000-flutter:flutter:pubget

# 3. Run the Flutter app (Flutter will prompt for a device)
npx nx run order3000-flutter:dev
npx nx dev order3000-flutter

## 📦 Project Structure
kadal/
├── apps/
│   └── order3000-flutter/
│       ├── lib/
│       │   └── main.dart
│       ├── pubspec.yaml
│       ├── project.json
│       └── README.md
├── nx.json
├── package.json
└── ...


## 📋 Requirements
 Make sure the following tools are installed and set up:

 ✅ Flutter SDK (see below for FVM setup)

 ✅ Dart SDK (included with Flutter)

 ✅ Android/iOS simulator or real device

 ✅ Git and terminal access

 ✅ Commands are run from the monorepo root (/kadal)

 ✅ flutter doctor shows no issues

---

## 🛠️ Installing Flutter with FVM

We recommend using [FVM](https://fvm.app/) to manage your Flutter version.


1. **Install FVM** (if not already installed):

   ```sh
   dart pub global activate fvm
   ```

2. **Install Flutter 3.24.2 (stable) via FVM:**

   Use the default stable channel:

   ```sh
   fvm install 3.24.2
   ```

3. **Use FVM Flutter in this project:**

   ```sh
   fvm use 3.24.2
   ```

4. **Run Flutter commands via FVM:**

   ```sh
   fvm flutter doctor
   fvm flutter pub get
   fvm flutter run
   ```

> ℹ️ For a detailed guide, see this Medium blog:
> [Flutter Version Management: A Guide to Using FVM](https://medium.com/@ahmedawwan/flutter-version-management-a-guide-to-using-fvm-dbe1d269f565)
---

##👨‍💻 Maintainers
Built and maintained by Kolaveri Labs
````
