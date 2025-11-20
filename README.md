# SkyScope 🌤️

SkyScope is a Flutter-based weather application that provides real-time weather updates, hourly forecasts, 
and detailed weather insights for your current location. The app uses **OpenWeatherMap API** and 
integrates device location to deliver accurate weather information instantly.
---
## Features

- Get **current weather** for your location.  
- **Hourly forecast** for the day.  
- Detailed weather parameters: **humidity, wind speed, feels like temperature**.  
- **Dynamic weather icons** using Lottie animations.  
- Pull-to-refresh functionality for updated data.   

---
## Architecture & Packages

- **State Management:** Bloc (`flutter_bloc`)  
- **Networking:** Dio  
- **JSON Parsing:** Manual from OpenWeatherMap API  
- **Local Storage (optional):** Hive / Shared Preferences  
- **Location Services:** Geolocator  
- **Animations:** Lottie  
- **Responsive UI:** `flutter_screenutil`  
---
## Screenshots:



## Getting Started

### Clone the repository

git clone https://github.com/Abonyizion/skyscope.git
cd skyscope

Install dependencies
flutter pub get

Add your OpenWeatherMap API key

Update the WeatherApi service with your API key.

Run the app
flutter run
