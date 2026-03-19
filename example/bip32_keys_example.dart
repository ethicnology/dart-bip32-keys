import 'dart:typed_data';

import 'package:bip32_keys/bip32_keys.dart';
import 'package:bip39_mnemonic/bip39_mnemonic.dart' as bip39;

void main() {
  final bip39.Mnemonic mnemonic = bip39.Mnemonic.fromSentence(
    "zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong",
    bip39.Language.english,
  );

  print('=== Convenience API (Recommended) ===\n');
  convenienceApiExample(mnemonic);

  print('\n=== Low-Level API (Advanced) ===\n');
  lowLevelApiExample(mnemonic);
}

void convenienceApiExample(bip39.Mnemonic mnemonic) {
  final masterNode = Bip32MasterNode.fromSeed(
    Uint8List.fromList(mnemonic.seed),
  );

  final bip44 = masterNode.toBip44Legacy();
  print('BIP44 (Legacy P2PKH):');
  print('  xprv: ${bip44.extendedPrivateKey}');
  print('  xpub: ${bip44.extendedPublicKey}');
  print('  WIF:  ${bip44.wif}');

  final bip49 = masterNode.toBip49NestedSegwit();
  print('\nBIP49 (Nested SegWit P2SH-P2WPKH):');
  print('  yprv: ${bip49.extendedPrivateKey}');
  print('  ypub: ${bip49.extendedPublicKey}');

  final bip84 = masterNode.toBip84SegwitWallet();
  print('\nBIP84 (Native SegWit P2WPKH):');
  print('  zprv: ${bip84.extendedPrivateKey}');
  print('  zpub: ${bip84.extendedPublicKey}');

  const xpub =
      'xpub6CfuVE8s2cAQijg7nqYKFoEu7AqkAfMNNMufV7utCmDjMjQZwM9RtN9PHxvBK4gkLWRyu8Xs6jh4TwRz8EYiFjWb8bxDMynAwyHZFxwzvkZ';
  final wallet = Bip32Accounts.from(xpub, Slip132.mainnetBip44SingleSig);
  print('\nImported from xpub:');
  print('  Private key: ${wallet.extendedPrivateKey ?? "null (watch-only)"}');
  print('  Public key:  ${wallet.extendedPublicKey}');
}

void lowLevelApiExample(bip39.Mnemonic mnemonic) {
  final root = Bip32Keys.fromSeed(Uint8List.fromList(mnemonic.seed));

  final rootBase58 = root.toBase58();
  print('Master private key:');
  print('  $rootBase58');

  final bip44LegacyXprv = root.derivePath("m/44'/0'/0'");
  final bip44LegacyXpub = bip44LegacyXprv.neutered.toBase58();
  print('\nBIP44 m/44\'/0\'/0\':');
  print('  xprv: ${bip44LegacyXprv.toBase58()}');
  print('  xpub: $bip44LegacyXpub');

  final bip49NestedSegwit = root.derivePath("m/49'/0'/0'");
  final bip49Yprv = bip49NestedSegwit.toBase58(
    overrideNetwork: Slip132.mainnetBip49SingleSig.network,
  );
  final bip49Ypub = bip49NestedSegwit.neutered.toBase58(
    overrideNetwork: Slip132.mainnetBip49SingleSig.network,
  );
  print('\nBIP49 m/49\'/0\'/0\' (with overrideNetwork):');
  print('  yprv: $bip49Yprv');
  print('  ypub: $bip49Ypub');

  final bip84Segwit = root.derivePath("m/84'/0'/0'");
  final bip84Zprv = bip84Segwit.toBase58(
    overrideNetwork: Slip132.mainnetBip84SingleSig.network,
  );
  final bip84Zpub = bip84Segwit.neutered.toBase58(
    overrideNetwork: Slip132.mainnetBip84SingleSig.network,
  );
  print('\nBIP84 m/84\'/0\'/0\' (with overrideNetwork):');
  print('  zprv: $bip84Zprv');
  print('  zpub: $bip84Zpub');
}
