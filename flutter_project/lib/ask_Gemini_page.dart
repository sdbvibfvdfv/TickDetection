import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AskGeminiPage extends StatefulWidget {
  const AskGeminiPage({super.key, required this.tick_name});

  final String tick_name;

  @override
  State<AskGeminiPage> createState() => _AskGeminiPageState();
}

class _AskGeminiPageState extends State<AskGeminiPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _chatHistory = [];
  bool _isLoading = false;

  Future<String> getGeminiResponse(String userInput) async {
    const apiKey = 'APIKEY';
    const url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': userInput}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text = data['candidates'][0]['content']['parts'][0]['text'];
      return text;
    } else {
      throw Exception('Gemini API call failed: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.tick_name != 'None') {
      _askInitialQuestion();
    }
  }

  Future<void> _askInitialQuestion() async {
    setState(() {
      _isLoading = true;
    });
    final response = await getGeminiResponse('Tell me about ${widget.tick_name}');
    setState(() {
      _chatHistory.add({
        'role': 'user',
        'text': 'Tell me about ${widget.tick_name}',
      });
      _chatHistory.add({
        'role': 'gemini',
        'text': response,
      });
      _isLoading = false;
    });
  }

  Future<void> _sendMessage(String input) async {
    if (input.trim().isEmpty) return;
    setState(() {
      _chatHistory.add({'role': 'user', 'text': input});
      _isLoading = true;
    });

    final response = await getGeminiResponse(input);
    setState(() {
      _chatHistory.add({'role': 'gemini', 'text': response});
      _isLoading = false;
      _controller.clear();
    });
  }

  Widget _buildMessage(String role, String text) {
    final isUser = role == 'user';
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isUser ? Colors.blue[100] : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Gemini'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: const EdgeInsets.all(10),
              itemCount: _chatHistory.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isLoading && index == _chatHistory.length) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Gemini is responding...', style: TextStyle(fontStyle: FontStyle.italic)),
                  );
                }
                final message = _chatHistory[index];
                return _buildMessage(message['role']!, message['text']!);
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: _sendMessage,
                    decoration: InputDecoration(
                      labelText: 'Input your questions',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () => _sendMessage(_controller.text),
                  child: const Text('Ask'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
