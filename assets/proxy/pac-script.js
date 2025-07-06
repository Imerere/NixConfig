function FindProxyForURL(url, host) {
  var proxy = "PROXY 127.0.0.1:8889";

  if (/^https:\/\/.+\.nvidiagrid.net/.test(url)) {
    // Should only proxy /v2/session, but the URL path is removed by Chrome
    return proxy;
  }

  return "DIRECT";
}