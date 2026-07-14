# Bookia Store 📚

A comprehensive, modern bookstore application, designed to provide a smooth and professional user experience. The project is built entirely using **Flutter** and follows **Clean Architecture** principles to ensure scalability, ease of testing, and long-term code maintainability.

## 🚀 Overview
Bookia Store is designed to be a "lightweight and fast" (Performance-oriented) application. The application relies on the Separation of Concerns, where business logic is completely isolated from the User Interface (UI) and Data Sources.



https://github.com/user-attachments/assets/0425ade5-e917-4cc4-a947-9225dfb28a5c



## 🛠️ Software Architecture (Clean Architecture)
The project is divided into three main layers to ensure Clean Code:

1. **Domain Layer (The Core):** Contains Entities and Use Cases. It is a completely independent layer that knows nothing about APIs or UI.
2. **Data Layer:** Responsible for fetching data from the API (using Dio) or local storage (using Hive).
3. **Presentation Layer:** Responsible for displaying data (UI) and State Management using `Cubit` (flutter_bloc).

## ✨ Key Features
* **Authentication System:** Fully custom interfaces with real-time validation.
* **Cart & Checkout Management:** Dynamic price calculations with support for multiple payment methods.
* **Professional State Management:** Using BLoC/Cubit to control data flow.
* **Local Persistence:** Using Hive to store data locally (Offline First).
* **Smart Notifications:** Instant local notifications for order confirmation and user interaction.
* **Visual Identity:** Custom animated logo designed using `CustomPainter`.

## 📂 Project Structure
We committed to splitting the project based on Features (Feature-first approach):

```text
lib/
 ┣ core/                 # Shared components between all project parts
 ┃ ┣ errors/             # Failures & Exceptions
 ┃ ┣ network/            # ApiClient, NetworkInfo
 ┃ ┣ services/           # Service Locator (GetIt)
 ┃ ┣ utils/              # AppColors, Theme, Validators
 ┃ ┗ widgets/            # CustomButton, CustomTextField (Reusable)
 ┃
 ┣ features/             # The core of the project (Each feature is independent)
 ┃ ┣ authentication/
 ┃ ┃ ┣ data/             # API calls & Data handling
 ┃ ┃ ┃ ┣ datasources/
 ┃ ┃ ┃ ┣ models/
 ┃ ┃ ┃ ┗ repositories/
 ┃ ┃ ┣ domain/           # Business Logic & Rules
 ┃ ┃ ┃ ┣ entities/
 ┃ ┃ ┃ ┣ repositories/   # Abstract classes
 ┃ ┃ ┃ ┗ usecases/
 ┃ ┃ ┗ presentation/     # UI & State Management
 ┃ ┃   ┣ cubit/
 ┃ ┃   ┣ pages/
 ┃ ┃   ┗ widgets/        # Widgets specific to this feature
 ┃ ┃
 ┃ ┣ home/               # Follows the same structure
 ┃ ┣ cart/
 ┃ ┗ saved/              # Must be inside features, not outside
 ┃
 ┗ main.dart
