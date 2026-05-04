import 'package:flutter/material.dart';
import 'chats.dart'; // ← import file ថ្មី

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 3;

  void _onTabTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const _PlaceholderScreen(
          label: 'Contacts',
          icon: Icons.contacts,
        );
      case 1:
        return const _PlaceholderScreen(label: 'Calls', icon: Icons.call);
      case 2:
        return const ChatsScreen(); // ← ប្រើ ChatsScreen ពី chats.dart
      case 3:
        return const _SettingsBody();
      case 4:
        return const _PlaceholderScreen(label: 'Search', icon: Icons.search);
      default:
        return const _SettingsBody();
    }
  }

  Widget _buildBottomNav() {
    final items = [
      _NavItem(icon: Icons.person, label: 'Contacts', badge: '!'),
      _NavItem(icon: Icons.call, label: 'Calls'),
      _NavItem(icon: Icons.chat_bubble, label: 'Chats', badge: '44.5K'),
      _NavItem(icon: Icons.settings, label: 'Settings'),
      _NavItem(icon: Icons.search, label: '', isSearch: true),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        border: Border(top: BorderSide(color: Color(0xFF2C2C2E), width: 0.5)),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 56,
          child: Row(
            children: List.generate(items.length, (i) {
              final item = items[i];
              final selected = i == _selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _onTabTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            item.icon,
                            size: 26,
                            color: selected
                                ? const Color(0xFF40C4FF)
                                : const Color(0xFF8E8E93),
                          ),
                          if (item.badge != null)
                            Positioned(
                              top: -8,
                              right: -14,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE53935),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  item.badge!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (item.label.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 10,
                            color: selected
                                ? const Color(0xFF40C4FF)
                                : const Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SETTINGS BODY
// ─────────────────────────────────────────────
class _SettingsBody extends StatefulWidget {
  const _SettingsBody();

  @override
  State<_SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<_SettingsBody> {
  String _name = 'THANG CHENG';
  // ignore: prefer_final_fields
  String _phone = '+855 71 554 1435';
  // ignore: prefer_final_fields
  String _username = '@Thangcheng';

  void _editProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _EditProfileSheet(
        name: _name,
        phone: _phone,
        onSave: (newName) {
          setState(() => _name = newName);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _changePhoto() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _PhotoOptionsSheet(),
    );
  }

  void _addToHome() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add to Home Screen — use your browser\'s share menu'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 56, bottom: 24),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (Navigator.of(context).canPop())
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFF2196F3),
                            size: 22,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      else
                        IconButton(
                          icon: const Icon(
                            Icons.qr_code_2,
                            color: Color(0xFF2196F3),
                            size: 28,
                          ),
                          onPressed: () => _showQR(),
                        ),
                      TextButton(
                        onPressed: _editProfile,
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            color: Color(0xFF2196F3),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _changePhoto,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5E35B1),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'TC',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$_phone • $_username',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _SettingsRow(
              icon: Icons.camera_alt,
              iconColor: const Color(0xFF2196F3),
              iconBg: const Color(0xFFE3F2FD),
              label: 'Change Profile Photo',
              onTap: _changePhoto,
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _SettingsRow(
              icon: Icons.person,
              iconColor: Colors.white,
              iconBg: const Color(0xFFE53935),
              label: 'My Profile',
              onTap: () => _showInfo('My Profile'),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _SettingsRow(
                  icon: Icons.bookmark,
                  iconColor: Colors.white,
                  iconBg: const Color(0xFF2196F3),
                  label: 'Saved Messages',
                  onTap: () => _showInfo('Saved Messages'),
                  divider: true,
                ),
                _SettingsRow(
                  icon: Icons.call,
                  iconColor: Colors.white,
                  iconBg: const Color(0xFF4CAF50),
                  label: 'Recent Calls',
                  onTap: () => _showInfo('Recent Calls'),
                  divider: true,
                ),
                _SettingsRow(
                  icon: Icons.phone_android,
                  iconColor: Colors.white,
                  iconBg: const Color(0xFFFF9800),
                  label: 'Devices',
                  trailing: '3',
                  onTap: () => _showInfo('Devices'),
                  divider: true,
                ),
                _SettingsRow(
                  icon: Icons.folder,
                  iconColor: Colors.white,
                  iconBg: const Color(0xFF2196F3),
                  label: 'Chat Folders',
                  onTap: () => _showInfo('Chat Folders'),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _SettingsRow(
                  icon: Icons.notifications,
                  iconColor: Colors.white,
                  iconBg: const Color(0xFFE53935),
                  label: 'Notifications and Sounds',
                  onTap: () => _showInfo('Notifications and Sounds'),
                  divider: true,
                ),
                _SettingsRow(
                  icon: Icons.lock,
                  iconColor: Colors.white,
                  iconBg: const Color(0xFF607D8B),
                  label: 'Privacy and Security',
                  onTap: () => _showInfo('Privacy and Security'),
                  divider: true,
                ),
                _SettingsRow(
                  icon: Icons.data_usage,
                  iconColor: Colors.white,
                  iconBg: const Color(0xFF4CAF50),
                  label: 'Data and Storage',
                  onTap: () => _showInfo('Data and Storage'),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _SettingsRow(
              icon: Icons.add_to_home_screen,
              iconColor: Colors.white,
              iconBg: const Color(0xFF2196F3),
              label: 'Add to Home Screen',
              onTap: _addToHome,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }

  void _showInfo(String label) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$label — coming soon')));
  }

  void _showQR() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('QR Code'),
        content: const SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Icon(Icons.qr_code_2, size: 160, color: Colors.black),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// EDIT PROFILE SHEET
// ─────────────────────────────────────────────
class _EditProfileSheet extends StatefulWidget {
  final String name;
  final String phone;
  final void Function(String) onSave;

  const _EditProfileSheet({
    required this.name,
    required this.phone,
    required this.onSave,
  });

  @override
  State<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<_EditProfileSheet> {
  late TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.name);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Profile',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _nameCtrl,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            enabled: false,
            decoration: InputDecoration(
              labelText: 'Phone',
              hintText: widget.phone,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => widget.onSave(_nameCtrl.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PHOTO OPTIONS SHEET
// ─────────────────────────────────────────────
class _PhotoOptionsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Change Profile Photo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.camera_alt, color: Color(0xFF2196F3)),
            title: const Text('Take Photo'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Camera — coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: Color(0xFF4CAF50)),
            title: const Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gallery — coming soon')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Color(0xFFE53935)),
            title: const Text(
              'Remove Photo',
              style: TextStyle(color: Color(0xFFE53935)),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// REUSABLE WIDGETS
// ─────────────────────────────────────────────
class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String? trailing;
  final VoidCallback onTap;
  final bool divider;

  const _SettingsRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.onTap,
    this.trailing,
    this.divider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          title: Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (trailing != null)
                Text(
                  trailing!,
                  style: const TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 16,
                  ),
                ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, color: Color(0xFFBDBDBD)),
            ],
          ),
        ),
        if (divider)
          const Padding(
            padding: EdgeInsets.only(left: 56),
            child: Divider(height: 1, color: Color(0xFFE0E0E0)),
          ),
      ],
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String label;
  final IconData icon;

  const _PlaceholderScreen({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: const Color(0xFFBDBDBD)),
          const SizedBox(height: 16),
          Text(
            label,
            style: const TextStyle(
              fontSize: 22,
              color: Color(0xFF8E8E93),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text('Coming soon', style: TextStyle(color: Color(0xFFBDBDBD))),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String? badge;
  final bool isSearch;
  _NavItem({
    required this.icon,
    required this.label,
    this.badge,
    this.isSearch = false,
  });
}
