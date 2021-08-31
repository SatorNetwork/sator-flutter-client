class EpisodeActivation {
  const EpisodeActivation(
    this.isActive,
    this.activatedAt,
    this.activatedBefore,
  );

  final bool isActive;
  final DateTime? activatedAt;
  final DateTime? activatedBefore;

  int leftHours() {
    if (activatedBefore == null) {
      return 0;
    } else {
      return activatedBefore!
          .difference(
            DateTime.now(),
          )
          .inHours;
    }
  }
}
