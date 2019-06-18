const puppeteer = require("puppeteer");
const fs = require("fs");
const util = require("util");
const speedline = require("speedline");

const readFile = util.promisify(fs.readFile);


async function getRandomString() {

    const dict = await readFile("data/google-10000-english.txt", "utf-8");
    const words = dict.split("\n");

    let len = 1;
    let res = [];

    while (Math.random() > 0.2) len++;
    
    for (let i=0; i<len; i++) {
        let w = words[Math.floor(Math.random() * words.length)];
        res.push(w);
    }

    return res.join(" ");

}

async function mainScenario(page) {

    console.log("Running main scenario");

    await page.goto("https://google.com");

    await page.type("input[name=q]", await getRandomString());

    await page.waitForSelector("input[value='Google Search']");
    await page.keyboard.press("Enter");

    await page.waitForSelector("#main #search");
    // await page.screenshot({ path: "out/scr.png" });

}

async function google() {

    const traceFile = "trace/trace.json";

    const browser = await puppeteer.launch({
        headless: true,
        slowMo: 5,
        args: ["--disable-dev-shm-usage", '--no-sandbox']
    });

    try {

        const page = await browser.newPage();

        // Start tracing
        await page.tracing.start({
            path: traceFile,
            screenshots: true
        });

        // Run simulation scenario
        await mainScenario(page);

        // Stop tracing
        await page.tracing.stop();

    } catch (e) {
        console.error("Error in running the scenario");
        console.error(e);
        process.exit(1)
    } finally {
        browser.close();
    }

}


async function run() {
    await google();
}

run();


