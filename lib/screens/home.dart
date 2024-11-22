import 'package:flutter/material.dart';
import 'package:flutter_gemini/widgets/message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final GenerativeModel _gemini;
  late final ChatSession _chatSession;
  final _messageController = TextEditingController();
  final _messageFocusNode = FocusNode();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _gemini = GenerativeModel(
      model: 'gemini-pro',
      apiKey: const String.fromEnvironment('api_key'),
    );

    _chatSession = _gemini.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DevFest Abuja 2024'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _chatSession.history.length,
                itemBuilder: (context, index) {
                  final Content content = _chatSession.history.toList()[index];
                  final textMessage = content.parts
                      .whereType<TextPart>()
                      .map((e) => e.text)
                      .join('');

                  return MessageWidget(
                    textMessage: textMessage,
                    isFromUser: content.role == 'user',
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      focusNode: _messageFocusNode,
                      controller: _messageController,
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage(String message) async {

    try {
      final response = await _chatSession.sendMessage(
        Content.text(message),
      );
      final textMessage = response.text;

      if (textMessage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'No response from Gemini',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        return;
      } else {
        setState(() {
          _scrollToNewText();
        });
      }
    } catch (ex) {
      debugPrint('EXCEPTION CAUGHT $ex');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Exception thrown check logs',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } finally {
      _messageController.clear();
      _messageFocusNode.requestFocus();
    }
  }

  void _scrollToNewText() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(
              milliseconds: 500,
            ),
            curve: Curves.easeOutCirc));
  }
}
