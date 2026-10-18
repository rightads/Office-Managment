import 'package:flutter/material.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/empty_state.dart';
import 'package:right_ads/core/widgets/error_state.dart';
import 'package:right_ads/core/widgets/loading_skeleton.dart';

class PagedListView<T> extends StatefulWidget {
  const PagedListView({
    required this.items,
    required this.itemBuilder,
    required this.onRefresh,
    this.onLoadMore,
    this.hasMore = false,
    this.isInitialLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.emptyTitle,
    this.emptySubtitle,
    this.emptyIcon = Icons.inbox_outlined,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.scrollThreshold = 200,
    super.key,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Future<void> Function() onRefresh;
  final VoidCallback? onLoadMore;
  final bool hasMore;
  final bool isInitialLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final String? emptyTitle;
  final String? emptySubtitle;
  final IconData emptyIcon;
  final EdgeInsetsGeometry padding;
  final double scrollThreshold;

  @override
  State<PagedListView<T>> createState() => _PagedListViewState<T>();
}

class _PagedListViewState<T> extends State<PagedListView<T>> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (!widget.hasMore || widget.isLoadingMore || widget.isInitialLoading) {
      return;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= widget.scrollThreshold) {
      widget.onLoadMore?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isInitialLoading && widget.items.isEmpty) {
      return const LoadingSkeletonList();
    }

    if (widget.errorMessage != null && widget.items.isEmpty) {
      return ErrorState(
        message: widget.errorMessage,
        onRetry: widget.onRefresh,
      );
    }

    if (widget.items.isEmpty) {
      return RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                title: widget.emptyTitle,
                subtitle: widget.emptySubtitle,
                icon: widget.emptyIcon,
              ),
            ),
          ],
        ),
      );
    }

    final showFooter = widget.hasMore || widget.isLoadingMore;
    final totalCount = widget.items.length + (showFooter ? 1 : 0);

    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: widget.padding,
        itemCount: totalCount,
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          if (index >= widget.items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return widget.itemBuilder(context, widget.items[index], index);
        },
      ),
    );
  }
}
