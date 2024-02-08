import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:photopulse/common/constants/duration_constants.dart';
// import 'package:photopulse/common/domain/router/navigation_extensions.dart';
// import 'package:photopulse/common/domain/router/pages.dart';
// import 'package:photopulse/common/presentation/app_sizes.dart';
// import 'package:photopulse/common/presentation/photo_pulse_toast.dart';

import 'package:photopulse/features/auth/domain/entities/github_auth_parameters.dart';
// import 'package:photopulse/features/auth/domain/notifiers/github_auth_notifier.dart';
// import 'package:q_architecture/base_state_notifier.dart';
import 'package:webview_flutter/webview_flutter.dart';

// class GitHubLoginPage extends ConsumerStatefulWidget {
//   const GitHubLoginPage({
//     super.key,
//   });

//   @override
//   ConsumerState<GitHubLoginPage> createState() => _GitHubLoginPageState();
// }

// class _GitHubLoginPageState extends ConsumerState<GitHubLoginPage> {
//   bool shouldShowLoading = false;

//   late InAppWebViewController webViewController;

//   @override
//   Widget build(BuildContext context) {
//     ref.listen<BaseState<void>>(
//       githubAuthNotifierProvider,
//       (_, next) {
//         return switch (next) {
//           BaseData() => ref.pushReplacementNamed(Pages.verifyEmail),
//           BaseError(failure: final failure) => {
//               ref.pop(),
//               PhotoPulseToast(
//                 message: failure.title,
//               ).show(context),
//             },
//           _ => Object(),
//         };
//       },
//     );
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: AppSizes.xLargeSpacing),
//         child: Stack(
//           children: [
//             WebViewWidget(
//               controller: WebViewController()
//                 ..setJavaScriptMode(
//                   JavaScriptMode.unrestricted,
//                 )
//                 ..loadRequest(
//                   Uri.parse(githubAuthParameters.combinedUrl()),
//                 ),
//             ),
//             // InAppWebView(
//             //   onWebViewCreated: (webViewController) {
//             //     onWebViewCreated(webViewController);
//             //   },
//             //   initialOptions: InAppWebViewGroupOptions(
//             //     crossPlatform: InAppWebViewOptions(
//             //       useShouldOverrideUrlLoading: true,
//             //       cacheEnabled: false,
//             //       clearCache: true,
//             //       transparentBackground: true,
//             //     ),
//             //   ),
//             //   onProgressChanged: (_, progress) {
//             //     onProgressChanged(progress);
//             //   },
//             //   shouldOverrideUrlLoading: (_, navigationAction) => ref
//             //       .read(githubAuthNotifierProvider.notifier)
//             //       .handleCodeResponse(navigationAction),
//             // ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: AppSizes.bodyPaddingVertical,
//                   horizontal: AppSizes.bodyPaddingHorizontal,
//                 ),
//                 child: GestureDetector(
//                   child: const Icon(
//                     Icons.arrow_back_rounded,
//                     color: Colors.primaryDark,
//                   ),
//                   onTap: () => ref.pop(),
//                 ),
//               ),
//             ),
//             AnimatedOpacity(
//               opacity: shouldShowLoading ? 1 : 0,
//               duration: DurationConstants.shortAnimationDuration,
//               child: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void onWebViewCreated(InAppWebViewController controller) {
//     webViewController = controller;
//     webViewController.loadUrl(
//       urlRequest: URLRequest(
//         url: Uri.parse(githubAuthParameters.combinedUrl()),
//       ),
//     );
//   }

//   void onProgressChanged(int progress) {
//     setState(() {
//       shouldShowLoading = progress != 100;
//     });
//   }
// }

class GitHubSignInPage extends StatelessWidget {
  const GitHubSignInPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (url.contains('error=')) {
              Navigator.of(context).pop(
                Exception(Uri.parse(url).queryParameters['error']),
              );
            } else if (url.startsWith(githubAuthParameters.redirectUrl)) {
              Navigator.of(context).pop(url
                  .replaceFirst('${githubAuthParameters.redirectUrl}?code=', '')
                  .trim());
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(githubAuthParameters.combinedUrl()));

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
