
const puppeteer = require('puppeteer');

function visit() {
    puppeteer.launch().then(async browser => {
      const page = await browser.newPage();
      await page.goto('http://i.eeman.me:8000');
      await browser.close();
    });
}

setInterval(visit, 1000)

