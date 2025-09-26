import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    required this.error,
    this.errorTitle = 'Error Happened',
    this.errorTitleStyle = const TextStyle(fontSize: 16),
    this.isLoading = false,
    super.key,
    this.onRetry,
  });

  final String error;
  final VoidCallback? onRetry;
  final bool isLoading;

  final String errorTitle;
  final TextStyle errorTitleStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: EdgeInsets.all(12),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        errorTitle,
                        style: errorTitleStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        error,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (onRetry != null && !isLoading)
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: ElevatedButton(
                            onPressed: () async => onRetry?.call(),
                            child: Text('Retry'),
                          ),
                        )
                      else if (isLoading)
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: const CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
