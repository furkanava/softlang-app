import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatMessage {
  final String text;
  final bool sentByUser;

  ChatMessage({required this.text, required this.sentByUser});
}

class GeminiChat extends StatefulWidget {
  @override
  _GeminiChatState createState() => _GeminiChatState();
}

class _GeminiChatState extends State<GeminiChat> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final int _maxResponseLength = 200;

  bool _isSending = false;
  bool _geminiInitialized = false;
  String? _errorMessage;

  final String _apiKey = 'AIzaSyBUoWeq2gza6YuQUHLxeVg3ST_eaU-QZM4'; // API anahtarınızı buraya ekleyin
  Gemini? _gemini;

  final String _systemPrompt = """
You are a helpful and knowledgeable frontend developer. You are here to help users practice their English in the context of frontend development.

**Important Instructions:**

* **Respond in English only.**
* **If the user types in Turkish, respond with "Please try to respond in English so we can practice your technical vocabulary!"**
* **Keep your responses concise and informative.**
* **Focus on frontend web technologies and related topics.**
""";

  @override
  void initState() {
    super.initState();
    _initializeGemini();
  }

  Future<void> _initializeGemini() async {
    try {
      final gemini = await Gemini.init(apiKey: _apiKey);
      setState(() {
        _gemini = gemini;
        _geminiInitialized = true;
        _messages.insert(
          0,
          ChatMessage(
            text: "Hey there! I'm a frontend developer. Let's chat about the latest web tech. What are you curious about?",
            sentByUser: false,
          ),
        );
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Error initializing Gemini: $e";
      });
      print(_errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03045E),
      appBar: AppBar(
        title: const Text(
          'Frontend English Chat',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF293294),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageItem(message);
              },
            ),
          ),
          if (_geminiInitialized) _buildInputBar(),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.white))),
            ),
          if (!_geminiInitialized && _errorMessage == null)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    return Align(
      alignment: message.sentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.sentByUser ? const Color(0xFF8A7BF0) : const Color(0xFF483D8B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message.text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              onSubmitted: (value) => _sendMessage(value),
            ),
          ),
          IconButton(
            icon: Icon(_isSending ? Icons.hourglass_empty : Icons.send, color: Colors.white),
            onPressed: _isSending ? null : () => _sendMessage(_textController.text),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) async {
    if (text.trim().isNotEmpty && _gemini != null) {
      setState(() {
        _messages.insert(0, ChatMessage(text: text, sentByUser: true));
        _isSending = true;
        _errorMessage = null;
      });

      try {
        final response = await _gemini!.text(_systemPrompt + "\nUser: $text");

        if (response != null && response.output != null) {
          String geminiResponse = response.output!;

          if (geminiResponse.length > _maxResponseLength) {
            geminiResponse = geminiResponse.substring(0, _maxResponseLength) + "...";
          }

          if (!RegExp(r'^[a-zA-Z0-9\s.,!?]+$').hasMatch(text)) {
            geminiResponse = "Lütfen İngilizce yanıt vermeye çalışın.";
          } else {
            geminiResponse = geminiResponse.replaceAll(_systemPrompt, "").trim();
          }

          setState(() {
            _messages.insert(0, ChatMessage(text: geminiResponse, sentByUser: false));
          });
        } else {
          throw Exception("Gemini'den geçerli bir yanıt alınamadı.");
        }
      } catch (e) {
        setState(() {
          _errorMessage = "Mesaj gönderilirken bir hata oluştu: $e";
          _isSending = false;
        });
        print(_errorMessage);
      } finally {
        setState(() => _isSending = false);
      }

      _textController.clear();
    }
  }
}
