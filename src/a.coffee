`
export const x = 1
export const b = 2
`

`var a = 1`

a = 2

a = 3

`
    let target = {};
    let handler = {
        get(target, propKey, receiver) {
            console.log('get ' + propKey);
            return 123;
        }
    };
    // let proxy = new Proxy(target, handler); // http://stackoverflow.com/questions/23013829/chrome-javascript-proxy-object-is-not-defined

    var sym = Symbol('My symbol')
`