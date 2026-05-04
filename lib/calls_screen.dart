import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// CALLS SCREEN
// ─────────────────────────────────────────────
class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  int _tabIndex = 0; // 0 = All, 1 = Missed

  final List<CallItem> _calls = [
    CallItem(
      name: 'OEUN KHEMRIN CLU',
      type: CallType.missed,
      time: '1:02 PM',
      avatarColor: Color(0xFF1E88E5),
    ),
    CallItem(
      name: 'TOUCH SAM ANG ( CLU Offic...',
      type: CallType.missed,
      time: 'Tue',
      avatarColor: Color(0xFF00897B),
    ),
    CallItem(
      name: 'RONG KHEAV Admin NSR',
      type: CallType.missed,
      time: 'Tue',
      avatarColor: Color(0xFF5E35B1),
    ),
    CallItem(
      name: 'TOUCH SAM ANG ( CLU Offic...',
      type: CallType.outgoingIncoming,
      time: 'Mon',
      avatarColor: Color(0xFF00897B),
    ),
    CallItem(
      name: 'Teacher PHIRUM',
      type: CallType.incoming,
      duration: '36 sec',
      time: 'Mon',
      initials: 'T',
      avatarColor: Color(0xFFE53935),
    ),
    CallItem(
      name: 'TOUCH SAM ANG ( CLU Offic...',
      type: CallType.outgoing,
      time: 'Mon',
      avatarColor: Color(0xFF00897B),
    ),
    CallItem(
      name: '❤️pich❤️',
      type: CallType.missed,
      time: 'Sun',
      avatarColor: Color(0xFFEC407A),
    ),
    CallItem(
      name: '❤️pich❤️',
      type: CallType.outgoing,
      duration: '25 sec',
      time: 'Sun',
      avatarColor: Color(0xFFEC407A),
    ),
    CallItem(
      name: 'Cheng',
      type: CallType.outgoing,
      time: 'Sun',
      avatarColor: Color(0xFF00ACC1),
    ),
    CallItem(
      name: 'IT Admin',
      type: CallType.outgoing,
      time: 'Sun',
      avatarColor: Color(0xFF6D4C41),
    ),
    CallItem(
      name: '❤️pich❤️',
      type: CallType.outgoing,
      time: 'Sun',
      avatarColor: Color(0xFFEC407A),
    ),
    CallItem(
      name: '❤️pich❤️',
      type: CallType.missed,
      time: 'Sat',
      avatarColor: Color(0xFFEC407A),
    ),
    CallItem(
      name: '❤️pich❤️',
      type: CallType.missed,
      time: '20/04',
      avatarColor: Color(0xFFEC407A),
    ),
    CallItem(
      name: 'Bee Van (2)',
      type: CallType.missed,
      time: '16/04',
      avatarColor: Color(0xFF5E35B1),
    ),
    CallItem(
      name: 'Bee Van (5)',
      type: CallType.missed,
      time: '15/04',
      avatarColor: Color(0xFF5E35B1),
    ),
    CallItem(
      name: '❤️pich❤️',
      type: CallType.missed,
      time: '11/04',
      avatarColor: Color(0xFFEC407A),
    ),
    CallItem(
      name: '❤️pich❤️',
      type: CallType.missed,
      time: '09/04',
      avatarColor: Color(0xFFEC407A),
    ),
    CallItem(
      name: '❤️pich❤️',
      type: CallType.missed,
      time: '08/04',
      avatarColor: Color(0xFFEC407A),
    ),
    CallItem(
      name: 'Bee Van',
      type: CallType.missed,
      time: '07/04',
      avatarColor: Color(0xFF5E35B1),
    ),
  ];

  List<CallItem> get _filtered {
    if (_tabIndex == 0) return _calls;
    return _calls.where((c) => c.type == CallType.missed).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFF2196F3),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // All / Missed toggle
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        _TabButton(
                          label: 'All',
                          selected: _tabIndex == 0,
                          onTap: () => setState(() => _tabIndex = 0),
                        ),
                        _TabButton(
                          label: 'Missed',
                          selected: _tabIndex == 1,
                          onTap: () => setState(() => _tabIndex = 1),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // placeholder for symmetry
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // ── Start New Call ──
            if (_tabIndex == 0)
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE3F2FD),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add_call,
                          color: Color(0xFF2196F3),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'Start New Call',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF2196F3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // ── Section label ──
            if (_tabIndex == 0)
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Text(
                    'RECENT CALLS',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8E8E93),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

            // ── Call list ──
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, i) => _CallTile(call: filtered[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TAB BUTTON
// ─────────────────────────────────────────────
class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CALL TILE
// ─────────────────────────────────────────────
class _CallTile extends StatelessWidget {
  final CallItem call;
  const _CallTile({required this.call});
  @override
  Widget build(BuildContext context) {
    final isMissed = call.type == CallType.missed;

    String subtitle;
    IconData dirIcon;
    Color dirColor;

    switch (call.type) {
      case CallType.missed:
        subtitle = 'Missed';
        dirIcon = Icons.call_received;
        dirColor = const Color(0xFFE53935);
        break;
      case CallType.incoming:
        subtitle = call.duration != null
            ? 'Incoming (${call.duration})'
            : 'Incoming';
        dirIcon = Icons.call_received;
        dirColor = const Color(0xFF4CAF50);
        break;
      case CallType.outgoing:
        subtitle = call.duration != null
            ? 'Outgoing (${call.duration})'
            : 'Outgoing';
        dirIcon = Icons.call_made;
        dirColor = const Color(0xFF4CAF50);
        break;
      case CallType.outgoingIncoming:
        subtitle = 'Outgoing, Incoming';
        dirIcon = Icons.call_made;
        dirColor = const Color(0xFF4CAF50);
        break;
    }

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 26,
              backgroundColor: call.avatarColor,
              child: Text(
                call.initials ?? _initials(call.name),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Name + call type
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    call.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isMissed ? const Color(0xFFE53935) : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(dirIcon, size: 14, color: dirColor),
                      const SizedBox(width: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Time + info button
            Text(
              call.time,
              style: const TextStyle(fontSize: 13, color: Color(0xFF8E8E93)),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.info_outline,
                color: Color(0xFF2196F3),
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final clean = name.replaceAll(RegExp(r'[^\w\s]'), '').trim();
    final words = clean.split(' ').where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '?';
    if (words.length == 1) return words[0][0].toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }
}

// ─────────────────────────────────────────────
// CALL ITEM MODEL
// ─────────────────────────────────────────────
enum CallType { missed, incoming, outgoing, outgoingIncoming }

class CallItem {
  final String name;
  final CallType type;
  final String time;
  final String? duration;
  final String? initials;
  final Color avatarColor;

  const CallItem({
    required this.name,
    required this.type,
    required this.time,
    required this.avatarColor,
    this.duration,
    this.initials,
  });
}
