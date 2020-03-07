// ==UserScript==
// @name         Steam's Lowest Price
// @description  Show lowest historical prices on Steam via SteamDB
// @version      0.4
// @author       mica
// @namespace    greasyfork.org/users/12559
// @include      *://store.steampowered.com/app/*
// @require      https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js
// @grant        GM_xmlhttpRequest
// ==/UserScript==

(function() {
    if ($('.game_purchase_price:first').text().trim().toLowerCase() != 'free to play') {
        var steamdb = 'https://steamdb.info/app/'+$('link[rel=canonical]').attr('href').match('[0-9]+');
        GM_xmlhttpRequest({
            method: 'GET',
            url: steamdb,
            onload: function(response) {
                var price = $(response.responseText).find('#js-price-history').siblings().last();
                $('<div>').addClass('game_purchase_action_bg').append(
                    $('<div>').addClass('btn_addtocart btn_packageinfo').append(
                        $('<a>').addClass('btnv6_blue_blue_innerfade btn_medium')
                            .attr('href', steamdb)
                            .css({
                                'text-align': 'center',
                                'font-size': '140%',
                                'line-height': '50%',
                                'height': '32px',
                                'padding': '0 3px'
                            })
                            .html(
                                '<p style="font-size: 60%; padding-top: 2px;">Lowest price: '+price.attr('title')+'</p>'+
                                price.text()
                            )
                    )
                ).prependTo('.game_area_purchase_game_wrapper:first .game_purchase_action');
            }
        });
    }
})();
