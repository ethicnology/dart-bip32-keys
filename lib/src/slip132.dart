import 'dart:typed_data';
import 'package:bs58check/bs58check.dart' as bs58check;
import 'package:hex/hex.dart';
import 'bip32_keys_base.dart';
import 'enums.dart';
import 'constants.dart';

/// SLIP-132 extensions for Bip32Keys
extension Slip132Extension on Bip32Keys {
  /// Convert this key to a different SLIP-132 format
  ///
  /// [format] the target format (xpub, ypub, zpub, etc.)
  ///
  /// Returns the converted extended public key or error message
  String toVersion(Slip132 slip132) {
    return switch (isNeutered) {
      true => changeVersionBytes(toBase58(), slip132.network.version.public),
      false => changeVersionBytes(toBase58(), slip132.network.version.private),
    };
  }

  /// Get the SLIP-132 fingerprint for this key
  ///
  /// [format] the target format for version bytes
  ///
  /// Returns the fingerprint as hex string
  String getSlip132PublicFingerprint(Slip132 format) {
    if (isNeutered) {
      return getFingerprint(toBase58(), format);
    } else {
      throw Constants.errorCannotGetFingerprintFromPrivate;
    }
  }

  /// Get the SLIP-132 parent fingerprint for this key
  ///
  /// [format] the target format for version bytes
  ///
  /// Returns the parent fingerprint as hex string
  String getSlip132ParentFingerprint(Slip132 format) {
    if (isNeutered) {
      return getParentFingerprint(toBase58(), format);
    } else {
      throw Constants.errorCannotGetParentFingerprintFromPrivate;
    }
  }
}

/// Change version bytes of an extended public key
///
/// This function takes an extended public key (with any version bytes, it doesn't need to be an xpub)
/// and converts it to an extended public key formatted with the desired version bytes
///
/// [xpub] an extended public key in base58 format. Example: xpub6CpihtY9HVc1jNJWCiXnRbpXm5BgVNKqZMsM4XqpDcQigJr6AHNwaForLZ3kkisDcRoaXSUms6DJNhxFtQGeZfWAQWCZQe1esNetx5Wqe4M
/// [targetFormat] the desired SLIP-132 format
///
/// Returns the converted extended public key or error message
String changeVersionBytes(String keyBase58, int version) {
  try {
    final keyBytes = bs58check.decode(keyBase58);
    final keyBytesWithoutVersion =
        keyBytes.sublist(Constants.versionBytesLength);

    final newVersionBytes = HEX.decode(version.toRadixString(16));
    final newKeyBytes =
        Uint8List.fromList([...newVersionBytes, ...keyBytesWithoutVersion]);
    final newKeyBase58 = bs58check.encode(newKeyBytes);
    return newKeyBase58;
  } catch (err) {
    rethrow;
  }
}

/// Get fingerprint from extended public key
///
/// [xpub] the extended public key
/// [targetFormat] the target format for version bytes
///
/// Returns the fingerprint as hex string
String getFingerprint(String xpub, Slip132 targetFormat) {
  try {
    final convertedXpub =
        changeVersionBytes(xpub, targetFormat.network.version.public);

    final networkType = Bip32Network(
      wif: targetFormat.network.wif,
      version: targetFormat.network.version,
    );

    final bip32Key = Bip32Keys.fromBase58(convertedXpub, network: networkType);
    return HEX.encode(bip32Key.fingerprint);
  } catch (err) {
    rethrow;
  }
}

/// Get parent fingerprint from extended public key
///
/// [xpub] the extended public key
/// [targetFormat] the target format for version bytes
///
/// Returns the parent fingerprint as hex string
String getParentFingerprint(String xpub, Slip132 targetFormat) {
  try {
    final convertedXpub =
        changeVersionBytes(xpub, targetFormat.network.version.public);

    final networkType = Bip32Network(
      wif: targetFormat.network.wif,
      version: targetFormat.network.version,
    );

    final bip32Key = Bip32Keys.fromBase58(convertedXpub, network: networkType);
    return bip32Key.parentFingerprint.toRadixString(16);
  } catch (err) {
    rethrow;
  }
}

/// Get depth from extended public key
///
/// [xpub] the extended public key
/// [targetFormat] the target format for version bytes
///
/// Returns the depth as integer
int getDepth(String xpub, Slip132 targetFormat) {
  try {
    final convertedXpub =
        changeVersionBytes(xpub, targetFormat.network.version.public);

    final networkType = Bip32Network(
      wif: targetFormat.network.wif,
      version: targetFormat.network.version,
    );

    final bip32Key = Bip32Keys.fromBase58(convertedXpub, network: networkType);
    return bip32Key.depth;
  } catch (err) {
    rethrow;
  }
}
