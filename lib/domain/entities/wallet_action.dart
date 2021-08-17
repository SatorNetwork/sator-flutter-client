class WalletAction {
  final String type;
  final String name;
  final String url;

  const WalletAction(this.type, this.name, this.url);
}

class Type {
  static const claim_rewards = 'claim_rewards';
  static const send_tokens = 'send_tokens';
  static const receive_tokens = 'receive_tokens';
  static const stake_tokens = 'stake_tokens';
}
