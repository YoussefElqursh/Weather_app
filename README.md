# Table of Contents

1.Overview
2.Features
3.Technologies Used
4.Setup Instructions
5.Usage
6.Folder Structure
7.Contributing
8.License

https://github.com/YoussefElqursh/Weather_app/blob/master/assets/images/weather_app.png?raw=true # Weather_app

The Weather App is a Flutter-based application that provides real-time weather updates for any location. It uses the device's GPS or allows users to manually enter a city name to fetch weather data. The app also supports offline functionality by displaying the last known weather data when there is no internet connection. Additionally, it sends periodic notifications with the latest weather information.

## Features

- Real-Time Weather Updates : Fetches current weather data using the user's location or a searched city.
- Offline Support : Displays the last known weather data when the device is offline.
- Notifications : Sends daily notifications at 7:00 AM with the latest weather information.
- Dynamic UI : Displays weather animations (e.g., sunny, rainy, snowy) based on the weather condition.
- Search Functionality : Allows users to search for weather updates by city name.
- Background Fetching : Automatically fetches weather data every 6 hours in the background using WorkManager.
- Responsive Design : Adapts to different screen sizes with a scalable UI.
  
## Installation

- Clone this repository: [Clone this repo](git clone https://github.com/yourusername/your-repository-name.git)
- Navigate to the project directory: [cd your-repository-name]
- Install the dependencies: [flutter pub get]
- Run the app: [flutter run]

## Requirements
###Setup Instructions
1. Clone the Repository
    - [git clone https://github.com/your-repo/weather-app.git] 
    - [cd weather-app]
2. Install Dependencies
Run the following command to install all required dependencies:
    - flutter pub get

## Usage

1. Search for Weather
  - Enter a city name in the search bar and press the search icon to fetch weather data.
  - Alternatively, press the location icon to fetch weather data for your current location.
2. View Weather Details
  - The app displays the current temperature, weather condition, sunrise/sunset times, and maximum/minimum temperatures.
  - Dynamic animations (e.g., sunny, rainy) are displayed based on the weather condition.
3. Notifications
  -The app sends a notification at 7:00 AM daily with the latest weather information.
  -Notifications include the area name, temperature, and weather condition.
4. Offline Mode
  -If there is no internet connection, the app displays the last known weather data.

#### Prerequisites
- Flutter SDK (v3.x or higher)
- Dart SDK (v2.19 or higher)
- Android Studio or VS Code
- A valid API key from a weather service provider (e.g., OpenWeatherMap)

## Folder Structure

weather_app/
├── lib/
│   ├── bloc/               # Bloc files for state management
│   ├── models/             # Data models (e.g., Weather)
│   ├── screens/            # Screens of the app (e.g., HomeScreen)
│   ├── services/           # Services (e.g., SharedPreferences, Notifications)
│   ├── widget/             # Reusable widgets
│   ├── main.dart           # Entry point of the app
│   └── secret.dart         # File to store sensitive data (e.g., API key)
├── assets/                 # Assets like animations and images
├── android/                # Android-specific configuration
├── ios/                    # iOS-specific configuration
└── README.md               # This file

## Technologies

- Flutter : Cross-platform framework for building the app.
- Bloc : State management library for handling app state.
- WorkManager : Background task scheduling for periodic weather fetching.
- Geolocator : Fetches the user's current location.
- Shared Preferences : Persists the last known weather data locally.
- Flutter Local Notifications : Handles notifications for weather updates.
- Lottie Animations : Displays engaging weather animations.
- Weather API : Fetches real-time weather data from a third-party API.

## Contributing

### We welcome contributions! If you’d like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch (git checkout -b feature/YourFeature).
3. Make your changes.
4. Commit your changes (git commit -m 'Add some feature').
5. Push to the branch (git push origin feature/YourFeature).
6. Open a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📦 APK Download
https://drive.google.com/file/d/1MEtbcUGewCwJDhhCHHf6K5xXOyVOcS6p/view?usp=sharing
