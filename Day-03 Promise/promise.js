/*<====================== 1.Promise pending , resolve , reject example ======================>*/

const promise = new Promise((resolve, reject) => {
    const num = Math.random() * 100;
    setTimeout(() => {
        if (num < 50) {
            resolve(`Promise Resolved \nResult: ${num}\n`);
        } else {
            reject(`Promise is Rejected \nNumber is too high: ${num}`);
        }
    }, 1000);
});

promise.then(result => {
    console.log(result);
}).catch(error => {
    console.error(error);
});
console.log(promise)

/*<====================== 2.Promise methods ======================>*/

const promiseA = Promise.reject("Rejected Promise");
const promiseB = new Promise((resolve) => setTimeout(() => resolve("Resolved Promise One"), 100));
const promiseC = new Promise((resolve) => setTimeout(() => resolve("Resolved Promise Two"), 500));

// Promise.any()
Promise.any([promiseA, promiseB, promiseC])
    .then((result) => console.log("Result of Promise.any():", result))
    .catch((error) => console.log("Promise.any() Error:", error));

// Promise.race()
Promise.race([promiseB, promiseC])
    .then((result) => console.log("Result of Promise.race():", result))
    .catch((error) => console.log("Promise.race() Error:", error));

// Promise.all()
Promise.all([promiseB, promiseC])
    .then((results) => console.log("Result of Promise.all():", results))
    .catch((error) => console.log("Promise.all() Error:", error));

//Promise.allSettled()
Promise.allSettled([promiseA, promiseB, promiseC])
    .then((results) => console.log("Result of Promise.allSettled():", results))
    .catch((error) => console.log("Promise.allSettled() Error: ", error))


/*<====================== 3.Async-await ======================>*/

const promiseAsync = new Promise((resolve, reject) => {
    setTimeout(() => {
        resolve("Promise resolved successfully");
    }, 6000);
})

async function handlePromise() {
    const data = await promiseAsync;
    console.log(promiseAsync);
    console.log(data);
    console.log("Hello");

}

handlePromise();
console.log("Outside of Handle Function");


/*<====================== 4. Reading Excel File ======================> */

import fs from "fs";
import * as XLSX from "xlsx";

//ReadFile
fs.readFile("data.xlsx", (err, buffer) => {
    if (err) return console.error(err);
    console.log("Data using ReadFile: ",
        XLSX.utils.sheet_to_json(
            XLSX.read(buffer, { type: "buffer" }).Sheets["Sheet1"]
        )
    );
});

console.log("Before ReadFile");

//ReadFileSync
try {
    const buffer = fs.readFileSync("data.xlsx");
    const data = XLSX.utils.sheet_to_json(
        XLSX.read(buffer, { type: "buffer" }).Sheets["Sheet1"]
    );
    console.log("Data using ReadFileSync: ", data);
} catch (error) {
    console.error("Error reading file:", error.message);
}
