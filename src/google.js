const puppeteer = require('puppeteer');
const fs = require('fs');
const util = require('util');

const readFile = util.promisify(fs.readFile);


async function getRandomString() {

    const dict = await readFile('data/google-10000-english.txt', 'utf-8');
    const words = dict.split('\n');

    let len = 1;
    let res = [];

    while (Math.random() > 0.2) len++;
    
    for (let i=0; i<len; i++) {
        let w = words[Math.floor(Math.random() * words.length)];
        res.push(w);
    }

    return res.join(' ');

}


async function google() {


    const browser = await puppeteer.launch({
        headless: true,
        slowMo: 5 
    });

    const page = await browser.newPage();

    await page.goto('https://google.com');

    await page.type("input[name=q]", await getRandomString());

    await page.waitForSelector("input[value='Google Search']");
    await page.keyboard.press('Enter');

    await page.waitForSelector('#main #search');

    // await page.screenshot({ path: 'out/scr.png' });

    browser.close();
}


async function run() {
    await google();
}

run();


