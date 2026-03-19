import 'dart:typed_data';
import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:test/test.dart';
import 'package:bip32_keys/bip32_keys.dart';

class TestValues {
  final mnemonic = Mnemonic.fromSentence(
    "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about",
    Language.english,
  );

  final zooMnemonic = Mnemonic.fromSentence(
    "zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong",
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

    test('Another Bip32Accounts convenience API', () {
      final seed = Uint8List.fromList(TestValues().mnemonic.seed);
      final masterNode = Bip32MasterNode.fromSeed(seed);

      final bip44Wallet = masterNode.toBip44Legacy();
      expect(bip44Wallet.extendedPrivateKey, TestValues.derivedBip44Xprv);
      expect(bip44Wallet.extendedPublicKey, TestValues.derivedBip44Xpub);

      final bip49Wallet = masterNode.toBip49NestedSegwit();
      expect(bip49Wallet.extendedPrivateKey, TestValues.derivedBip49Yprv);
      expect(bip49Wallet.extendedPublicKey, TestValues.derivedBip49Ypub);

      final bip84Wallet = masterNode.toBip84SegwitWallet();
      expect(bip84Wallet.extendedPrivateKey, TestValues.derivedBip84Zprv);
      expect(bip84Wallet.extendedPublicKey, TestValues.derivedBip84Zpub);
    });

    test('convenience API with Zoo Mnemonic account 0', () {
      final seed = Uint8List.fromList(TestValues().zooMnemonic.seed);
      final masterNode = Bip32MasterNode.fromSeed(seed);

      final bip44Wallet = masterNode.toBip44Legacy(account: 0);
      expect(bip44Wallet.extendedPrivateKey,
          'xprv9ygZ5ibyCEc7WFbegp1JtfJAZ91FmCdX18z4gjWGeRgkUw5RPoqBLZpuShTUg5wd4DE6k11zFejPZdPWVZGSMGyo9tRyqURMqoSMGisXSFJ');
      expect(bip44Wallet.extendedPublicKey,
          'xpub6CfuVE8s2cAQijg7nqYKFoEu7AqkAfMNNMufV7utCmDjMjQZwM9RtN9PHxvBK4gkLWRyu8Xs6jh4TwRz8EYiFjWb8bxDMynAwyHZFxwzvkZ');

      final bip49Wallet = masterNode.toBip49NestedSegwit(account: 0);
      expect(bip49Wallet.extendedPrivateKey,
          'yprvAJdZBnj1tzxcQacxQ3GVVsSPCTe7yvppZr6DEUQjUv2gqJn1usqgrJtRJjX5d4vRZNURNFmMGaT6NGRrbFgWsGTgtDfMAouF3V4sYGQGj6B');
      expect(bip49Wallet.extendedPublicKey,
          'ypub6XcubJFujNWud4hRW4oVs1P7kVUcPPYfw51p2rpM3FZfi77ATR9wQ7Cu9yxtFsKHFNTvLbd2MxS4CLtC1YXvCqzbYnfDceSGDqUM33t2bAn');

      final bip84Wallet = masterNode.toBip84SegwitWallet(account: 0);
      expect(bip84Wallet.extendedPrivateKey,
          'zprvAdDikkudZ5f4EJkJWyCE1DWJptekiNMWcE2LJXZ7L9LCftRQo6sjQ4JTdFpWE7qMyMiby5qwrXRPP9v59Lf2VX7V8CvBiD48LsZM85Cd4Cf');
      expect(bip84Wallet.extendedPublicKey,
          'zpub6rD5AGSXPTDMSnpmczjENMT3NvVF7q5MySww6uxitUsBYgkZLeBywrcwUWhW5YkeY2aS7xc45APPgfA6s6wWfG2gnfABq6TDz9zqeMu2JCY');
    });

    test('convenience API with Zoo Mnemonic account 1', () {
      final seed = Uint8List.fromList(TestValues().zooMnemonic.seed);
      final masterNode = Bip32MasterNode.fromSeed(seed);

      final bip44Wallet = masterNode.toBip44Legacy(account: 1);
      expect(bip44Wallet.extendedPrivateKey,
          'xprv9ygZ5ibyCEc7b1jnq9sFayWvNWxxG1oR85qWfAnaRdqSrxSuq697goobSwgc4DuGfVU1t6X941uyaSFXS59rAyKFNPYM9i5rFhUFJZJDDWp');
      expect(bip44Wallet.extendedPublicKey,
          'xpub6CfuVE8s2cAQoVpFwBQFx7TevYoSfUXGVJm7TZCByyNRjkn4NdTNEc85JFZdqy8bqQSPsXtgDbqwyFemyP7UywpnfprxabuE22uQgBzdi9r');

      final bip49Wallet = masterNode.toBip49NestedSegwit(account: 1);
      expect(bip49Wallet.extendedPrivateKey,
          'yprvAJdZBnj1tzxcSyEyPzemuM5CcBXEyybZx4piXd21rSJbWdQzbyexDg26hmgYaBRi1HNzpuJFY4ZNNQieUqxo73q81RtUG6uvE58D2ZxrTER');
      expect(bip49Wallet.extendedPublicKey,
          'ypub6XcubJFujNWufTKSW2BnGV1wADMjPSKRKHkKL1RdQmqaPRk99WyCmULaZ3cbxo7Y6fQTji5CpEPuW7TT3K6UFyTyC1GURVnfuvEGvNsn2Vd');

      final bip84Wallet = masterNode.toBip84SegwitWallet(account: 1);
      expect(bip84Wallet.extendedPrivateKey,
          'zprvAdDikkudZ5f4G6NAwYjDUNoLMKdTDPY6cfpj6psA9iGgbwxv5seGjmdEgG9E3Mgtx6jtX8QStZRqyKhPsW5qvsFQjb9HXbvyCFiSzM1Ffut');
      expect(bip84Wallet.extendedPublicKey,
          'zpub6rD5AGSXPTDMUaSe3aGDqWk4uMTwcrFwytkKuDGmi3ofUkJ4dQxXHZwiXWbHHrELJAor8xGs61F8sbKS2JdQkLZRnu5PGktmr6F32nEBUBb');
    });

    test('convenience API from Zoo Mnemonic XPRV', () {
      const bip44Xprv =
          'xprv9ygZ5ibyCEc7WFbegp1JtfJAZ91FmCdX18z4gjWGeRgkUw5RPoqBLZpuShTUg5wd4DE6k11zFejPZdPWVZGSMGyo9tRyqURMqoSMGisXSFJ';
      const bip44Xpub =
          'xpub6CfuVE8s2cAQijg7nqYKFoEu7AqkAfMNNMufV7utCmDjMjQZwM9RtN9PHxvBK4gkLWRyu8Xs6jh4TwRz8EYiFjWb8bxDMynAwyHZFxwzvkZ';
      final bip44Wallet =
          Bip32Accounts.from(bip44Xprv, Slip132.mainnetBip44SingleSig);

      expect(bip44Wallet.extendedPrivateKey, bip44Xprv);
      expect(bip44Wallet.extendedPublicKey, bip44Xpub);

      const bip49Yprv =
          'yprvAJdZBnj1tzxcQacxQ3GVVsSPCTe7yvppZr6DEUQjUv2gqJn1usqgrJtRJjX5d4vRZNURNFmMGaT6NGRrbFgWsGTgtDfMAouF3V4sYGQGj6B';
      const bip49Ypub =
          'ypub6XcubJFujNWud4hRW4oVs1P7kVUcPPYfw51p2rpM3FZfi77ATR9wQ7Cu9yxtFsKHFNTvLbd2MxS4CLtC1YXvCqzbYnfDceSGDqUM33t2bAn';
      final bip49Wallet =
          Bip32Accounts.from(bip49Yprv, Slip132.mainnetBip49SingleSig);
      expect(bip49Wallet.extendedPrivateKey, bip49Yprv);
      expect(bip49Wallet.extendedPublicKey, bip49Ypub);

      const bip84Zprv =
          'zprvAdDikkudZ5f4EJkJWyCE1DWJptekiNMWcE2LJXZ7L9LCftRQo6sjQ4JTdFpWE7qMyMiby5qwrXRPP9v59Lf2VX7V8CvBiD48LsZM85Cd4Cf';
      const bip84Zpub =
          'zpub6rD5AGSXPTDMSnpmczjENMT3NvVF7q5MySww6uxitUsBYgkZLeBywrcwUWhW5YkeY2aS7xc45APPgfA6s6wWfG2gnfABq6TDz9zqeMu2JCY';
      final bip84Wallet =
          Bip32Accounts.from(bip84Zprv, Slip132.mainnetBip84SingleSig);
      expect(bip84Wallet.extendedPrivateKey, bip84Zprv);
      expect(bip84Wallet.extendedPublicKey, bip84Zpub);
    });

    test('convenience API from Zoo Mnemonic XPUB', () {
      const bip44Xpub =
          'xpub6CfuVE8s2cAQijg7nqYKFoEu7AqkAfMNNMufV7utCmDjMjQZwM9RtN9PHxvBK4gkLWRyu8Xs6jh4TwRz8EYiFjWb8bxDMynAwyHZFxwzvkZ';
      final bip44Wallet =
          Bip32Accounts.from(bip44Xpub, Slip132.mainnetBip44SingleSig);

      expect(bip44Wallet.extendedPrivateKey, null);
      expect(bip44Wallet.extendedPublicKey, bip44Xpub);

      const bip49Ypub =
          'ypub6XcubJFujNWud4hRW4oVs1P7kVUcPPYfw51p2rpM3FZfi77ATR9wQ7Cu9yxtFsKHFNTvLbd2MxS4CLtC1YXvCqzbYnfDceSGDqUM33t2bAn';
      final bip49Wallet =
          Bip32Accounts.from(bip49Ypub, Slip132.mainnetBip49SingleSig);
      expect(bip49Wallet.extendedPrivateKey, null);
      expect(bip49Wallet.extendedPublicKey, bip49Ypub);

      const bip84Zpub =
          'zpub6rD5AGSXPTDMSnpmczjENMT3NvVF7q5MySww6uxitUsBYgkZLeBywrcwUWhW5YkeY2aS7xc45APPgfA6s6wWfG2gnfABq6TDz9zqeMu2JCY';
      final bip84Wallet =
          Bip32Accounts.from(bip84Zpub, Slip132.mainnetBip84SingleSig);
      expect(bip84Wallet.extendedPrivateKey, null);
      expect(bip84Wallet.extendedPublicKey, bip84Zpub);
    });
  });
}
