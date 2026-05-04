// ignore_for_file: unused_import

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'account_screen.dart';
import './settings_screen.dart';
import 'chats.dart';
import 'contacts_screen.dart';
import 'calls_screen.dart';

void main() {
  runApp(const TelegramOnboardingApp());
}

class TelegramOnboardingApp extends StatelessWidget {
  const TelegramOnboardingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Onboarding',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'SF Pro Display',
      ),
      home: const OnboardingFlow(),
    );
  }
}

// ─────────────────────────────────────────────
// MAIN SHELL (Bottom Navigation)
// ─────────────────────────────────────────────
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    ContactsScreen(), // ← index 0
    CallsScreen(), // ← index 1
    ChatsScreen(), // ← index 2
    SettingsScreen(), // ← index 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Contacts",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ONBOARDING FLOW CONTROLLER
// ─────────────────────────────────────────────
class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int _currentScreen = 0;

  void _goToPhone() => setState(() => _currentScreen = 1);
  void _goToSuccess() => setState(() => _currentScreen = 2);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: switch (_currentScreen) {
        0 => FeatureSlidesScreen(
          key: const ValueKey('slides'),
          onContinue: _goToPhone,
        ),
        1 => PhoneEntryScreen(
          key: const ValueKey('phone'),
          onSuccess: _goToSuccess,
        ),
        _ => SuccessScreen(key: const ValueKey('success')),
      },
    );
  }
}

// ─────────────────────────────────────────────
// SCREEN 1: FEATURE SLIDES
// ─────────────────────────────────────────────
class FeatureSlide {
  final Widget icon;
  final String title;
  final String subtitle;
  const FeatureSlide({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class FeatureSlidesScreen extends StatefulWidget {
  final VoidCallback onContinue;
  const FeatureSlidesScreen({super.key, required this.onContinue});

  @override
  State<FeatureSlidesScreen> createState() => _FeatureSlidesScreenState();
}

class _FeatureSlidesScreenState extends State<FeatureSlidesScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final List<FeatureSlide> _slides = [
    FeatureSlide(
      icon: _TelegramLogoIcon(),
      title: 'Telegram',
      subtitle:
          "The world's **fastest** messaging app.\nIt is **free** and **secure**.",
    ),
    FeatureSlide(
      icon: _SpeedometerIcon(),
      title: 'Fast',
      subtitle:
          '**Telegram** delivers messages\nfaster than any other application.',
    ),
    FeatureSlide(
      icon: _GiftIcon(),
      title: 'Free',
      subtitle:
          '**Telegram** provides free unlimited\ncloud storage for chats and media.',
    ),
    FeatureSlide(
      icon: _InfinityIcon(),
      title: 'Powerful',
      subtitle:
          '**Telegram** has no limits on\nthe size of your media and chats.',
    ),
    FeatureSlide(
      icon: _LockIcon(),
      title: 'Secure',
      subtitle: '**Telegram** keeps your messages\nsafe from hacker attacks.',
    ),
    FeatureSlide(
      icon: _CloudIcon(),
      title: 'Cloud-Based',
      subtitle:
          '**Telegram** lets you access your\nmessages from multiple devices.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, i) => _SlidePage(slide: _slides[i]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _page ? 8 : 7,
                  height: i == _page ? 8 : 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == _page
                        ? const Color(0xFF40C4FF)
                        // ignore: deprecated_member_use
                        : Colors.white.withOpacity(0.3),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _PrimaryButton(
                label: 'Start Messaging',
                onTap: widget.onContinue,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SlidePage extends StatelessWidget {
  final FeatureSlide slide;
  const _SlidePage({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 120, height: 120, child: slide.icon),
          const SizedBox(height: 48),
          Text(
            slide.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _RichSubtitle(text: slide.subtitle),
        ],
      ),
    );
  }
}

class _RichSubtitle extends StatelessWidget {
  final String text;
  const _RichSubtitle({required this.text});

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'\*\*(.+?)\*\*');
    int last = 0;
    for (final match in regex.allMatches(text)) {
      if (match.start > last) {
        spans.add(TextSpan(text: text.substring(last, match.start)));
      }
      spans.add(
        TextSpan(
          text: match.group(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
      last = match.end;
    }
    if (last < text.length) spans.add(TextSpan(text: text.substring(last)));

    return Text.rich(
      TextSpan(
        style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
        children: spans,
      ),
      textAlign: TextAlign.center,
    );
  }
}

// ─────────────────────────────────────────────
// SCREEN 2: PHONE ENTRY
// ─────────────────────────────────────────────
class PhoneEntryScreen extends StatefulWidget {
  final VoidCallback onSuccess;
  const PhoneEntryScreen({super.key, required this.onSuccess});

  @override
  State<PhoneEntryScreen> createState() => _PhoneEntryScreenState();
}

class _PhoneEntryScreenState extends State<PhoneEntryScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final String _country = 'Cambodia';
  final String _dialCode = '+855';
  bool _isLoading = false;
  bool _showConfirmDialog = false;
  bool _showErrorDialog = false;

  bool get _hasNumber => _phoneController.text.trim().isNotEmpty;

  void _onContinue() {
    setState(() => _showConfirmDialog = true);
  }

  void _onConfirm() {
    setState(() {
      _showConfirmDialog = false;
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final phone = _phoneController.text.replaceAll(' ', '');
      if (phone.length > 9) {
        setState(() {
          _isLoading = false;
          _showErrorDialog = true;
        });
      } else {
        setState(() => _isLoading = false);
        widget.onSuccess();
      }
    });
  }

  void _onEditNumber() => setState(() => _showConfirmDialog = false);
  void _onErrorOk() => setState(() => _showErrorDialog = false);

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            const Text('📞', style: TextStyle(fontSize: 72)),
                            const SizedBox(height: 24),
                            const Text(
                              'Your Phone',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Enter your phone number\nor ',
                                  ),
                                  TextSpan(
                                    text: 'log in using Passkey >',
                                    style: TextStyle(color: Color(0xFF40C4FF)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.white24),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '🇰🇭  $_country',
                                      style: const TextStyle(
                                        color: Color(0xFF40C4FF),
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.chevron_right,
                                      color: Colors.white38,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.white24),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 4,
                                    ),
                                    child: Text(
                                      _dialCode,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 1,
                                    height: 20,
                                    color: Colors.white38,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextField(
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Your phone number',
                                        hintStyle: TextStyle(
                                          color: Colors.white38,
                                        ),
                                      ),
                                      onChanged: (_) => setState(() {}),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: _PrimaryButton(
                      label: 'Continue',
                      onTap: _hasNumber ? _onContinue : null,
                      isLoading: _isLoading,
                    ),
                  ),
                ],
              ),
            ),
            if (_showConfirmDialog)
              _ConfirmDialog(
                phone: '$_dialCode ${_phoneController.text}',
                onEdit: _onEditNumber,
                onConfirm: _onConfirm,
              ),
            if (_showErrorDialog)
              _ErrorDialog(onOk: _onErrorOk, onHelp: _onErrorOk),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DIALOGS
// ─────────────────────────────────────────────
class _ConfirmDialog extends StatelessWidget {
  final String phone;
  final VoidCallback onEdit;
  final VoidCallback onConfirm;

  const _ConfirmDialog({
    required this.phone,
    required this.onEdit,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return _DialogOverlay(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            phone,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Is this the correct number?',
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onEdit,
            child: const Text(
              'Edit',
              style: TextStyle(
                color: Color(0xFF40C4FF),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: _PrimaryButton(label: 'Continue', onTap: onConfirm),
          ),
        ],
      ),
    );
  }
}

class _ErrorDialog extends StatelessWidget {
  final VoidCallback onOk;
  final VoidCallback onHelp;

  const _ErrorDialog({required this.onOk, required this.onHelp});

  @override
  Widget build(BuildContext context) {
    return _DialogOverlay(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Invalid phone number, please try again.',
            style: TextStyle(color: Colors.white, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onOk,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white24),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text('OK'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onHelp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF40C4FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text('Help'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DialogOverlay extends StatelessWidget {
  final Widget child;
  const _DialogOverlay({required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(),
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 120, left: 16, right: 16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SCREEN 3: SUCCESS
// ─────────────────────────────────────────────
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text('🥳', style: TextStyle(fontSize: 72)),
              const SizedBox(height: 32),
              const Text(
                'New Password Set!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'This password will be required when you log in\non a new device in addition to the code you get\nvia SMS.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              _PrimaryButton(
                label: 'Continue',
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainShell()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SHARED WIDGETS
// ─────────────────────────────────────────────
class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;

  const _PrimaryButton({
    required this.label,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null && !isLoading;
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFF40C4FF) : const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  label,
                  style: TextStyle(
                    color: enabled ? Colors.white : Colors.white38,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CUSTOM ICON WIDGETS
// ─────────────────────────────────────────────
class _TelegramLogoIcon extends StatelessWidget {
  const _TelegramLogoIcon();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2AABEE),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(Icons.send, color: Colors.white, size: 52),
      ),
    );
  }
}

class _SpeedometerIcon extends StatelessWidget {
  const _SpeedometerIcon();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _SpeedometerPainter());
  }
}

class _SpeedometerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFF1A2A3A));
    canvas.drawCircle(center, radius - 8, Paint()..color = Colors.white);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 20),
      -3.14,
      2.8,
      false,
      Paint()
        ..color = const Color(0xFFE53935)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      center,
      Offset(center.dx + (radius - 18) * 0.85, center.dy + 4),
      Paint()
        ..color = const Color(0xFFE53935)
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(center, 8, Paint()..color = const Color(0xFF1A2A3A));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GiftIcon extends StatelessWidget {
  const _GiftIcon();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE53935),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Center(
        child: Icon(Icons.card_giftcard, color: Colors.white, size: 56),
      ),
    );
  }
}

class _InfinityIcon extends StatelessWidget {
  const _InfinityIcon();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A5F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Icon(Icons.all_inclusive, color: Colors.white, size: 56),
      ),
    );
  }
}

class _LockIcon extends StatelessWidget {
  const _LockIcon();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF9E9E9E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF757575),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Icon(Icons.lock, color: Colors.black87, size: 44),
        ),
      ),
    );
  }
}

class _CloudIcon extends StatelessWidget {
  const _CloudIcon();
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.cloud, color: Color(0xFF40C4FF), size: 100);
  }
}
