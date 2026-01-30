import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class ExpandableFab extends StatefulWidget {
  final VoidCallback onAnalyse;
  final VoidCallback onCreate;

  const ExpandableFab({
    super.key,
    required this.onAnalyse,
    required this.onCreate,
  });

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconRotation;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    // Rotate 45 degrees (pi/4)
    _iconRotation = Tween<double>(begin: 0.0, end: 0.125).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _toggle() {
    if (_isOpen) {
      _close();
    } else {
      _open();
    }
  }

  void _open() {
    _controller.forward();
    _showOverlay();
    setState(() {
      _isOpen = true;
    });
  }

  void _close() {
    _controller.reverse();
    _removeOverlay();
    setState(() {
      _isOpen = false;
    });
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Barrier to close on click outside
          Positioned.fill(
            child: GestureDetector(
              onTap: _close,
              behavior: HitTestBehavior.translucent,
              child: Container(
                color: Colors.black.withValues(alpha: 0.01), // Subtle barrier
              ),
            ),
          ),
          // Popup Menu
          Positioned(
            width: 200, // Fixed width for the popup
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              // Offset to center the popup above the FAB
              // FAB width is 64, Popup width is 200. Center difference is (200-64)/2 = 68.
              // We want it above the FAB. Let's say 16px gap.
              offset: const Offset(-(200 - 64) / 2, -130), 
              child: _FabPopup(
                onAnalyse: () {
                  _close();
                  widget.onAnalyse();
                },
                onCreate: () {
                  _close();
                  widget.onCreate();
                },
                animation: _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: _toggle,
          backgroundColor: AppColors.primaryBlue,
          shape: const CircleBorder(),
          elevation: 8,
          // Accessibility
          tooltip: _isOpen ? 'Close menu' : 'Open menu',
          child: RotationTransition(
            turns: _iconRotation,
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}

class _FabPopup extends StatelessWidget {
  final VoidCallback onAnalyse;
  final VoidCallback onCreate;
  final Animation<double> animation;

  const _FabPopup({
    required this.onAnalyse,
    required this.onCreate,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      ),
      alignment: Alignment.bottomCenter,
      child: FadeTransition(
        opacity: animation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PopupOption(
                icon: Icons.analytics_outlined,
                label: 'Analyse',
                onTap: onAnalyse,
                color: AppColors.primaryBlue,
              ),
              const Divider(height: 16, thickness: 0.5),
              _PopupOption(
                icon: Icons.edit_document,
                label: 'Create',
                onTap: onCreate,
                color: AppColors.primaryBlue,
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}

class _PopupOption extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _PopupOption({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  State<_PopupOption> createState() => _PopupOptionState();
}

class _PopupOptionState extends State<_PopupOption> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Semantics(
        button: true,
        label: widget.label,
        child: GestureDetector(
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque, // Ensure full area is clickable
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: _isHovered ? widget.color.withValues(alpha: 0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(widget.icon, size: 20, color: widget.color),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
