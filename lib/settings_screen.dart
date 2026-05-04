import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.grid_view_rounded, color: Colors.blue),
          onPressed: () {},
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.blue, fontSize: 17),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. PROFILE SECTION
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // នៅក្នុងផ្នែក PROFILE SECTION
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFFE1E1E1),
                    backgroundImage: const AssetImage(
                      'assets/CHENHG.jpg',
                    ), // កន្លែងនេះ
                    onBackgroundImageError: (_, _) {},
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "THANG CHENG សុខម ថា...",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "+855 71 554 1435 • @Thangcheng_sok...",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. Change Profile Photo
            _buildSection([
              _buildListTile(
                Icons.add_a_photo_outlined,
                "Change Profile Photo",
                Colors.blue,
              ),
            ]),

            // 3. Feed Section Title
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "កន្លែងគ្រប់គ្រងតេលេក្រាម",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // 4. Feed Cards
            _buildFeedSection(),

            const SizedBox(height: 40),
          ],
        ),
      ),
      // បានដក bottomNavigationBar: _buildBottomNav(), ចេញពីទីនេះ
    );
  }

  Widget _buildSection(List<Widget> tiles) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: tiles),
    );
  }

  Widget _buildListTile(IconData icon, String title, Color iconColor) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: iconColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.blue),
      ),
      onTap: () {},
    );
  }

  // ── FEED ────────────────────────────────────────────────────────────────────

  Widget _buildFeedSection() {
    return Column(
      children: [
        // Post 1 – Procession
        _buildFeedPostCard(
          avatarUrl: 'https://i.pravatar.cc/150?img=10',
          name: "Khmer News Network",
          timeStamp: "1 hr ago •",
          description:
              "ពិធីបុណ្យប្រពៃណីរបស់ជនជាតិខ្មែរ សម្រាប់ជនជាតិខ្មែរគ្រប់រូប...",
          mainImageUrl: 'https://picsum.photos/seed/procession/600/300',
          likes: 54,
          comments: 0,
          shares: 0,
        ),
        // Post 2 – Tech
        _buildFeedPostCard(
          avatarUrl: 'https://i.pravatar.cc/150?img=20',
          name: "Tech News Cambodia",
          timeStamp: "2 hrs ago",
          description:
              "ពិនិត្យសកម្មភាពផ្សេងៗ នៃការមកដល់របស់ទូរស័ព្ទដៃស៊េរីថ្មី...",
          mainImageUrl:
              'https://www.google.com/imgres?q=chenla%20university&imgurl=https%3A%2F%2Fclu-edu.com%2Fwp-content%2Fuploads%2F2022%2F11%2F305840356_5701866549902497_6607003183705442526_n.jpeg&imgrefurl=https%3A%2F%2Fclu-edu.com%2F6766-2%2F&docid=yb0sBuZk9TH37M&tbnid=YtHSWL774j_tTM&vet=12ahUKEwj06p_u2Z6UAxU8-TgGHY1RMOMQnPAOegQIKxAB..i&w=2048&h=1536&hcb=2&ved=2ahUKEwj06p_u2Z6UAxU8-TgGHY1RMOMQnPAOegQIKxAB',
          likes: 3,
          comments: 2,
          shares: 1,
        ),
        // Post 2 – Tech
        _buildFeedPostCard(
          avatarUrl: 'https://i.pravatar.cc/150?img=20',
          name: "Student Chenla",
          timeStamp: "5 mns ago",
          description: "ពិនិត្យសកម្មភាពផ្សេងៗ នៃការសិក្សារបស់សិស្សនិស្សិត...",
          mainImageUrl: 'https://picsum.photos/seed/iphone/600/300',
          likes: 3,
          comments: 2,
          shares: 1,
        ),
        // Post 3 – Dresses
        _buildFeedPostCard(
          avatarUrl: 'https://i.pravatar.cc/150?img=30',
          name: "ហាងលក់សម្លៀកបំពាក់",
          timeStamp: "3 hrs ago",
          description: "សម្លៀកបំពាក់ថ្មីៗ សាកសមជាមួយសុភាពនារីគ្រប់រូប...",
          mainImageUrl: 'https://picsum.photos/seed/fashion/600/300',
          likes: 12,
          comments: 1,
          shares: 1,
        ),
      ],
    );
  }

  Widget _buildFeedPostCard({
    required String avatarUrl,
    required String name,
    required String timeStamp,
    required String description,
    String? mainImageUrl,
    required int likes,
    required int comments,
    required int shares,
    bool showFloatingReaction = false,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFE1E1E1),
              backgroundImage: NetworkImage(avatarUrl),
              onBackgroundImageError: (_, _) {},
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              timeStamp,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            trailing: const Icon(Icons.more_horiz, color: Colors.grey),
          ),
          // Main image with error fallback
          if (mainImageUrl != null)
            Image.network(
              mainImageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey.shade200,
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 48,
                ),
              ),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey.shade100,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          // Description
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Engagement bar
          _buildEngagementBar(likes, comments, shares, showFloatingReaction),
        ],
      ),
    );
  }

  Widget _buildEngagementBar(
    int likes,
    int comments,
    int shares,
    bool showFloatingReaction,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.thumb_up_alt_outlined,
                    color: Colors.blue,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "$likes Likes",
                    style: const TextStyle(color: Colors.blue, fontSize: 13),
                  ),
                  const Expanded(child: SizedBox()),
                  const Icon(
                    Icons.comment_outlined,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "$comments Comments",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    "and 53 others",
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  const Expanded(child: SizedBox()),
                  const Text(
                    "and 53 others",
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          if (showFloatingReaction)
            Positioned(
              right: 0,
              top: -4,
              child: Stack(
                children: [
                  _buildReactionsInteractionBubble(),
                  Positioned(
                    right: 0,
                    top: -10,
                    child: _buildIntegratedReactionsBubble(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIntegratedReactionsBubble() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.thumb_up, color: Colors.blue, size: 18),
          SizedBox(width: 4),
          Text(
            "54",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(width: 4),
          Icon(Icons.comment, color: Colors.blue, size: 18),
          SizedBox(width: 4),
          Text(
            "0",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(width: 4),
          Icon(Icons.bookmark, color: Colors.blue, size: 18),
        ],
      ),
    );
  }

  Widget _buildReactionsInteractionBubble() {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.thumb_up_alt_outlined, color: Colors.blue, size: 24),
          Icon(Icons.comment_outlined, color: Colors.grey, size: 24),
          Icon(Icons.reply_outlined, color: Colors.grey, size: 24),
        ],
      ),
    );
  }
}
