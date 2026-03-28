# 🌌 Character Explorer (Rick and Morty)

A high-performance, **Glassmorphic** Flutter application that allows users to explore, edit, and favorite characters from the Rick and Morty universe. This project demonstrates modern UI/UX principles, reactive state management, and robust local data persistence.


---

## ✨ Pro Features

* **Glassmorphism 2.0**: Immersive frosted-glass panels using `BackdropFilter` and dynamic `BoxDecoration` with 158-alpha transparency.
* **The "Vault" Logic**: Dual-layer data management. An immutable `originalApiData` list acts as a "source of truth" to allow instant reverting of any manual edits.
* **Reactive Filtering**: High-performance `filteredCharacters` getter that combines search queries and status filters in real-time.
* **Persistent Customization**: Edits are saved to **Hive**, ensuring your custom character lore stays intact even after a full app restart.
* **Infinite Pagination**: Smart scroll listener that pre-fetches the next page of characters 200 pixels before the end of the list.

---

## 🛠️ Architecture Decisions

### **State Management: GetX**
Utilized **GetX** for its high-performance dependency injection and reactive state handling.
* **Why?** It allows us to update the UI (like the Favorites icon or Reset button) across multiple screens simultaneously without the complexity of `Provider` or the boilerplate of `Bloc`.
* **Navigation**: GetX handles our snackbars and glassy dialogs cleanly without needing `BuildContext` inside the controller logic.

### **Storage Approach: Hive**
**Hive** was chosen as the primary NoSQL database for local persistence.
* **Why?** It is lightning fast and written entirely in Dart.
* **Implementation**: Every API fetch caches new characters immediately. When a user "Edits" a character, we overwrite that specific entry in the Hive box using the character's unique ID as the key.

---

## 🚀 Setup Instructions

## Clone the repository
git clone [https://github.com/your-username/character_explorer.git](https://github.com/your-username/character_explorer.git)

## Navigate to project folder
cd character_explorer

## Install dependencies
flutter pub get

## Generate Hive Adapters
To generate the .g.dart files: flutter pub run build_runner build --delete-conflicting-outputs

## 🔗 Screenshots
<p align="center">
<img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot01.png" width="20%" />
<img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot02.png" width="20%" />
<img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot03.png" width="20%" />
</p>

<p align="center">
<img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot04.png" width="20%" />
<img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot05.png" width="20%" />
<img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot06.png" width="20%" />
<img src="https://raw.githubusercontent.com/RashedKhanSezan/character_explorer/main/assets/images/Screenshot07.png" width="20%" />
</p>
