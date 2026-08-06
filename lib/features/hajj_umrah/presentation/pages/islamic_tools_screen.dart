import 'package:flutter/material.dart';
import '/components/app_nav_bar.dart';
import '/components/app_header.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'hajj_dashboard_screen.dart';

class IslamicToolsScreen extends StatefulWidget {
  final int initialTab;

  const IslamicToolsScreen({super.key, this.initialTab = 0});

  @override
  State<IslamicToolsScreen> createState() => _IslamicToolsScreenState();
}

class _IslamicToolsScreenState extends State<IslamicToolsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      bottomNavigationBar: const AppNavBar(currentRoute: HajjDashboardScreen.routeName),
      body: Column(
        children: [
          AppHeader(
            title: 'Islamic Tools',
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: FlutterFlowTheme.of(context).primary,
              unselectedLabelColor: FlutterFlowTheme.of(context).secondaryText,
              indicatorColor: FlutterFlowTheme.of(context).primary,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'PRAYERS', icon: Icon(Icons.access_time)),
                Tab(text: 'QIBLA', icon: Icon(Icons.explore)),
                Tab(text: 'TASBEEH', icon: Icon(Icons.plus_one)),
                Tab(text: 'DUA GUIDE', icon: Icon(Icons.menu_book)),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPrayerTimes(),
                _buildQibla(),
                _buildTasbeeh(),
                _buildDuaGuide(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimes() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Center(
          child: Column(
            children: [
              Text('Next Prayer: Asr', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('03:45 PM', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF06402B))),
              Text('in 1 hour 12 mins', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _prayerRow('Fajr', '04:12 AM'),
        _prayerRow('Sunrise', '05:45 AM'),
        _prayerRow('Dhuhr', '12:30 PM'),
        _prayerRow('Asr', '03:45 PM', isNext: true),
        _prayerRow('Maghrib', '07:15 PM'),
        _prayerRow('Isha', '08:45 PM'),
      ],
    );
  }

  Widget _prayerRow(String name, String time, {bool isNext = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isNext ? const Color(0xFF06402B).withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isNext ? Border.all(color: const Color(0xFF06402B)) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(fontSize: 18, fontWeight: isNext ? FontWeight.bold : FontWeight.normal)),
          Text(time, style: TextStyle(fontSize: 18, fontWeight: isNext ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildQibla() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.explore, size: 200, color: Color(0xFF06402B)),
          const SizedBox(height: 32),
          const Text('Face the Kaaba', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('Makkah is 12° North East', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  int _count = 0;
  Widget _buildTasbeeh() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('SubhanAllah', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () => setState(() => _count++),
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xFF06402B),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$_count',
                style: const TextStyle(fontSize: 64, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 40),
          TextButton(
            onPressed: () => setState(() => _count = 0),
            child: const Text('Reset', style: TextStyle(color: Colors.red, fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Widget _buildDuaGuide() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _duaItem('Dua for entering Masjid al-Haram'),
        _duaItem('Dua for Tawaf'),
        _duaItem('Dua for Sa\'i'),
        _duaItem('Dua for Arafat'),
        _duaItem('Dua for leaving Makkah'),
      ],
    );
  }

  Widget _duaItem(String title) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
