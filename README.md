[![codecov](https://codecov.io/gh/ethicnology/dart-bip32-keys/graph/badge.svg?token=J6E7XAI0FR)](https://codecov.io/gh/ethicnology/dart-bip32-keys)

# bip32_keys

A [BIP32](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki) library with [SLIP132](https://github.com/satoshilabs/slips/blob/master/slip-0132.md) support for Dart/Flutter community.

## Example

See `example/bip32_keys_example.dart` for a complete usage example.


## Supported SLIP-132 Formats

| Format | Description | Network |
|--------|-------------|---------|
| `xpub` | Legacy P2PKH | Bitcoin Mainnet |
| `ypub` | P2SH-P2WPKH | Bitcoin Mainnet |
| `Ypub` | P2SH-P2WSH | Bitcoin Mainnet |
| `zpub` | P2WPKH | Bitcoin Mainnet |
| `Zpub` | P2WSH | Bitcoin Mainnet |
| `tpub` | Legacy P2PKH | Bitcoin Testnet |
| `upub` | P2SH-P2WPKH | Bitcoin Testnet |
| `Upub` | P2SH-P2WSH | Bitcoin Testnet |
| `vpub` | P2WPKH | Bitcoin Testnet |
| `Vpub` | P2WSH | Bitcoin Testnet |

## Usage

### Convenience API (Recommended for most use cases)

The easiest way to work with BIP32/BIP44/BIP49/BIP84 wallets:

```dart
import 'dart:typed_data';
import 'package:bip32_keys/bip32_keys.dart';
import 'package:bip39_mnemonic/bip39_mnemonic.dart' as bip39;

void main() {
  final mnemonic = bip39.Mnemonic.fromSentence(
    "zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong",
    bip39.Language.english,
  );

  final masterNode = Bip32MasterNode.fromSeed(
    Uint8List.fromList(mnemonic.seed)
  );

  // BIP44 - Legacy addresses (P2PKH)
  final bip44 = masterNode.toBip44Legacy();
  print('BIP44 xprv: ${bip44.extendedPrivateKey}');
  print('BIP44 xpub: ${bip44.extendedPublicKey}');

  // BIP49 - Nested SegWit addresses (P2SH-P2WPKH)
  final bip49 = masterNode.toBip49NestedSegwit();
  print('BIP49 yprv: ${bip49.extendedPrivateKey}');
  print('BIP49 ypub: ${bip49.extendedPublicKey}');

  // BIP84 - Native SegWit addresses (P2WPKH)
  final bip84 = masterNode.toBip84SegwitWallet();
  print('BIP84 zprv: ${bip84.extendedPrivateKey}');
  print('BIP84 zpub: ${bip84.extendedPublicKey}');

  // Import from extended key
  const xpub = 'xpub6CfuVE8s2cAQijg7nqYKFoEu7AqkAfMNNMufV7utCmDjMjQZwM9RtN9PHxvBK4gkLWRyu8Xs6jh4TwRz8EYiFjWb8bxDMynAwyHZFxwzvkZ';
  final wallet = Bip32Accounts.from(xpub, Slip132.mainnetBip44SingleSig);
  print('Imported xpub: ${wallet.extendedPublicKey}');
}
```

### Low-Level API (For advanced use cases)

Direct access to BIP32 operations with full control:

```dart
import 'package:bip32_keys/bip32_keys.dart';

void main() {
  const xprv =
      'xprv9s21ZrQH143K3QTDL4LXw2F7HEK3wJUD2nW2nRk4stbPy6cq3jPPqjiChkVvvNKmPGJxWUtg6LnF5kejMRNNU3TGtRBeJgk33yuGBxrMPHi';
  final masterKey = Bip32Keys.fromBase58(xprv);

  // Derive a child key
  final childKey = masterKey.derive(0);
  print('Child key: ${childKey.toBase58()}');

  // Derive a hardened child key
  final hardenedChildKey = masterKey.deriveHardened(0);
  print('Hardened child key: ${hardenedChildKey.toBase58()}');

  // Derive a path
  final pathKey = masterKey.derivePath("m/44'/0'/0'/0/0");
  print('Path key: ${pathKey.toBase58()}');

  // Get neutered version (public only)
  final neuteredKey = masterKey.neutered;
  print('Neutered key: ${neuteredKey.toBase58()}');

  // Convert to different SLIP-132 formats
  final bip49Key = masterKey.derivePath("m/49'/0'/0'");
  final ypub = bip49Key.neutered.toBase58(
    overrideNetwork: Slip132.mainnetBip49SingleSig.network
  );
  print('ypub format: $ypub');
}
```
