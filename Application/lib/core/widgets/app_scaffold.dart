import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/network_banner.dart';

class AppNavDestination {
  const AppNavDestination({
    required this.key,
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.badgeCount,
  });

  final String key;
  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final int? badgeCount;
}

/// Adaptive scaffold that renders:
/// - Bottom [NavigationBar] on phones (`width < 600`), capping visible tabs at
///   5 and grouping additional items into a localized "More" bottom sheet.
/// - Compact [NavigationRail] on tablets (`600 <= width < 1024`).
/// - Extended [NavigationRail] sidebar on desktop/web (`width >= 1024`).
/// Also mounts [NetworkBanner] above the body.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.title,
    this.appBar,
    this.actions,
    this.destinations = const <AppNavDestination>[],
    this.selectedIndex = 0,
    this.onDestinationSelected,
    this.floatingActionButton,
    this.isOfflineOverride,
    super.key,
  });

  static const int maxBottomNavItems = 5;

  final Widget body;
  final String? title;
  final PreferredSizeWidget? appBar;
  final List<Widget>? actions;
  final List<AppNavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final Widget? floatingActionButton;
  final bool? isOfflineOverride;

  @override
  Widget build(BuildContext context) {
    final effectiveAppBar =
        appBar ??
        (title != null
            ? AppBar(
                title: Text(title!),
                actions: actions,
              )
            : null);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isCompact = width < AppBreakpoints.compactMaxWidth;
        final isExpanded = width >= AppBreakpoints.mediumMaxWidth;

        final contentWithBanner = Column(
          children: <Widget>[
            NetworkBanner(isOfflineOverride: isOfflineOverride),
            Expanded(child: body),
          ],
        );

        if (destinations.isEmpty) {
          return Scaffold(
            appBar: effectiveAppBar,
            body: contentWithBanner,
            floatingActionButton: floatingActionButton,
          );
        }

        if (isCompact) {
          return Scaffold(
            appBar: effectiveAppBar,
            body: contentWithBanner,
            floatingActionButton: floatingActionButton,
            bottomNavigationBar: _buildBottomNav(context),
          );
        }

        return Scaffold(
          appBar: effectiveAppBar,
          floatingActionButton: floatingActionButton,
          body: Row(
            children: <Widget>[
              NavigationRail(
                extended: isExpanded,
                selectedIndex: selectedIndex.clamp(0, destinations.length - 1),
                onDestinationSelected: onDestinationSelected,
                labelType: isExpanded
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.all,
                destinations: destinations
                    .map(
                      (dest) => NavigationRailDestination(
                        icon: _buildBadgedIcon(dest.icon, dest.badgeCount),
                        selectedIcon: _buildBadgedIcon(
                          dest.selectedIcon ?? dest.icon,
                          dest.badgeCount,
                        ),
                        label: Text(dest.label),
                      ),
                    )
                    .toList(),
              ),
              const VerticalDivider(width: 1, thickness: 1),
              Expanded(child: contentWithBanner),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final l10n = context.l10n;
    final hasOverflow = destinations.length > maxBottomNavItems;

    if (!hasOverflow) {
      return NavigationBar(
        selectedIndex: selectedIndex.clamp(0, destinations.length - 1),
        onDestinationSelected: onDestinationSelected,
        destinations: destinations
            .map(
              (dest) => NavigationDestination(
                icon: _buildBadgedIcon(dest.icon, dest.badgeCount),
                selectedIcon: _buildBadgedIcon(
                  dest.selectedIcon ?? dest.icon,
                  dest.badgeCount,
                ),
                label: dest.label,
              ),
            )
            .toList(),
      );
    }

    final primaryDestinations = destinations
        .take(maxBottomNavItems - 1)
        .toList();
    final overflowDestinations = destinations
        .skip(maxBottomNavItems - 1)
        .toList();
    final effectiveSelectedIndex = selectedIndex < maxBottomNavItems - 1
        ? selectedIndex
        : maxBottomNavItems - 1;

    return NavigationBar(
      selectedIndex: effectiveSelectedIndex,
      onDestinationSelected: (tappedIndex) async {
        if (tappedIndex < maxBottomNavItems - 1) {
          onDestinationSelected?.call(tappedIndex);
          return;
        }
        final chosenIndex = await _showOverflowSheet(
          context,
          overflowDestinations: overflowDestinations,
          baseIndex: maxBottomNavItems - 1,
        );
        if (chosenIndex != null) {
          onDestinationSelected?.call(chosenIndex);
        }
      },
      destinations: <Widget>[
        ...primaryDestinations.map(
          (dest) => NavigationDestination(
            icon: _buildBadgedIcon(dest.icon, dest.badgeCount),
            selectedIcon: _buildBadgedIcon(
              dest.selectedIcon ?? dest.icon,
              dest.badgeCount,
            ),
            label: dest.label,
          ),
        ),
        NavigationDestination(
          icon: const Icon(Icons.more_horiz),
          selectedIcon: const Icon(Icons.more_horiz),
          label: l10n.commonMore,
        ),
      ],
    );
  }

  Future<int?> _showOverflowSheet(
    BuildContext context, {
    required List<AppNavDestination> overflowDestinations,
    required int baseIndex,
  }) {
    return showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: overflowDestinations.length,
            itemBuilder: (itemContext, idx) {
              final dest = overflowDestinations[idx];
              final actualIndex = baseIndex + idx;
              final isSelected = actualIndex == selectedIndex;
              return ListTile(
                selected: isSelected,
                leading: _buildBadgedIcon(
                  isSelected ? (dest.selectedIcon ?? dest.icon) : dest.icon,
                  dest.badgeCount,
                ),
                title: Text(dest.label),
                onTap: () => Navigator.of(sheetContext).pop(actualIndex),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBadgedIcon(IconData icon, int? badgeCount) {
    if (badgeCount == null || badgeCount <= 0) {
      return Icon(icon);
    }
    return Badge.count(
      count: badgeCount,
      child: Icon(icon),
    );
  }
}
