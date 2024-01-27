import 'package:photopulse/common/presentation/image_assets.dart';

enum SubscriptionPackage {
  free,
  pro,
  gold;

  String get iconPath {
    switch (this) {
      case free:
        return ImageAssets.freeSub;
      case pro:
        return ImageAssets.proSub;
      case gold:
        return ImageAssets.gold;
    }
  }

  int get uploadSizeLimit {
    switch (this) {
      case free:
        return 3;
      case pro:
        return 10;
      case gold:
        return 15;
    }
  }

  int get dailyUploadLimit {
    switch (this) {
      case free:
        return 1;
      case pro:
        return 5;
      case gold:
        return 10;
    }
  }

  double get maxSpend {
    switch (this) {
      case free:
        return 0;
      case pro:
        return 100;
      case gold:
        return 500;
    }
  }
}
