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
- Shimmer loading effect.

---
## Architecture & Packages

- **State Management:** Bloc (`flutter_bloc`)  
- **Networking:** Dio  
- **JSON Parsing:** Manual from OpenWeatherMap API  
- *Flutter clean architecture
- **Location Services:** Geolocator  
- **Animations:** Lottie  
- **Responsive UI:** `flutter_screenutil`  
---
## Screenshots:

![Screenshot_20251120-154113](https://github.com/user-attachments/assets/47b675a4-01ef-4138-bb83-c4098f168a96)
![Screenshot_20251120-154133](https://github.com/user-attachments/assets/dccd3848-b57a-4735-987c-115f9492fa98)
![Screenshot_20251120-154209](https://github.com/user-attachments/assets/28d017db-05e6-4c60-a02f-8a9e786ad2f8)




## Getting Started

### Clone the repository

git clone https://github.com/Abonyizion/skyscope.git
cd skyscope

##Install dependencies:
- flutter pub get

- Add your OpenWeatherMap API key

- Update the WeatherApi service with your API key.

- Run the app:
flutter run
