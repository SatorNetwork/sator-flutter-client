class EpisodeActivation {
  const EpisodeActivation(
    this.isActive,
    this.activatedAt,
    this.activatedBefore,
  );

  final bool isActive;
  final DateTime? activatedAt;
  final DateTime? activatedBefore;

  Duration get _leftTime => activatedBefore == null
      ? Duration.zero
      : activatedBefore!.difference(
          DateTime.now(),
        );

  int leftTimeInHours() {
    return _leftTime.inHours;
  }

  int leftTimeInSeconds() {
    return _leftTime.inSeconds;
  }

  String leftTimeAsString() {
    int hours = 0;
    int minutes = 0;
    if (activatedBefore != null) {
      Duration diff = activatedBefore!.difference(
        DateTime.now(),
      );
      hours = diff.inHours;
      minutes = diff.inMinutes.remainder(60);
    }

    return '$hours:${minutes.toString().padLeft(2, '0')}';
  }
}
