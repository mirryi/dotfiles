// ==UserScript==
// @name Open-Source Alternative Redirector
// @namespace -
// @version 0.8
// @description Redirects you from proprietary web-services to ethical alternatives(front-end).
// @author NotYou
// @include *youtube.com/*
// @include *reddit.com/*
// @include *twitter.com/*
// @include *instagram.com/*
// @include *medium.com/*
// @include *i.imgur.com/*
// @run-at document-start
// @license GPL-3.0-or-later
// @icon https://icons.iconarchive.com/icons/itweek/knob-toolbar/32/Knob-Shuffle-Off-icon.png
// @grant none
// ==/UserScript==

const url = new URL(window.location.href);

// INSTANCES //
const invidious = "yewtu.be",
  teddit = "teddit.net",
  nitter = "nitter.net",
  bibliogram = "bibliogram.org",
  scribe = "scribe.rip",
  rimgo = "rimgo.bcow.xyz";

// YouTube | Invidious //
// if (window.location.host.indexOf("youtube.com") != -1) {
  // window.location.replace(
    // "https://" + invidious + window.location.pathname + window.location.search
  // );
// }

// Reddit | Teddit //
if (window.location.host.indexOf("reddit.com") != -1) {
  window.location.replace(
    "https://" + teddit + window.location.pathname + window.location.search
  );
}

// Twitter | Nitter //
if (window.location.host.indexOf("twitter.com") != -1) {
  window.location.replace(
    "https://" + nitter + window.location.pathname + window.location.search
  );
}

// Instagram | Bibliogram //
if (window.location.host.indexOf("instagram.com") != -1) {
  if (window.location.pathname === "/accounts/login/") {
    let path1 = window.location.search.split("?next=").at(1);
    let path = "/u" + path1;
    window.location.replace("https://" + bibliogram + path);
  } else {
    window.location.replace(
      "https://" +
        bibliogram +
        window.location.pathname +
        window.location.search
    );
  }
}

// Medium | Scribe //
if (window.location.host.indexOf("medium.com") != -1) {
  window.location.replace(
    "https://" + scribe + window.location.pathname + window.location.search
  );
}

// i.Imgur | Rimgo //
if (window.location.host.indexOf("i.imgur.com") != -1) {
  window.location.replace(
    "https://" + rimgo + window.location.pathname + window.location.search
  );
}
