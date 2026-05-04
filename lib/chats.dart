import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: ChatsScreen()),
  );
}

// ─────────────────────────────────────────────
// MAIN SCREEN
// ─────────────────────────────────────────────
class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedFolder = 0;

  final List<String> _folders = [
    'All',
    'WORK CLU',
    'CLU 📚🏠',
    'Personal',
    'Prints 🖨️',
    'Code 🆘',
  ];

  final List<ChatItem> _chats = [
    ChatItem(
      name: 'Ratana Lim ( Boss CLU )',
      message: '🙏 Sticker',
      time: '5:40 PM',
      isMuted: true,
      folder: 'WORK CLU',
    ),
    ChatItem(
      name: 'OEUN KHEMRIN CLU',
      message: 'kanhapichthy@gmail.com pass...',
      time: '2:24 PM',
      isVerified: true,
      isMuted: true,
      folder: 'CLU 📚🏠',
    ),
    ChatItem(
      name: '❤️ pich ❤️',
      message: 'TikTok link',
      time: '5:51 PM',
      unread: 2,
      isOnline: true,
      folder: 'Personal',
    ),
    ChatItem(
      name: 'Noobie GMK',
      message: 'Hello bro',
      time: 'Wed',
      unread: 5,
      isVerified: true,
      folder: 'Code 🆘',
    ),
  ];

  List<ChatItem> get _filteredChats {
    final folder = _folders[_selectedFolder];
    if (folder == 'All') return _chats;
    return _chats.where((c) => c.folder == folder).toList();
  }

  int _getUnread(String folder) {
    if (folder == 'All') {
      return _chats.fold(0, (sum, c) => sum + c.unread);
    }
    return _chats
        .where((c) => c.folder == folder)
        .fold(0, (sum, c) => sum + c.unread);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // HEADER
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Text(
                    "Chats",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // FOLDERS
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _folders.length,
              itemBuilder: (context, i) {
                final selected = i == _selectedFolder;
                final name = _folders[i];
                final unread = _getUnread(name);

                return GestureDetector(
                  onTap: () => setState(() => _selectedFolder = i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.black.withValues(
                              alpha: 0.5,
                            ) // ត្រូវមានពាក្យ alpha: នៅពីមុខលេខ
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        if (unread > 0) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$unread',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const Divider(),

          // CHAT LIST
          Expanded(
            child: ListView.builder(
              itemCount: _filteredChats.length,
              itemBuilder: (context, i) => ChatTile(chat: _filteredChats[i]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CHAT TILE (CLICKABLE)
// ─────────────────────────────────────────────
class ChatTile extends StatelessWidget {
  final ChatItem chat;
  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ChatDetailScreen(chat: chat)),
        );
      },
      leading: CircleAvatar(child: Text(chat.name[0])),
      title: Text(chat.name),
      subtitle: Text(chat.message),
      trailing: chat.unread > 0
          ? CircleAvatar(
              radius: 10,
              backgroundColor: Colors.blue,
              child: Text(
                '${chat.unread}',
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            )
          : null,
    );
  }
}

// ─────────────────────────────────────────────
// CHAT DETAIL SCREEN
// ─────────────────────────────────────────────
class ChatDetailScreen extends StatefulWidget {
  final ChatItem chat;

  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {"text": "Hello 👋", "isMe": false},
    {"text": "Hi!", "isMe": true},
  ];

  void sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({"text": _controller.text, "isMe": true});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chat.name)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final msg = messages[i];
                return Align(
                  alignment: msg["isMe"]
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: ChatBubble(text: msg["text"], isMe: msg["isMe"]),
                );
              },
            ),
          ),

          // INPUT
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Type message...",
                  ),
                ),
              ),
              IconButton(icon: const Icon(Icons.send), onPressed: sendMessage),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CHAT BUBBLE
// ─────────────────────────────────────────────
class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatBubble({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isMe ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(color: isMe ? Colors.white : Colors.black),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MODEL
// ─────────────────────────────────────────────
class ChatItem {
  final String name;
  final String message;
  final String time;
  final int unread;
  final bool isOnline;
  final bool isVerified;
  final bool isMuted;
  final bool isGroup;
  final String folder;

  ChatItem({
    required this.name,
    required this.message,
    required this.time,
    this.unread = 0,
    this.isOnline = false,
    this.isVerified = false,
    this.isMuted = false,
    this.isGroup = false,
    this.folder = 'All',
  });
}
