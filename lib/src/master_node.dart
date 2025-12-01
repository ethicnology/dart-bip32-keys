import 'dart:typed_data';

import 'package:bip32_keys/bip32_keys.dart';

class Bip32MasterNode {
  final Bip32Keys _masterNode;

  Bip32MasterNode(this._masterNode);

  factory Bip32MasterNode.fromSeed(Uint8List seed, {Bip32Network? network}) {
    final masterNode = Bip32Keys.fromSeed(seed, network: network);
    return Bip32MasterNode(masterNode);
  }

  Bip32Accounts toBip44Legacy({
    int coinType = 0,
    int account = 0,
  }) {
    const slip132 = Slip132.mainnetBip44SingleSig;
    final bip44Legacy = _masterNode.derivePath("m/44'/$coinType'/$account'");
    final extendedPrivateKey = bip44Legacy.toBase58(
      overrideNetwork: slip132.network,
    );
    return Bip32Accounts.from(extendedPrivateKey, slip132);
  }

  Bip32Accounts toBip49NestedSegwit({int coinType = 0, int account = 0}) {
    const slip132 = Slip132.mainnetBip49SingleSig;
    final bip49NestedSegwit =
        _masterNode.derivePath("m/49'/$coinType'/$account'");
    final extendedPrivateKey = bip49NestedSegwit.toBase58(
      overrideNetwork: slip132.network,
    );
    return Bip32Accounts.from(extendedPrivateKey, slip132);
  }

  Bip32Accounts toBip84SegwitWallet({int coinType = 0, int account = 0}) {
    const slip132 = Slip132.mainnetBip84SingleSig;
    final bip84SegwitKey = _masterNode.derivePath("m/84'/$coinType'/$account'");
    final extendedPrivateKey = bip84SegwitKey.toBase58(
      overrideNetwork: slip132.network,
    );
    return Bip32Accounts.from(extendedPrivateKey, slip132);
  }
}
