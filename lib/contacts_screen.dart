import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// CONTACTS SCREEN
// ─────────────────────────────────────────────
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<ContactItem> _contacts = [
    ContactItem(name: 'Ramy (រ៉ាមី ម៉ាន)', status: 'online', isOnline: true),
    ContactItem(name: 'Chum Rern', status: 'online', isOnline: true),
    ContactItem(
      name: 'Ravy Bun',
      status: 'online',
      isOnline: true,
      initials: 'RB',
      avatarColor: Color(0xFF9C27B0),
    ),
    ContactItem(name: 'TAA', status: 'online', isOnline: true),
    ContactItem(name: 'Samphors Sithyka', status: 'online', isOnline: true),
    ContactItem(name: 'Mr.Phay Phen Chenla', status: 'last seen just now'),
    ContactItem(name: 'Ngoy Brach', status: 'last seen just now'),
    ContactItem(
      name: 'OEUN KHEMRIN CLU ⭐',
      status: 'last seen 2 minutes ago',
      isFavorite: true,
    ),
    ContactItem(
      name: 'តាងហ្យូងតន ត្រឹញ្ញស Sum Ngeth',
      status: 'last seen 3 minutes ago',
    ),
    ContactItem(name: 'bunna keo', status: 'last seen 4 minutes ago'),
    ContactItem(name: 'Rorm Saoly', status: 'last seen 4 minutes ago'),
    ContactItem(name: 'Cheng Vanna', status: 'last seen 5 minutes ago'),
    ContactItem(name: 'IT Admin', status: 'last seen 10 minutes ago'),
    ContactItem(name: 'Teacher PHIRUM', status: 'last seen 1 hour ago'),
    ContactItem(name: 'Bee Van', status: 'last seen yesterday'),
    ContactItem(
      name: 'TOUCH SAM ANG CLU Office',
      status: 'last seen 2 days ago',
    ),
  ];

  List<ContactItem> get _filtered {
    if (_searchQuery.isEmpty) return _contacts;
    return _contacts
        .where((c) => c.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Sort',
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Contacts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFEFEF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.black87,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Search bar ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Color(0xFF8E8E93),
                      fontSize: 15,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF8E8E93),
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ── Permission notice ──
            if (_searchQuery.isEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F3F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'You have limited Telegram from accessing all of your contacts.',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'MANAGE',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),

            // ── List ──
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length + (_searchQuery.isEmpty ? 1 : 0),
                itemBuilder: (context, i) {
                  // Invite Friends row (only when not searching)
                  if (_searchQuery.isEmpty && i == 0) {
                    return InkWell(
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
                                Icons.person_add,
                                color: Color(0xFF2196F3),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Text(
                              'Invite Friends',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF2196F3),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final contact = filtered[_searchQuery.isEmpty ? i - 1 : i];
                  return _ContactTile(contact: contact);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CONTACT TILE
// ─────────────────────────────────────────────
class _ContactTile extends StatelessWidget {
  final ContactItem contact;
  const _ContactTile({required this.contact});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor:
                      contact.avatarColor ?? _avatarColor(contact.name),
                  backgroundImage: contact.imageAsset != null
                      ? AssetImage(contact.imageAsset!)
                      : null,
                  child: contact.imageAsset == null
                      ? Text(
                          contact.initials ?? _initials(contact.name),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                if (contact.isOnline)
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),

            // Name + status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          contact.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: contact.isFavorite
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    contact.status,
                    style: TextStyle(
                      fontSize: 13,
                      color: contact.isOnline
                          ? const Color(0xFF2196F3)
                          : const Color(0xFF8E8E93),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
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

  Color _avatarColor(String name) {
    final colors = [
      const Color(0xFF5E35B1),
      const Color(0xFF1E88E5),
      const Color(0xFF00897B),
      const Color(0xFFE53935),
      const Color(0xFFFF8F00),
      const Color(0xFF6D4C41),
      const Color(0xFF00ACC1),
      const Color(0xFFEC407A),
    ];
    return colors[name.length % colors.length];
  }
}

// ─────────────────────────────────────────────
// CONTACT ITEM MODEL
// ─────────────────────────────────────────────
class ContactItem {
  final String name;
  final String status;
  final bool isOnline;
  final bool isFavorite;
  final String? initials;
  final Color? avatarColor;
  final String? imageAsset;

  const ContactItem({
    required this.name,
    required this.status,
    this.isOnline = false,
    this.isFavorite = false,
    this.initials,
    this.avatarColor,
    this.imageAsset,
  });
}
