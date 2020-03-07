/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./src/collider.js
class Collider {
    constructor(x, y, w, h) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
}
// CONCATENATED MODULE: ./src/generate.js


class generate_Platform {
  constructor(el, x, y, width, height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.el = el;
    this.collider = new Collider(x, y, width, height);
  }
}

function textNodeRect(textNode) {
  let range = document.createRange();
  range.selectNodeContents(textNode);
  let rects = range.getClientRects();
  if (rects.length > 0) {
    return rects;
  }
  return null;
}

function textNodesUnder(el) {
  let walker = document.createTreeWalker(el, NodeFilter.SHOW_TEXT, null, false);

  let node;
  let textNodes = [];

  while ((node = walker.nextNode())) {
    if (
      node != null &&
      node.nodeName.toLowerCase() != "div" &&
      node.nodeType === 3
    ) {
      textNodes.push(node);
    }
  }
  return textNodes;
}

function calculatePlatforms(el, w, h, offset) {
  let nodes = textNodesUnder(el);
  let platforms = [];
  for (let i = 0; i < nodes.length; i++) {
    let rects = textNodeRect(nodes[i]);
    if (rects === null) {
      continue;
    }
    for (let j = 0; j < rects.length; j++) {
      let rect = rects[j];

      let plat = new generate_Platform(
        nodes[i],
        rect.left,
        rect.top + offset,
        rect.width,
        rect.height
      );
      platforms.push(plat);
    }
  }

  let ground = new generate_Platform(null, 0, h, w, 10);
  platforms.push(ground);

  return platforms;
}

// CONCATENATED MODULE: ./src/playerInput.js


let up = false;
let down = false;
let left = false;
let right = false;
let started = false;
let isLooping = true;
let isScrollLocked = false;

function setupKeyListener() {
  document.addEventListener("keydown", function(event) {
    if (event.key === "\\") {
      if (!started) {
        start();
        started = true;
        isLooping = true;
        isScrollLocked = true;
      } else if (isLooping) {
        pause();
      } else {
        unhide();
        isLooping = true;
        isScrollLocked = true;
      }
    }

    if (event.key === " " || event.key === "ArrowUp" || event.key === "w") {
      up = true;
    } else if (event.key === "s" || event.key === "ArrowDown") {
      down = true;
    } else if (event.key === "a" || event.key === "ArrowLeft") {
      left = true;
    } else if (event.key === "d" || event.key === "ArrowRight") {
      right = true;
    }
  });
  document.addEventListener("keyup", function(event) {
    if (event.key === " " || event.key === "ArrowUp" || event.key === "w") {
      up = false;
    } else if (event.key === "s" || event.key === "ArrowDown") {
      down = false;
    } else if (event.key === "a" || event.key === "ArrowLeft") {
      left = false;
    } else if (event.key === "d" || event.key === "ArrowRight") {
      right = false;
    }
  });
}

function updatePlayer() {
  player.move(up, down, left, right);
}

function pause() {
  hide();
  isLooping = false;
  isScrollLocked = false;
}
// CONCATENATED MODULE: ./src/side_enum.js
const sides = {
    LEFT: 0,
    RIGHT: 1,
    UP: 2,
    DOWN: 3,
    NONE: 4
}
// CONCATENATED MODULE: ./src/collisions.js



function collisionDir(moveColliderPast, moveColliderFuture, staticCollider) {
  if (isColliding(moveColliderFuture, staticCollider)) {
    if (moveColliderPast.y + moveColliderPast.h <= staticCollider.y) {
      return sides.DOWN;
    } else if (moveColliderPast.x + moveColliderPast.w <= staticCollider.x) {
      return sides.RIGHT;
    } else if (moveColliderPast.x >= staticCollider.x + staticCollider.w) {
      return sides.LEFT;
    } else {
      return sides.UP;
    }
  } else {
    return sides.NONE;
  }
}

function isColliding(moveColliderFuture, staticCollider) {
  if (
    moveColliderFuture.x > staticCollider.x + staticCollider.w ||
    moveColliderFuture.x + moveColliderFuture.w < staticCollider.x ||
    moveColliderFuture.y > staticCollider.y + staticCollider.h ||
    moveColliderFuture.y + moveColliderFuture.h < staticCollider.y
  ) {
    return false;
  } else {
    return true;
  }
}

function collisionCorrection(side, og, next, st){
    if (side === sides.DOWN){
        return new Collider(next.x, st.y - og.h, og.w, og.h);
    }
    else if (side === sides.UP){
        return new Collider(next.x, st.y + st.h, og.w, og.h);
    }
    else if (side === sides.LEFT){
        return new Collider(st.x + st.w, next.y, og.w, og.h);
    }
    else if (side === sides.RIGHT){
        return new Collider(st.x-og.w, next.y, og.w, og.h);
    }
    else return next;
}

// CONCATENATED MODULE: ./src/entity.js





let entities = [];

class entity_Entity {
  constructor(x, y, w, h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.collision = sides.NONE;
    this.collider = new Collider(this.x, this.y, this.w, this.h);

    this.vx = 0;
    this.vy = 0;

    entities.push(this);
  }

  update() {
    this.vy += g;
    
    this.getCollisions();

    this.x = this.collider.x;
    this.y = this.collider.y;
    if (this.collision === sides.DOWN) this.vy = 0;
    // if (this.collision === sides.UP) this.vy = -this.vy;
    // if (this.collision === sides.LEFT || this.collision === sides.RIGHT)
    //   this.vx = 0;

    return;
  }

  getCollisions() {
    let nextCollider = new Collider(
      this.x + this.vx,
      this.y + this.vy,
      this.w,
      this.h
    );
    for (let i = 0; i < platforms.length; i++) {
        let platform = platforms[i];
        let collision = collisionDir(
            this.collider,
            nextCollider,
            platform.collider
        );
        
        if (collision === sides.DOWN) {
            this.collision = collision;
            this.collider = collisionCorrection(
                this.collision,
                this.collider,
                nextCollider,
                platform.collider
            );
            return;
        }
    }

    this.collision = sides.NONE;
    this.collider = nextCollider;
    return;
  }
}

// CONCATENATED MODULE: ./src/player.js




class player_Player extends entity_Entity {
  constructor(x, y, w, h) {
    super(x, y, w, h);

    this.targetVel = 0;
    this.maxVel = 1.5;
    this.velUpdateCoef = 0.4;

    this.vertKE = 0;
    this.vertKERate = 0.1;
  }

  move(up, down, left, right) {
    if (left && !right) this.targetVel = -this.maxVel;
    else if (right && !left) this.targetVel = this.maxVel;
    else this.targetVel = 0;
    this.vx =
      this.velUpdateCoef * this.targetVel + (1 - this.velUpdateCoef) * this.vx;

    if (up) this.vertKE += this.vertKERate;
    else if (this.vertKE > 0) {
      this.vy = -Math.sqrt(this.vertKE);
      this.vertKE = 0;
    }
  }

  update() {
    super.update();

    if (this.collision !== sides.DOWN) this.vertKE = 0;

    main_ctx.fillStyle = "rgb(0, 0, 255)";
    main_ctx.fillRect(this.x, this.y, this.w, this.h);
  }
}

// CONCATENATED MODULE: ./src/projectile.js



let projectiles = [];

class projectile_Projectile {
    constructor(x, y, w, h, vx, vy) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.vx = vx;
        this.vy = vy;
        this.collider = new Collider(this.x, this.y, this.w, this.h);

        projectiles.push(this);
    }

    update() {
        this.x += this.vx;
        this.y += this.vy;
        this.collider.x += this.vx;
        this.collider.y += this.vy;

        main_ctx.fillStyle = "rgb(255, 0, 0)";
        main_ctx.fillRect(this.x, this.y, this.w, this.h);
    }
}

function projectileGen(w, h) {
    if (Math.random() >= 0.95) {
        let y = 30 + Math.random() * (h - 60);
        let proj = new projectile_Projectile(w + 30, y, 10, 10, -1, 0);
    }
}
// CONCATENATED MODULE: ./src/monsters.js






class monsters_Follower{
    constructor(x,y,w,h,speed){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.speed = speed;

        this.collider = new Collider(x,y,w,h);

        this.vx = 0;
        this.vy = 0;

        projectiles.push(this);
    }

    update(){

        if (this.x > player.x){
            this.collider.x -= this.speed;
        }
        else if (this.x < player.x){
            this.collider.x += this.speed
        }

        if (this.y > player.y){
            this.collider.y -= this.speed;
        }
        else if (this.y < player.y){
            this.collider.y += this.speed;
        }

        main_ctx.fillStyle = "rgb(255, 0, 255)";
        main_ctx.fillRect(this.x, this.y, this.w, this.h);

        this.x = this.collider.x;
        this.y = this.collider.y;

    }
}
// CONCATENATED MODULE: ./src/main.js
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "platforms", function() { return platforms; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "g", function() { return g; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "player", function() { return player; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "canvas", function() { return canvas; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ctx", function() { return main_ctx; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "hide", function() { return hide; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "unhide", function() { return unhide; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "restart", function() { return restart; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "stop", function() { return stop; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "start", function() { return start; });
// ==UserScript==
// @name         New Userscript
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        *://*/*
// @grant        none
// @noframes
// @require      https://unpkg.com/bottleneck@2.13.0/es5.js
// @require      https://cdnjs.cloudflare.com/ajax/libs/canvasjs/1.7.0/canvasjs.min.js
// ==/UserScript==










let platforms = [];
const g = 0.025;
let player;
let canvas;
let main_ctx;
let docW;
let docH;
let offset;
let finishY;
let interval;
let stopped = false;

function documentWidth() {
  return Math.max(
    document.documentElement["clientWidth"],
    document.body["scrollWidth"],
    document.documentElement["scrollWidth"],
    document.body["offsetWidth"],
    document.documentElement["offsetWidth"]
  );
}

function documentHeight() {
  return Math.max(
    document.body.scrollHeight,
    document.body.offsetHeight,
    document.documentElement.clientHeight,
    document.documentElement.scrollHeight,
    document.documentElement.offsetHeight
  );
}

function documentScroll() {
  return document.documentElement.scrollTop || document.body.scrollTop;
}

function createCanvas() {
  const canvas = document.createElement("canvas");
  canvas.width = documentWidth();
  canvas.height = documentHeight();
  canvas.style.position = "absolute";

  canvas.style.top = 0 + "px";
  canvas.style.left = 0 + "px";
  canvas.style.zIndex = 99999;

  return canvas;
}

function loop() {
  if (isLooping) {
    main_ctx.clearRect(0, 0, canvas.width, canvas.height);
    main_ctx.fillStyle = "rgba(31, 153, 2, 0.3)";
    main_ctx.fillRect(0, 0, documentWidth(), finishY);

    updatePlayer();

    if (isScrollLocked) {
      window.scrollTo(player.x, player.y - 300);
    }

    projectileGen(docW, docH);

    for (let i = 0; i < entities.length; i++) entities[i].update();

    for (let i = 0; i < projectiles.length; i++) {
      projectiles[i].update();
      if (isColliding(player.collider, projectiles[i].collider)) {
        restart();
      }
    }

    if (player.y < finishY) {
      stop();
    }

    // for (let i = 0; i < platforms.length; i++) {
    //   let p = platforms[i];
    //   ctx.strokeStyle = "rgb(0, 0, 0)";
    //   ctx.strokeRect(p.x, p.y + offset, p.width, p.height);
    // }
    //
  }
}

function hide() {
  canvas.style.display = "none";
}

function unhide() {
  canvas.style.display = "block";
}

function restart() {
  const ctx = canvas.getContext("2d");
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  player.x = (docW - 25) / 2;
  player.y = docH - 25;
  player.vx = 0;
  player.vy = 0;
  projectiles.length = 0;
  for (let i = 0; i < 3; i++) {
    new monsters_Follower(Math.random() * docW, Math.random() * docH, 15, 15, 0.5);
  }
}

function stop() {
  restart();
  pause();
}

function start() {
  console.log(documentScroll());
  docW = documentWidth();
  docH = documentHeight();
  offset = documentScroll();
  platforms = calculatePlatforms(document.body, docW, docH, offset);

  canvas = createCanvas();
  document.body.appendChild(canvas);
  main_ctx = canvas.getContext("2d");

  finishY = Math.min(platforms[0].y + 30, 100);

  player = new player_Player((docW - 25) / 2, docH - 25, 25, 25);

  for (let i = 0; i < 3; i++) {
    new monsters_Follower(Math.random() * docW, Math.random() * docH, 15, 15, 0.5);
  }

  interval = setInterval(loop, 10);
}

(function() {
  // var limiter = new Bottleneck({
  // reservoir: 10,
  // reservoirRefreshAmount: 100,
  // reservoirRefreshInterval: 5 * 1000
  // });

  setupKeyListener();
})();


/***/ })
/******/ ]);