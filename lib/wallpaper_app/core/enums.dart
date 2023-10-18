import 'package:flutter/cupertino.dart';

import 'constants/app_assets.dart';

enum ServiceType {
  free_delivery("Free Delivery"),
  cash_on_delivery("Cash on Delivery");

  final String name;

  const ServiceType(this.name);
}

enum SortingOrder {
  ascending('ascending'),
  descending('descending');

  const SortingOrder(this.url);

  final String url;
}

enum LoginType { email, phone }

enum ProductListType {
  today('Discounted', 'today'),
  all('Recently Added', 'all'),
  pickup('UnderS\$25', 'assigned'),
  completed('4 Stars & Up', 'completed'),
  onDelivery('Free Shipping', 'on_delivery'),
  ;

  const ProductListType(this.name, this.url);

  final String url;
  final String name;
}

enum ProductSortingType {
  none('None', 'none'),
  relevance('relevance', 'name'),
  rating('Date', 'scheduled_date'),
  priceHigh('Status', 'status'),
  priceLow('Status', 'status'),
  ;

  const ProductSortingType(this.name, this.url);

  final String url;
  final String name;
}

enum EntityType {
  choice(
      itemSeparation: 5.0,
      maxCrossAxisExtent: 180.0,
      width: 110.0,
      displayName: 'Choice',
      displayImage: AppAssets.mastercard_card,
      emptyMessage: 'No data to show');

  const EntityType(
      {required this.itemSeparation,
      required this.maxCrossAxisExtent,
      required this.width,
      this.emptyTitle,
      this.emptyButtonText,
      this.emptyMessage = 'No data to show',
      this.displayImage,
      required this.displayName});

  // final double height;
  final double width;
  final String? displayImage;
  final String? emptyTitle;
  final String? emptyButtonText;
  final String emptyMessage;
  final double itemSeparation;
  final double maxCrossAxisExtent;

  final String displayName;
}

enum JustForYouEnumsState {
  popular("Popular", ""),

  // This state is needed only for listing
  // ignore: constant_identifier_names
  discounted("Discounted", "Your Invoice is not Paid for "),

  // ignore: constant_identifier_names
  recently_added("Recently Added", "Your Invoice Payment is in Process"),
  highly_rated("Highly Rated", "Your Invoice has been Paid for");

  const JustForYouEnumsState(this.displayName, this.message);

  final String displayName;
  final String message;
}

enum OperationType { add, edit }

enum LoadingState { loading, loaded, error }

enum ImageType { user, product }

extension ImageTypeExtension on ImageType {
  String get model {
    switch (this) {
      case ImageType.user:
        return 'res.partner';
      case ImageType.product:
        return 'product.product';
    }
  }
}

enum PopupType { menu, dialog, modalBottomSheet }

enum AddressType {
  delivery("Shipping Address"),
  billing("Billing Address");

  const AddressType(this.title);

  final String title;
}

enum Gender {
  male("Male"),
  female("Female"),
  other("Other");

  const Gender(this.displayName);

  final String displayName;

  @override
  String toString() => displayName;
}

enum CreditCardType {
  americanExpress,
  dinersClub,
  discover,
  eftpos,
  jcb,
  mastercard,
  unionPay,
  visa,
  unknown,
}

extension CreditCardTypeExtension on CreditCardType {
  String get displayName {
    switch (this) {
      case CreditCardType.americanExpress:
        return 'American Express';
      case CreditCardType.dinersClub:
        return 'Diners Club';
      case CreditCardType.discover:
        return 'Discover';
      case CreditCardType.eftpos:
        return 'Eftpos Australia';
      case CreditCardType.jcb:
        return 'JCB';
      case CreditCardType.mastercard:
        return 'MasterCard';
      case CreditCardType.unionPay:
        return 'UnionPay';
      case CreditCardType.visa:
        return 'Visa';
      default:
        return 'Unknown';
    }
  }

  String get imageAsset {
    switch (this) {
      case CreditCardType.americanExpress:
        return AppAssets.american_express_card;
      case CreditCardType.dinersClub:
        return AppAssets.diners_club_card;
      case CreditCardType.discover:
        return AppAssets.discover_card;
      case CreditCardType.eftpos:
        return AppAssets.eftpos_card;
      case CreditCardType.jcb:
        return AppAssets.jcb_card;
      case CreditCardType.mastercard:
        return AppAssets.mastercard_card;
      case CreditCardType.unionPay:
        return AppAssets.unionpay_card;
      case CreditCardType.visa:
        return AppAssets.visa_card;
      default:
        return AppAssets.unknown_card;
    }
  }
}

CreditCardType convertDisplayNameToEnum(String displayName) {
  List<String> words = displayName.split(' ');
  String formattedName = words.first.toLowerCase() +
      words
          .sublist(1)
          .map((word) =>
              word.substring(0, 1).toUpperCase() +
              word.substring(1).toLowerCase())
          .join('');

  return CreditCardType.values.firstWhere(
    (type) => type.toString().split('.').last == formattedName,
    orElse: () => CreditCardType.unknown,
  );
}

enum DiscountType {
  points('Redeem Points'),
  voucher('Select Voucher');

  const DiscountType(this.displayName);

  final String displayName;

  bool get isVoucher => this == DiscountType.voucher;
}
