# PhotoPulse - iOS and Android application

PhotoPulse is a Flutter-based mobile application for iOS and Android, developed specifically for my software engineering master's studies. The project was a key part of two courses: Advanced Mobile Programming, which delved into complex mobile development techniques and emerging technologies, and Advanced Application Development Based on Design Templates, focusing on sophisticated design patterns. Emphasis was placed on adhering to SOLID principles, ensuring that the app's design was robust, maintainable, and scalable. These courses provided deep insights into efficient app development strategies and the practical application of theoretical concepts.


![logo](https://github.com/NoaTubic/drecipe/assets/62752909/7ea1635f-49a4-4f99-be11-a0de81be9dd2)
![mockups](https://github.com/NoaTubic/drecipe/assets/62752909/d12a684e-5a5e-4559-883c-f64d5ea7401b)

## 🌟 Features

### Authentication
- Login, register, verify email, reset password, log out, delete account, and login without an account.

### Subscription Management
- Various subscription packages (Free, Pro, Gold) with different features and limits, such as upload size and daily limits.
- Track and change their package once a day.

### Create/Edit Post with Customization
- Upload/edit posts, each consisting of a photo (from camera or gallery), title, description, hashtags, and location.
- Offers image processing options (resize, format change) during upload.

### Browsing Posts
- Users can browse all uploaded posts.

### Post Download Options
- Download posts in their original format or with applied filters and modifications.

### Location Tagging
- Enables users to tag and share the location of their posts.

### Permission Handling
- Manages app permissions for accessing the camera, gallery, and location services.

### Map Integration
- Incorporates map functionality for location-based features.

### Search Posts with Filters
- Search for posts based on filters like hashtags, size, upload date, author, and location.

### Administrator Capabilities
- Administrators can modify user profiles and packages, view user actions and statistics, and manage any user's posts.

### Action Logging
- All user actions are logged, detailing who performed the operation and when. This is achieved through the use of Firebase Functions, which efficiently track and record user interactions in real-time, ensuring a robust and secure logging system.


### Profile
- Change username, email, subscription package, password, language, and profile image.

## 🛠️ Architecture & Libraries
- **Architecture**: The app follows Clean Architecture principles and integrates with Flutter Riverpod. 
The data layer manages data retrieval and storage, interfacing with databases and remote servers while maintaining a loose coupling with the domain layer for better organization and maintainability. The domain layer encompasses the business logic and core functionalities, acting as a bridge between the data layer and the presentation layer. Finally, the presentation layer is focused on user interface and interaction, utilizing widgets and other UI components to create an engaging and responsive user experience.
- **State Management**: Managed with Riverpod.
- **Authentication**: Implemented using Firebase Auth.
- **Remote Database**: Cloud Firestore.
- **Photo Storage**: Firebase Storage.
- **Firebase Functions**: Utilized for server-side logic, such as action logging, user management tasks, and automating back-end processes.
- **Local Database**: Isar.
- **Map**: `flutter_map`.
- **Environment Management**: Utilizes `flavorizr` for different build environments and `envied` for environment variables.
- **Navigation**: Handled by `go_router`.
- **UI Enhancements**: Contains animations to enrich the user experience.

## 🚀 Getting Started
1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Connect with your **Firebase** project.
5. Choose the desired build environment with `flavorizr`.
6. Run `flutter run` to start the application.
