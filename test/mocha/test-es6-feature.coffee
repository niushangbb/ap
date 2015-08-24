{expect, iit, idescribe, nit, ndescribe, rtimeout, rinterval} = require('./helper')

describe "test es6 feature",  ->
  it 'es6 Symbol', ->
    expect(sym = Symbol('My symbol')).to.equal sym
    expect(sym2 = Symbol('My symbol')).not.to.equal sym
  it 'let x = something', ->
    `
        let x = 1
        {
            let x = 2
            { let x = 2
            }
            let y = 3
        }
        expect(x).to.equal(1)

    `
    expect(-> y).to.throw()
    return
