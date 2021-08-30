class EpisodeActivation {
  const EpisodeActivation(
    this.isActive,
    this.activatedAt,
    this.activatedBefore,
  );

  final bool isActive;
  final DateTime? activatedAt;
  final DateTime? activatedBefore;
}
