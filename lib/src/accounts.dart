import 'package:bip32_keys/bip32_keys.dart';

class Bip32Accounts {
  final Bip32Keys extendedKey;
  final Slip132 slip132Format;

  Bip32Accounts._(this.extendedKey, this.slip132Format);

  factory Bip32Accounts.from(
    String extendedKey,
    Slip132 slip132,
  ) {
    final extended =
        Bip32Keys.fromBase58(extendedKey, network: slip132.network);
    return Bip32Accounts._(extended, slip132);
  }

  String? get extendedPrivateKey => extendedKey.private != null
      ? extendedKey.toBase58(overrideNetwork: slip132Format.network)
      : null;

  String get extendedPublicKey =>
      extendedKey.neutered.toBase58(overrideNetwork: slip132Format.network);

  String? get wif => extendedKey.private != null ? extendedKey.toWIF() : null;
}
