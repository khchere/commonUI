import 'package:common_ui/common_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {
  final String url;

  const AppWebView({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppWebViewState createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  late final WebViewCookieManager cookieManager = WebViewCookieManager();
  PullToRefreshController? pullToRefreshController;
  InAppWebViewController? webViewController;
  //WebView 위젯을 고유하게 식별하고, WebView 위젯의 상태를 유지하고, WebView 위젯에 대한 정보에 접근하기 위해 사용되는 GlobalKey를 생성하는 코드
  final GlobalKey webViewKey = GlobalKey();

  WebUri? _uri;
  double _progress = 0;
  bool _isShowLoadingIndicator = true;

  @override
  void initState() {
    super.initState();
    // _onClearCookies(context);
    pullToRefreshController = kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Material(
        color: Colors.white,
        child: SafeArea(
          top: true,
          left: false,
          right: false,
          bottom: false,
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(child: _inAppWebView()),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 50.0,
                    ),
                  ],
                ),
                if (_isShowLoadingIndicator) LoadingIndicator.small(),
              ],
            ),
            bottomSheet: _buildBottomSheet(context),
          ),
        ),
      ),
    );
  }

  Widget _inAppWebView() {
    AlertDialog alertDialog;
    return InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(url: _uri),
      initialSettings: settings,
      pullToRefreshController: pullToRefreshController,
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
      onLoadStart: (controller, url) {
        Log.d('onLoadStart: $url');
        if (url == null || url.toString().isEmpty) {
          print("빈 URL 로딩 방지");
          controller.goBack();
          return;
        }
        setState(() {
          _isShowLoadingIndicator = true;
        });
      },
      onLoadStop: (controller, url) {
        pullToRefreshController?.endRefreshing();
        if (_isShowLoadingIndicator) {
          setState(() {
            _isShowLoadingIndicator = false;
          });
        }
      },
      onProgressChanged: (controller, progress) {
        if (progress == 100) {
          pullToRefreshController?.endRefreshing();
        }
        setState(() {
          _progress = progress / 100;
        });
      },
      onPermissionRequest: (controller, request) async {
        return PermissionResponse(
            resources: request.resources,
            action: PermissionResponseAction.GRANT);
      },
      // onUpdateVisitedHistory: (controller, url, androidIsReload) {
      //   Log.d('onUpdateVisitedHistory: $url');
      // },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        Uri? url = navigationAction.request.url;
        Log.d('shouldOverrideUrlLoading: $url');
        if (url != null && url.toString().isNotEmpty) {
          return NavigationActionPolicy.ALLOW;
        }
        return NavigationActionPolicy.CANCEL;
      },
      onReceivedError: (controller, request, error) {
        pullToRefreshController?.endRefreshing();
      },
      onCreateWindow: (controller, createWindowRequest) async {
        Log.d('onCreateWindow: ${createWindowRequest.windowId}');

        // _openNewWebView(context, createWindowRequest.windowId);
        //
        showDialog(
            context: context,
            // barrierDismissible: false,
            // useSafeArea: false,
            builder: (context) {
              // return Dialog(
              //   child: SizedBox(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: MediaQuery.of(context).size.height * 0.9,
              //     child: WebViewPopupScreen(
              //         windowId: createWindowRequest.windowId!),
              //   ),
              // );
              return InAppWebView(
                initialSettings: InAppWebViewSettings(
                  javaScriptEnabled: true,
                ),
                windowId: createWindowRequest.windowId,
                onCloseWindow: (controller) {
                  Navigator.pop(context);
                },
              );
            });
        return true;
      },
      onCloseWindow: (controller) {
        Log.d('onCloseWindow');
        Navigator.pop(context);
      },
    );
  }

  void _openNewWebView(BuildContext context, int url) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: SizedBox(
          // width: MediaQuery.of(context).size.width * 0.9,
          // height: MediaQuery.of(context).size.height * 0.9,
          child: WebViewPopupScreen(windowId: url),
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final theme = context.theme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: _progress < 1.0 ? 4 : 0,
          child: _progress < 1.0
              ? LinearProgressIndicator(
                  value: _progress,
                )
              : Container(),
        ),
        Container(
          height: 50.0 + bottomPadding,
          color: theme.colorScheme.background,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: bottomPadding,
            ),
            child: Stack(
              children: <Widget>[
                const Divider(height: 0.5),
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FutureBuilder<bool>(
                        future: webViewController?.canGoBack() ??
                            Future.value(false),
                        builder: (context, snapshot) {
                          final canGoBack = snapshot.data ?? false;
                          return Opacity(
                            opacity: canGoBack ? 1.0 : 0.3,
                            child: IgnorePointer(
                              ignoring: !canGoBack,
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: canGoBack
                                    ? () {
                                        webViewController?.goBack();
                                      }
                                    : null,
                                child: Container(
                                  color: Colors.transparent,
                                  constraints: const BoxConstraints(
                                    minWidth: 50,
                                    minHeight: 50,
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      FutureBuilder<bool>(
                        future: webViewController?.canGoForward() ??
                            Future.value(false),
                        builder: (context, snapshot) {
                          final canGoForward = snapshot.data ?? false;
                          return Opacity(
                            opacity: canGoForward ? 1.0 : 0.3,
                            child: IgnorePointer(
                              ignoring: !canGoForward,
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: canGoForward
                                    ? () {
                                        webViewController?.goForward();
                                      }
                                    : null,
                                child: Container(
                                  color: Colors.transparent,
                                  constraints: const BoxConstraints(
                                    minWidth: 50,
                                    minHeight: 50,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          color: Colors.transparent,
                          constraints: const BoxConstraints(
                            minWidth: 50,
                            minHeight: 50,
                          ),
                          child: Icon(
                            Icons.refresh,
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                        onTap: () {
                          if (webViewController != null) {
                            webViewController!.reload();
                          }
                        },
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => _launchURL(context),
                        child: Container(
                          color: Colors.transparent,
                          constraints: const BoxConstraints(
                            minWidth: 50,
                            minHeight: 50,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 2.0,
                            ),
                            child: Icon(
                              Icons.open_in_browser,
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black54,
                              size: 19,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          color: Colors.transparent,
                          constraints: const BoxConstraints(
                            minWidth: 50,
                            minHeight: 50,
                          ),
                          child: Icon(
                            Icons.close,
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                        onTap: () => Navigator.maybePop(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _launchURL(BuildContext context) async {
    if (_uri != null && await canLaunchUrl(_uri!)) {
      await launchUrl(
        _uri!,
        mode: LaunchMode.externalApplication,
      );
    } else {
      await MessageDialog('해당 url 은 열 수 없습니다.').show();
    }
  }

  Future<NavigationActionPolicy?> _navigationActionPolicy(
      InAppWebViewController controller,
      NavigationAction navigationAction) async {
    debugPrint(
        'url: ${navigationAction.request.url}, isForMainFrame: ${navigationAction.isForMainFrame}');
    return NavigationActionPolicy.ALLOW;
  }

  Future<void> _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }

  InAppWebViewSettings settings = InAppWebViewSettings(
    // isInspectable: kDebugMode, //디버그 모드에서 웹 인스펙터(DevTools) 활성화
    javaScriptEnabled: true,
    iframeAllowFullscreen: true,
    javaScriptCanOpenWindowsAutomatically: true,
    supportMultipleWindows: true,
    useShouldOverrideUrlLoading: true,

    // iframeAllowFullscreen: true,
    // useOnDownloadStart: true,
    // useOnLoadResource: true,
    // clearCache: true,
    // allowFileAccessFromFileURLs: true,
    // allowUniversalAccessFromFileURLs: true,
  );
}

class WebViewPopupScreen extends StatelessWidget {
  // final String url;
  final int windowId;

  const WebViewPopupScreen({Key? key, required this.windowId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Expanded(
        child: InAppWebView(
          windowId: windowId,
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
          ),
          onLoadStart: (controller, url) {
            if (url == null || url.toString().isEmpty) {
              print("빈 URL 로딩 방지 (새 창)");
              controller.goBack();
            }
          },
          onCloseWindow: (controller) {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
