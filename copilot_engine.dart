// copilot_engine.dart

class CopilotEngine {
  static String process(String userIntent, bool isInternetConnected) {
    userIntent = userIntent.toLowerCase();

    // Offline-first feature
    if (!isInternetConnected) {
      return "⚠️ You are currently offline.\n"
          "📌 Showing saved data. Some features may be limited.";
    }

    // AI Intent Handling
    if (userIntent == 'check clearance') {
      return "✅ AI Copilot: Your clearance status is COMPLETE.\n"
          "📄 All requirements have been submitted successfully.";
    } 
    else if (userIntent == 'view schedule') {
      return "📅 AI Copilot: Your next class is at 10:00 AM.\n"
          "📍 Location: Room 201";
    } 
    else if (userIntent == 'check grades') {
      return "📊 AI Copilot: Here are your latest grades:\n"
          "• Math: 92\n"
          "• English: 89\n"
          "• Programming: 95";
    } 
    else {
      return "🤖 AI Copilot: Sorry, I didn’t understand your request.\n"
          "💡 Try asking about schedules, grades, or clearance.";
    }
  }
}