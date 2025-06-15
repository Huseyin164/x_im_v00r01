import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_im_v00r01/feature/homenew/view_model/homenew_view_model.dart';
import 'package:x_im_v00r01/feature/homenew/view_model/state/homenew_state.dart';

class HomeFavoriteButton extends StatefulWidget {
  const HomeFavoriteButton({
    required this.storyId,
    this.size = 24,
    this.color,
    super.key,
  });

  final String storyId;
  final double size;
  final Color? color;

  @override
  State<HomeFavoriteButton> createState() => _HomeFavoriteButtonState();
}

class _HomeFavoriteButtonState extends State<HomeFavoriteButton> {
  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _checkFavoriteStatus() async {
    final viewModel = context.read<HomenewViewModel>();
    await viewModel.isFavorite(widget.storyId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomenewViewModel, HomenewState, (bool, bool, int)>(
      selector: (state) => (
        state.favorites[widget.storyId] ?? false,
        state.isLoadingFavRpc,
        state.favCount
      ),
      builder: (context, state) {
        final isFavorite = state.$1;
        print('isLoading: ${state.$1}');

        final viewModel = context.read<HomenewViewModel>();

        return TextButton.icon(
          onPressed: state.$2
              ? null
              : () async {
                  await viewModel.toggleFavoriteRPC(widget.storyId);
                  isFavorite
                      ? viewModel.setfavCount(state.$3 - 1)
                      : viewModel.setfavCount(state.$3 + 1);
                },
          iconAlignment: IconAlignment.end,
          icon: state.$2
              ? SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isFavorite ? Colors.red : (widget.color ?? Colors.grey),
                    ),
                  ),
                )
              : Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: widget.size,
                  color: isFavorite ? Colors.red : widget.color,
                ),
          label: BlocSelector<HomenewViewModel, HomenewState, int>(
            selector: (state) {
              return state.favCount;
            },
            builder: (context, state) {
              return Text(
                state.toString(),
              );
            },
          ),
          style: TextButton.styleFrom(
            iconColor: widget.color,
            minimumSize: const Size(0, 32),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            backgroundColor: Theme.of(context).colorScheme.surfaceBright,
          ),
        );
      },
    );
  }
}
