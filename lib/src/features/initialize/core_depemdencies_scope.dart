import 'package:bibinto/src/common/util/core_dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class CoreDependenciesScope extends SingleChildStatelessWidget {
  // [CoreDependencies] содержит в себе перманентные зависимости, нет смысла
  // подписываться на обновления.
  static CoreDependencies coreDependenciesOf(BuildContext context) =>
      Provider.of(context, listen: false);

  const CoreDependenciesScope({
    required CoreDependencies coreDependencies,
    required super.child,
    super.key,
  }) : _coreDependencies = coreDependencies;

  final CoreDependencies _coreDependencies;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => Provider.value(
        value: _coreDependencies,
        child: child,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<CoreDependencies>(
        'coreDependencies',
        _coreDependencies,
      ),
    );
  }
}
