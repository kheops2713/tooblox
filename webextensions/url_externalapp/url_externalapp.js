function onCreated() {}

browser.menus.create({
  id: "termlink",
  type: "normal",
  title: "(╯°□°）╯︵ ┻━┻",
  contexts: ["link"]
}, onCreated);

browser.menus.onClicked.addListener((info, tab) => {
  switch (info.menuItemId) {
    case "termlink":
    var extapp = browser.runtime.connectNative("url_from_firefox_in_terminal");
    extapp.postMessage (info["linkUrl"]);
    extapp.disconnect()
    break;
  }
});
