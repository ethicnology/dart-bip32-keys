import 'dart:typed_data';
import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:test/test.dart';
import 'package:bip32_keys/bip32_keys.dart';

class TestValues {
  final mnemonic = Mnemonic.fromSentence(
    "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about",
    Language.english,
  );

  static get derivedBip44Xprv =>
      'xprv9xpXFhFpqdQK3TmytPBqXtGSwS3DLjojFhTGht8gwAAii8py5X6pxeBnQ6ehJiyJ6nDjWGJfZ95WxByFXVkDxHXrqu53WCRGypk2ttuqncb';
  static get derivedBip44Xpub =>
      'xpub6BosfCnifzxcFwrSzQiqu2DBVTshkCXacvNsWGYJVVhhawA7d4R5WSWGFNbi8Aw6ZRc1brxMyWMzG3DSSSSoekkudhUd9yLb6qx39T9nMdj';

  static get derivedBip49Yprv =>
      'yprvAHwhK6RbpuS3dgCYHM5jc2ZvEKd7Bi61u9FVhYMpgMSuZS613T1xxQeKTffhrHY79hZ5PsskBjcc6C2V7DrnsMsNaGDaWev3GLRQRgV7hxF';
  static get derivedBip49Ypub =>
      'ypub6Ww3ibxVfGzLrAH1PNcjyAWenMTbbAosGNB6VvmSEgytSER9azLDWCxoJwW7Ke7icmizBMXrzBx9979FfaHxHcrArf3zbeJJJUZPf663zsP';

  static get derivedBip84Zprv =>
      'zprvAdG4iTXWBoARxkkzNpNh8r6Qag3irQB8PzEMkAFeTRXxHpbF9z4QgEvBRmfvqWvGp42t42nvgGpNgYSJA9iefm1yYNZKEm7z6qUWCroSQnE';
  static get derivedBip84Zpub =>
      'zpub6rFR7y4Q2AijBEqTUquhVz398htDFrtymD9xYYfG1m4wAcvPhXNfE3EfH1r1ADqtfSdVCToUG868RvUUkgDKf31mGDtKsAYz2oz2AGutZYs';

  // XPUB
  static get xpub =>
      'xpub6DJwRncrB8eNrzUq8XxgjwCZsEeWP8FeqBJbJQZ8JfuDwLdAzyjhHiHJieNuar1wjQTyihhMWtaKGE4DUd8uBgtyrNJqF5drwbNVUqb83b7';
  static get xpubFingerprint => '2bcd33b0';
  // conversions to other formats
  static get xpubToYpub =>
      'ypub6Y9CjTHmKpBriHfwxtkJx2J53CnxKkF9kHpp5oT1ggH6zSSQFduFumwSjrLVakfs93anUBHuyYvs9WfnCKYuyvaaii1FpzTMDKS8sVJo82W';
  static get xpubToZpub =>
      'zpub6ryU37xgUVjLZas4oFXwA7PaDAwQGNEefQM2sCLu4gez3YFdWJ4pXqbam4J5afKnYghbDetUSDHR2oHLv1xvnAGBb3hgQuGqV3VnG2rvas6';
  static get xpubToTpub =>
      'tpubDDgZx2SXtQbq8nfgaiwmwrXwCMkANWkiNottexcGeaf7gdHt5CanS9x8xgTh7LyBXJztLHDE3zQMxQYpsUz958MGuy48vcJ6XYxuEuPJAHp';
  static get xpubToUpub =>
      'upub5Ep9Wnc6j61wK6uUdTbp7fv4MLDAZGHA5qjvxDsUAeman3BVF1F1RXJtf2W9b84BWV7ZUGug8uWfcNDXKXtrnyrBFMDZVMBQ8RBZK5eWL4r';
  static get xpubToVpub =>
      'vpub5ZeQpTH1smZRAQ6bTpPSKm1ZXJMcVtGezxG9jcmMYf9Tq8ziVfQa3ay2gETjb2i6v8ENDkWEbZsDVeq63EJsbDXn7guz5FztQ9FChkr8jdA';

  // YPUB
  static get ypub =>
      'ypub6XepkBPvLjJ2P2XHVUEoYfYBUaHwg39ESnmxbs6UFHwk6rRAjanUahAm6cnmEBRytL2bvE7BZ7XpyDz9DP86yaReJNRD3KfVdCQM5YZ6LEs';
  static get ypubToXpub =>
      'xpub6CpZSWj1C3kYXjLAf7TBLaSgJc9VjR9jXgFjpUCasHZs3kbwUvcuxdWd5QqBEGn4UguoAkWd6TBH5wNaVgi6BLk3S2inTQr1MULhgxnrxKW';
  static get ypubFingerprint => 'ecd6654c';

// ZPUB
  static get zpub =>
      'zpub6ro6vd6Cn6apSQsrXVTE8d6UkygMYj1eAoXW9yUwbE2c1sfSQw2sEMyA4gGtxMpHv64NkoJdSYR7aEnJgUNNoQw7QZnys1vZ1qefVwPVc8T';
  static get zpubToXpub =>
      'xpub6D8aKHkNUjVrjpVcrmsyiSuUR3PTfV2eLaV4bBhAqDGqug2yuchjzEet2GMixYWT6opmFr7WXDi1ofZBF5YMCwZuftQ8hCHaUPXNiqfJvLs';
  static get zpubFingerprint => 'f6c41dd4';
}

void main() {
  group('SLIP-132 Tests', () {
    group('parse and tryParse functions', () {
      test('parse xpub format', () {
        final result = Slip132.parsePublicKey(TestValues.xpub);
        expect(result, Slip132.mainnetBip44SingleSig);
      });

      test('parse ypub format', () {
        final result = Slip132.parsePublicKey(TestValues.ypub);
        expect(result, Slip132.mainnetBip49SingleSig);
      });

      test('parse zpub format', () {
        final result = Slip132.parsePublicKey(TestValues.zpub);
        expect(result, Slip132.mainnetBip84SingleSig);
      });

      test('parse tpub format', () {
        final result = Slip132.parsePublicKey(TestValues.xpubToTpub);
        expect(result, Slip132.testnetBip44SingleSig);
      });

      test('parse upub format', () {
        final result = Slip132.parsePublicKey(TestValues.xpubToUpub);
        expect(result, Slip132.testnetBip49SingleSig);
      });

      test('parse vpub format', () {
        final result = Slip132.parsePublicKey(TestValues.xpubToVpub);
        expect(result, Slip132.testnetBip84SingleSig);
      });

      test('parse throws FormatException for invalid format', () {
        expect(() => Slip132.parsePublicKey('invalid'), throwsA(anything));
      });

      test('parse throws FormatException for short input', () {
        expect(() => Slip132.parsePublicKey('abc'), throwsA(anything));
      });
    });

    test('xpub fingerprint', () {
      final result =
          getFingerprint(TestValues.xpub, Slip132.mainnetBip44SingleSig);
      expect(result, TestValues.xpubFingerprint);
    });

    test('ypub to xpub conversion', () {
      final result = changeVersionBytes(TestValues.ypub,
          Slip132.mainnetBip44SingleSig.network.version.public);
      expect(result, TestValues.ypubToXpub);
    });

    test('ypub fingerprint', () {
      final result =
          getFingerprint(TestValues.ypub, Slip132.mainnetBip49SingleSig);
      expect(result, TestValues.ypubFingerprint);
    });

    test('zpub to xpub conversion', () {
      final result = changeVersionBytes(TestValues.zpub,
          Slip132.mainnetBip44SingleSig.network.version.public);
      expect(result, TestValues.zpubToXpub);
    });

    test('zpub fingerprint', () {
      final result =
          getFingerprint(TestValues.zpub, Slip132.mainnetBip84SingleSig);
      expect(result, TestValues.zpubFingerprint);
    });

    test('xpub to ypub conversion', () {
      final result = changeVersionBytes(TestValues.xpub,
          Slip132.mainnetBip49SingleSig.network.version.public);
      expect(result, TestValues.xpubToYpub);
    });

    test('xpub to zpub conversion', () {
      final result = changeVersionBytes(TestValues.xpub,
          Slip132.mainnetBip84SingleSig.network.version.public);
      expect(result, TestValues.xpubToZpub);
    });

    test('xpub to tpub conversion', () {
      final result = changeVersionBytes(TestValues.xpub,
          Slip132.testnetBip44SingleSig.network.version.public);
      expect(result, TestValues.xpubToTpub);
    });

    test('xpub to upub conversion', () {
      final result = changeVersionBytes(TestValues.xpub,
          Slip132.testnetBip49SingleSig.network.version.public);
      expect(result, TestValues.xpubToUpub);
    });

    test('xpub to vpub conversion', () {
      final result = changeVersionBytes(TestValues.xpub,
          Slip132.testnetBip84SingleSig.network.version.public);
      expect(result, TestValues.xpubToVpub);
    });

    test('derive keys from seed', () {
      final seed = Uint8List.fromList(TestValues().mnemonic.seed);
      final root = Bip32Keys.fromSeed(seed);

      // m/44'/0'/0'
      final bip44Ctx = root.derivePath("m/44'/0'/0'");
      expect(bip44Ctx.toBase58(), TestValues.derivedBip44Xprv);
      expect(bip44Ctx.neutered.toVersion(Slip132.mainnetBip44SingleSig),
          TestValues.derivedBip44Xpub);

      // m/49'/0'/0'
      final bip49Ctx = root.derivePath("m/49'/0'/0'");
      expect(bip49Ctx.toVersion(Slip132.mainnetBip49SingleSig),
          TestValues.derivedBip49Yprv);
      expect(bip49Ctx.neutered.toVersion(Slip132.mainnetBip49SingleSig),
          TestValues.derivedBip49Ypub);

      // m/84'/0'/0'
      final bip84Ctx = root.derivePath("m/84'/0'/0'");
      expect(bip84Ctx.toVersion(Slip132.mainnetBip84SingleSig),
          TestValues.derivedBip84Zprv);
      expect(bip84Ctx.neutered.toVersion(Slip132.mainnetBip84SingleSig),
          TestValues.derivedBip84Zpub);
    });
  });
}
