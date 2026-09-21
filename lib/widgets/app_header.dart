import 'package:flutter/material.dart';

/// Screens available from the main application header.
enum AppScreen {
  home,
  broken,
  remediated,
  focused,
  error,
  isl,
  success,
  wcag,
}

/// Premium CX1006 application header.
///
/// Converted from the Figma Make Header.tsx design.
///
/// Design palette:
/// White      #FFFFFF
/// Midnight   #0F1E33
/// Cobalt     #2E4A67
/// Brass      #B89458
/// Parchment  #D8CEBE
/// Porcelain  #F4F0E8
class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.current,
    required this.onNavigate,
  });

  final AppScreen current;
  final ValueChanged<AppScreen> onNavigate;

  static const Color midnight = Color(0xFF0F1E33);
  static const Color cobalt = Color(0xFF2E4A67);
  static const Color brass = Color(0xFFB89458);
  static const Color parchment = Color(0xFFD8CEBE);
  static const Color white = Color(0xFFFFFFFF);

  static const List<_NavItem> _navItems = [
    _NavItem(
      label: 'Home',
      screen: AppScreen.home,
    ),
    _NavItem(
      label: 'Accessibility',
      screen: AppScreen.wcag,
    ),
    _NavItem(
      label: 'Demo',
      screen: AppScreen.remediated,
    ),
    _NavItem(
      label: 'About',
      screen: AppScreen.broken,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: midnight,
      elevation: 0,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints(
                minHeight: 64,
              ),
              decoration: const BoxDecoration(
                color: midnight,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0x26D8CEBE),
                    width: 1,
                  ),
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 768;

                        return Row(
                          children: [
                            _buildBrand(context),

                            if (!isMobile) ...[
                              const SizedBox(width: 24),
                              Expanded(
                                child: _buildDesktopNavigation(context),
                              ),
                              const SizedBox(width: 16),
                              _buildAccessibilityButton(context),
                            ] else
                              const Spacer(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Mobile navigation.
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 768) {
                  return const SizedBox.shrink();
                }

                return _buildMobileNavigation(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrand(BuildContext context) {
    return Semantics(
      button: true,
      label: 'CX1006 ETERNALS. Home',
      child: InkWell(
        onTap: () => onNavigate(AppScreen.home),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: brass,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'CX',
                  style: TextStyle(
                    color: midnight,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'CX1006',
                style: TextStyle(
                  color: white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(width: 4),
              if (MediaQuery.sizeOf(context).width >= 480)
                const Text(
                  '· ETERNALS',
                  style: TextStyle(
                    color: parchment,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNavigation(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final item in _navItems)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _buildNavigationButton(
                context,
                item,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(
    BuildContext context,
    _NavItem item,
  ) {
    final bool selected = current == item.screen;

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: () => onNavigate(item.screen),
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: selected
                ? brass.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border(
              bottom: BorderSide(
                color: selected ? brass : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            item.label,
            style: TextStyle(
              color: selected ? brass : parchment,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccessibilityButton(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Accessibility',
      child: Material(
        color: cobalt,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => onNavigate(AppScreen.wcag),
          borderRadius: BorderRadius.circular(8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 44,
              minWidth: 44,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.accessibility_new,
                    size: 18,
                    color: white,
                  ),
                  const SizedBox(width: 8),
                  if (MediaQuery.sizeOf(context).width >= 900)
                    const Text(
                      'Accessibility',
                      style: TextStyle(
                        color: white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavigation(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: midnight,
        border: Border(
          top: BorderSide(
            color: Color(0x26D8CEBE),
            width: 1,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          children: [
            for (final item in _navItems)
              Padding(
                padding: const EdgeInsets.only(
                  right: 4,
                ),
                child: _buildNavigationButton(
                  context,
                  item,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.screen,
  });

  final String label;
  final AppScreen screen;
}