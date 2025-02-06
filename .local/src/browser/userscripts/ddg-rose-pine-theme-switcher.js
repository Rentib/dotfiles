// ==UserScript==
// @name        DDG RosePine Theme Switcher
// @namespace   Violentmonkey Scripts
// @match       https://duckduckgo.com/*
// @grant       none
// @version     1.0
// @author      Rentib
// @description 10/29/2024, 8:22:18 AM
// ==/UserScript==

(function() {
    'use strict'

    const dark_theme = [
        '1=-1', 'at=-1', 'ao=-1', 'aq=-1', 'ak=-1', 'ax=-1', 'av=1', 'ap=-1', 'au=-1', 'ay=b', 'ae=-1', '18=1',
        '7=191724', 'j=191724', '9=9ccfd8', 'x=3e8fb0', 'aa=c4a7e7', '8=e0def4', '21=191724',
    ];

    const light_theme = [
        '1=-1', 'at=-1', 'ao=-1', 'aq=-1', 'ak=-1', 'ax=-1', 'av=1', 'ap=-1', 'au=-1', 'ay=b', 'ae=-1', '18=1',
        '7=faf4ed', 'j=faf4ed', '9=d7827e', 'x=286983', 'aa=907aa9', '8=1f1d2e', '21=faf4ed',
    ];

    const setTheme = (theme) => {
        for (const item of theme) {
            document.cookie = `${item}; max-age=126144000; samesite=lax; secure`;
        }
    };

    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
        setTheme(dark_theme);
    } else {
        setTheme(light_theme);
    }

    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
        if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
            setTheme(dark_theme);
        } else {
            setTheme(light_theme);
        }
        location.reload()
    });
})()
