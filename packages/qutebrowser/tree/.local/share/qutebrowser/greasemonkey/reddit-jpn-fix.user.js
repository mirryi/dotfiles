// ==UserScript==
// @name          Reddit JPN Fix
// @namespace     https://github.com/mirryi
// @version       1.01
// @description   Fixes some Japanese translation things.
// @author        mirryi
// @match         *://*.reddit.com/*
// @grant         none
// @icon          https://www.redditstatic.com/desktop2x/img/favicon/apple-icon-76x76.png
// ==/UserScript==

(function () {
  function select(query) {
    /** @type {HTMLElement} */
    const el = document.querySelector(query);
    return el;
  }

  function selectAll(query) {
    /** @type {Array<HTMLElement>} */
    const arr = Array.from(document.querySelectorAll(query));
    return arr;
  }

  const dateEl = select(
    "body > div.side > div:nth-child(2) > div > div.date > time"
  );
  if (dateEl && dateEl.dateTime) {
    const date = Date.parse(dateEl.dateTime);
    dateEl.innerText = new Intl.DateTimeFormat("ja-JP", { era: "long" }).format(
      date
    );
  }

  const score = select("body > div.side > div:nth-child(2) > div > div.score")
    ?.childNodes[3];
  if (score) {
    score.nodeValue = score?.nodeValue?.replace("upvote", "アップして");
  }

  const shortlink = select(
    "body > div.side > div:nth-child(2) > div > div.shortlink"
  );
  if (shortlink && shortlink.childNodes && shortlink.childNodes[0]) {
    shortlink.childNodes[0].nodeValue = "ショートリンク: ";
  }

  const changes = [
    [
      "#sr-header-area > div > div.sr-list > ul:nth-child(1) > li:nth-child(5) > a",
      "友人",
      true,
    ],
    [
      "#sr-header-area > div > div.sr-list > ul:nth-child(1) > li:nth-child(2) > a",
      "盛ん",
      true,
    ],
    [
      "#sr-header-area > div > div.sr-list > ul:nth-child(1) > li:nth-child(6) > a",
      "ユーザー",
      true,
    ],
    [("#header-bottom-left > ul > li:nth-child(8) > a", "ウィキ", true)],
    [".gold-give-gold", "賞をあげる", false],
    [".post-crosspost-button", "クロスポスト", false],
    [".embed-comment", "エンベッド", false],
  ];

  for (const [s, t, a] of changes) {
    let arr;
    if (a) {
      const el = select(s);
      arr = [el];
    } else {
      arr = selectAll(s);
    }

    for (const el of arr) {
      if (el) {
        el.innerText = t;
      }
    }
  }
})();
