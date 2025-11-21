

class WeatherLottieMapper {
  static String getAnimation(String main) {
    final lower = main.toLowerCase();

    if (lower.contains("clear")) return "assets/lottie/sunny.json";
    if (lower.contains("cloud")) return "assets/lottie/clouds.json";
    if (lower.contains("rain")) return "assets/lottie/rain.json";
    if (lower.contains("drizzle")) return "assets/lottie/rain.json";
    if (lower.contains("thunder")) return "assets/lottie/thunderstorm.json";
    if (lower.contains("snow")) return "assets/lottie/winter.json";
    if (lower.contains("mist") ||
        lower.contains("fog") ||
        lower.contains("haze")) {
      return "assets/lottie/clouds.json";
    }

    return "assets/lottie/sunny.json"; // fallback
  }
}
