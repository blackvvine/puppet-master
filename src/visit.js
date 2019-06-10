
const puppeteer = require('puppeteer');

async function visit() {
    puppeteer.launch().then(async browser => {
      const page = await browser.newPage();
      await page.goto('http://i.eeman.me:8000');
      await browser.close();
    });
}

async function main() {
    await visit()
}

main()

