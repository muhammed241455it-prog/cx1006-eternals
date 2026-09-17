import 'package:flutter/material.dart';

/// A dependency-free, accessible placeholder for Indian Sign Language (ISL)
/// video guidance. In a full implementation this would trigger a short ISL
/// video clip explaining the current form field/section.
class IslGuidanceCard extends StatefulWidget {
  const IslGuidanceCard({
    super.key,
    this.title = 'Indian Sign Language (ISL) Guidance',
    this.description =
        'Play a short ISL video that explains how to fill this form, '
        'field by field.',
  });

  final String title;
  final String description;

  @override
  State<IslGuidanceCard> createState() => _IslGuidanceCardState();
}

class _IslGuidanceCardState extends State<IslGuidanceCard> {
  bool _isPlaying = false;

  void _togglePlayback() {
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      container: true,
      label: widget.title,
      hint: widget.description,
      child: Card(
        color: colorScheme.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExcludeSemantics(
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: colorScheme.secondary,
                  child: Icon(
                    Icons.sign_language,
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExcludeSemantics(
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ExcludeSemantics(
                      child: Text(
                        widget.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Semantics(
                      button: true,
                      label: _isPlaying
                          ? 'Pause ISL guidance video'
                          : 'Play ISL guidance video',
                      child: ExcludeSemantics(
                        child: OutlinedButton.icon(
                          onPressed: _togglePlayback,
                          icon: Icon(
                            _isPlaying
                                ? Icons.pause_circle
                                : Icons.play_circle,
                          ),
                          label: Text(
                            _isPlaying ? 'Pause' : 'Play ISL Guidance',
                          ),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 44),
                          ),
                        ),
                      ),
                    ),
                    if (_isPlaying) ...[
                      const SizedBox(height: 10),
                      Semantics(
                        liveRegion: true,
                        label:
                            'Playing ISL guidance for this section. In the '
                            'full product this shows a short sign-language '
                            'video.',
                        child: ExcludeSemantics(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.videocam, size: 18),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Playing ISL guidance video '
                                    '(demo placeholder)',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}