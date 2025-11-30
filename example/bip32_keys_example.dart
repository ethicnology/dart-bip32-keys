import 'dart:typed_data';

import 'package:bip32_keys/bip32_keys.dart';
import 'package:bip39_mnemonic/bip39_mnemonic.dart' as bip39;

void main() {
  final bip39.Mnemonic mnemonic = bip39.Mnemonic.fromSentence(
    "zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong",
    bip39.Language.english,
  );

  final root = Bip32Keys.fromSeed(Uint8List.fromList(mnemonic.seed));

  // Bip32 called this key the root usually named master private key
  final rootBase58 = root.toBase58();
  assert(rootBase58 ==
      'xprv9s21ZrQH143K2PfMvkNViFc1fgumGqBew45JD8SxA59Jc5M66n3diqb92JjvaR61zT9P89Grys12kdtV4EFVo6tMwER7U2hcUmZ9VfMYPLC');
  print('Master key in WIF format: ${root.toWIF()}');

  final bip44LegacyXprv = root.derivePath("m/44'/0'/0'");
  final bip44LegacyXpub = bip44LegacyXprv.neutered.toBase58();
  assert(bip44LegacyXprv.toBase58() ==
      'xprv9ygZ5ibyCEc7WFbegp1JtfJAZ91FmCdX18z4gjWGeRgkUw5RPoqBLZpuShTUg5wd4DE6k11zFejPZdPWVZGSMGyo9tRyqURMqoSMGisXSFJ');
  assert(bip44LegacyXpub ==
      'xpub6CfuVE8s2cAQijg7nqYKFoEu7AqkAfMNNMufV7utCmDjMjQZwM9RtN9PHxvBK4gkLWRyu8Xs6jh4TwRz8EYiFjWb8bxDMynAwyHZFxwzvkZ');

  final bip49NestedSegwitYprv = root.derivePath("m/49'/0'/0'");
  final bip49NestedSegwitYpub =
      bip49NestedSegwitYprv.neutered.toVersion(Slip132.mainnetBip49SingleSig);
  assert(bip49NestedSegwitYprv.toVersion(Slip132.mainnetBip49SingleSig) ==
      'yprvAJdZBnj1tzxcQacxQ3GVVsSPCTe7yvppZr6DEUQjUv2gqJn1usqgrJtRJjX5d4vRZNURNFmMGaT6NGRrbFgWsGTgtDfMAouF3V4sYGQGj6B');
  assert(bip49NestedSegwitYpub ==
      'ypub6XcubJFujNWud4hRW4oVs1P7kVUcPPYfw51p2rpM3FZfi77ATR9wQ7Cu9yxtFsKHFNTvLbd2MxS4CLtC1YXvCqzbYnfDceSGDqUM33t2bAn');

  final bip84Segwit = root.derivePath("m/84'/0'/0'");
  final bip84SegwitZpub =
      bip84Segwit.neutered.toVersion(Slip132.mainnetBip84SingleSig);
  assert(bip84Segwit.toVersion(Slip132.mainnetBip84SingleSig) ==
      'zprvAdDikkudZ5f4EJkJWyCE1DWJptekiNMWcE2LJXZ7L9LCftRQo6sjQ4JTdFpWE7qMyMiby5qwrXRPP9v59Lf2VX7V8CvBiD48LsZM85Cd4Cf');
  assert(bip84SegwitZpub ==
      'zpub6rD5AGSXPTDMSnpmczjENMT3NvVF7q5MySww6uxitUsBYgkZLeBywrcwUWhW5YkeY2aS7xc45APPgfA6s6wWfG2gnfABq6TDz9zqeMu2JCY');

  // SLIP-132 integration examples
  print('\n=== SLIP-132 Examples ===');

  // // Convert to different SLIP-132 formats
  // print('zpub format: ${neuteredKey.toSlip132(Slip132Format.zpub)}');
  // print('ypub format: ${neuteredKey.toSlip132(Slip132Format.ypub)}');

  // // Get fingerprints in different formats
  // print(
  //     'Fingerprint (xpub): ${neuteredKey.getSlip132Fingerprint(Slip132Format.xpub)}');
  // print(
  //     'Fingerprint (zpub): ${neuteredKey.getSlip132Fingerprint(Slip132Format.zpub)}');
  // print(
  //     'Parent fingerprint: ${neuteredKey.getSlip132ParentFingerprint(Slip132Format.xpub)}');

  // // Create from existing xpub
  // final existingXpub =
  //     "xpub6DJwRncrB8eNrzUq8XxgjwCZsEeWP8FeqBJbJQZ8JfuDwLdAzyjhHiHJieNuar1wjQTyihhMWtaKGE4DUd8uBgtyrNJqF5drwbNVUqb83b7";
  // final importedKey = Bip32Keys.fromBase58(existingXpub);

  // print('\n=== Imported Key Examples ===');
  // print('Original xpub: $existingXpub');
  // print('Converted to zpub: ${importedKey.toSlip132(Slip132Format.zpub)}');
  // print(
  //     'Fingerprint: ${importedKey.getSlip132Fingerprint(Slip132Format.xpub)}');
}
