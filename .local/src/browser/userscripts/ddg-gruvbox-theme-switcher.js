// ==UserScript==
// @name        DDG Gruvbox Theme Switcher
// @namespace   Violentmonkey Scripts
// @match       https://duckduckgo.com/*
// @grant       none
// @version     1.0
// @author      Rentib
// @description 10/29/2024, 8:22:18 AM
// ==/UserScript==

(function() {
    'use strict'

    const light_cookie = '7=fbf1c7; j=fbf1c7; 9=d65d0e; aa=d79921; 8=282828; x=98971a; 21=f2e5bc;';
    const dark_cookie = '7=282828; j=282828; 9=fe8019; aa=f9bc2e; 8=fbf1c7; x=b7ba25; 21=3b3735;';

    const cookieToJSON = (cookieRaw) => {
        const cookieJson = {};
        const items = cookieRaw.split(/[ ,]+/);

        items.forEach((item) => {
            const parts = item.split('=');
            cookieJson[parts[0]] = parts[1];
        });

        return cookieJson;
    };

    // Iterates over JSON, and adds to browser cookie store
    const setCookies = (cookieJson) => {
        Object.keys(cookieJson).forEach((key) => {
            document.cookie = `${key}=${cookieJson[key]}`;
        });
    };

    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
        setCookies(cookieToJSON(dark_cookie));
    } else {
        setCookies(cookieToJSON(light_cookie));
    }

    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
        if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
            setCookies(cookieToJSON(dark_cookie));
        } else {
            setCookies(cookieToJSON(light_cookie));
        }
        location.reload()
    });
})()
