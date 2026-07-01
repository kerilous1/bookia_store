# Bookia Store 📚

A modern, highly scalable book store application built with Flutter. The project strictly adheres to **Clean Architecture** principles and **SOLID** guidelines, ensuring maintainability, testability, and a seamless developer experience. 



https://github.com/user-attachments/assets/d2c7c80b-57c0-4608-9494-04057d0ff043


## ✨ Key Features

### Authentication (Implemented)
* **Custom User Interface:** Fully custom-built UI components (avoiding hard-coded default widgets) for precise design control and superior UX.
* **Real-time Validation:** Reactive form validation for emails, passwords, and password confirmations.
* **Secure API Integration:** Robust communication with backend services handling proper serialization/deserialization.
* **Advanced Error Handling:** Graceful error catching from the server side, mapping JSON errors to user-friendly UI snackbars without state leaks.

## 🛠️ Tech Stack & Architecture

* **Framework:** Flutter
* **Architecture:** Clean Architecture (Domain, Data, Presentation layers)
* **State Management:** Cubit (flutter_bloc)
* **Networking:** Dio
* **Dependency Injection:** GetIt (Service Locator)
* **Routing:** Native Flutter Navigator

## 📂 Project Structure

The project is modularized by features, isolating the core logic from UI and external data sources:

```text
lib/
 ┣ core/
 ┃ ┣ errors/              # Failure classes
 ┃ ┣ network/             # API constants and configurations
 ┃ ┣ services/            # Service Locator (GetIt) setup
 ┃ ┣ utils/               # App colors, validators, etc.
 ┃ ┗ widgets/             # Reusable custom UI components (CustomButton, CustomTextField)
 ┣ features/
 ┃ ┗ auth/
 ┃   ┣ data/              # API Calls, Models, and Repository Implementations
 ┃   ┃ ┣ datasources/
 ┃   ┃ ┣ models/
 ┃   ┃ ┗ repositories/
 ┃   ┣ domain/            # Entities, Use Cases, and Repository Contracts (Abstracts)
 ┃   ┃ ┣ entities/
 ┃   ┃ ┣ repositories/
 ┃   ┃ ┗ usecases/
 ┃   ┗ presentation/      # UI and State Management (Cubit)
 ┃     ┣ cubit/
 ┃     ┗ pages/           # LoginPage, RegisterPage
 ┗ main.dart              # App entry point
