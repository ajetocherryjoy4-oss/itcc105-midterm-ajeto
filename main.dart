import 'package:flutter/material.dart';

void main() {
  runApp(const ASSCATCopilotApp());
}

class ASSCATCopilotApp extends StatelessWidget {
  const ASSCATCopilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ASSCAT Copilot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const CopilotHome(),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}

class CopilotHome extends StatefulWidget {
  const CopilotHome({super.key});

  @override
  State<CopilotHome> createState() => _CopilotHomeState();
}

class _CopilotHomeState extends State<CopilotHome> {
  final TextEditingController controller = TextEditingController();

  List<Message> messages = [
    Message(
      text: "Hello! I am ASSCAT Copilot 👋 How can I help you?",
      isUser: false,
    ),
  ];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add(Message(text: text, isUser: true));

      messages.add(Message(
        text: _generateResponse(text),
        isUser: false,
      ));
    });

    controller.clear();
  }

  String _generateResponse(String input) {
    input = input.toLowerCase();

    if (input.contains("schedule")) {
      return "Your class schedule is available in the student portal.";
    } else if (input.contains("grades")) {
      return "You can check your grades in the SIS system.";
    } else if (input.contains("enrollment")) {
      return "Enrollment status: Please log in to your account.";
    }

    return "I am processing your request. This is a demo response.";
  }

  void useSuggestion(String text) {
    controller.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ASSCAT Copilot"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // Greeting
          const Text(
            "Hello, Student 👋",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),

          const SizedBox(height: 10),

          // CHAT AREA
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];

                return Align(
                  alignment: msg.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 250),
                    decoration: BoxDecoration(
                      color: msg.isUser ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Colors.black12,
                        )
                      ],
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color:
                            msg.isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // SUGGESTIONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              spacing: 8,
              children: [
                ActionChip(
                  label: const Text("View schedule"),
                  onPressed: () => useSuggestion("View schedule"),
                ),
                ActionChip(
                  label: const Text("Check grades"),
                  onPressed: () => useSuggestion("Check grades"),
                ),
                ActionChip(
                  label: const Text("Enrollment status"),
                  onPressed: () => useSuggestion("Enrollment status"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // INPUT BOX
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Speak or type your request...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // SEND BUTTON
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () =>
                      sendMessage(controller.text),
                ),

                // MIC BUTTON
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Voice input not yet implemented",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}