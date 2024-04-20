import 'package:flutter/material.dart';

enum Status { pure, success, loading, fail }

extension StatusExtenions on Status {
  bool get isPure => this == Status.pure;

  bool get isSuccess => this == Status.success;

  bool get isLoading => this == Status.loading;

  bool get isFail => this == Status.fail;

  Widget switchStatus({
    required VoidCallback onPure,
    required Widget Function() onSuccess,
    required Widget Function() onLoading,
    required Widget Function() onFail,
  }) {
    if (this.isPure) {
      onPure.call();
    } else if (this.isSuccess) {
      return onSuccess.call();
    } else if (this.isLoading) {
      return onLoading.call();
    } else if (this.isFail) {
      return onFail.call();
    }
    return SizedBox.shrink();
  }
}
