# 🌌 Character Explorer (Rick and Morty)

A high-performance, **Glassmorphic** Flutter application that allows users to explore, edit, and favorite characters from the Rick and Morty universe. This project demonstrates modern UI/UX principles, reactive state management with GetX, and robust local data persistence using Hive.

---

## ✨ Pro Features

* **Glassmorphism 2.0**: Immersive frosted-glass panels utilizing `BackdropFilter` and custom `BoxDecoration` for a premium, modern aesthetic.
* **Persistent Favorites**: A dedicated Hive-backed favorite system that ensures your top picks remain saved across app restarts.
* **Smart Caching**: Implements a "Cache-First" strategy where local user edits are prioritized and protected from being overwritten by fresh API calls.
* **Data Vault & Reset**: Maintains an immutable original data state in memory, allowing users to instantly revert manual edits back to the official API data.
* **Infinite Pagination**: Optimized scroll listeners with `Dio` to pre-fetch character pages seamlessly.

---

## 📸 Screenshots

<p align="center">
  <img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot01.png" width="24%" alt="Home Screen" />
  <img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot02.png" width="24%" alt="Detail View" />
  <img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot03.png" width="24%" alt="Edit Mode" />
</p>

<p align="center">
   <img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot04.png" width="24%" alt="Glassy UI" />
  <img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot05.png" width="24%" alt="Favorites" />
  <img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot06.png" width="24%" alt="Search & Filter" />
  <img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot07.png" width="24%" alt="Persistence Test" />
</p>

---

## 🛠️ Architecture Decisions

### **State Management: GetX**
Chosen for its decoupled dependency injection and reactive performance.
* **Reasoning**: It enables real-time UI updates (like the favorite toggle or live edits) across different screens without the boilerplate of Bloc or the context-dependency of Provider.

### **Local Persistence: Hive**
Utilized as a high-speed NoSQL database for mobile.
* **Multi-Box Strategy**: Uses separate Hive boxes for `CharacterModel` (data) and `int` (favorite IDs) to manage state efficiently.
* **TypeAdapters**: Custom adapters for Enums (`Status`, `Gender`) and Models ensure complex objects are serialized correctly.

---

## 🚀 Installation & Setup

```bash
# 1. Clone the repository
git clone [https://github.com/RashedKhanSezan/character_explorer.git](https://github.com/RashedKhanSezan/character_explorer.git)

# 2. Navigate to project folder
cd character_explorer

# 3. Install dependencies
flutter pub get

# 4. Generate Hive Adapters
# This project uses hive_generator. Run this to generate the .g.dart files:
flutter pub run build_runner build --delete-conflicting-outputs

# 5. Run the app
flutter run
