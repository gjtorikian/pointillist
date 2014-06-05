# Pointillist

Convert Atom stylesheets into Pygments-compatible syntax highlighting.

## Creating new languages

You'll need [CoffeeScript](http://coffeescript.org/) installed. You'll also need
[cson](https://github.com/bevry/cson) installed, globally:

``` bash
npm install -g cson
```

With that out of the way, you can now run *script/add-language*, which takes two arguments:

1. The GitHub `username/repository` with a language file you're interested in
2. The name of the `<grammer>.cson` file you want to copy.

For example, to fetch Atom's CoffeeScript highlighting, you'd invoke:

```
script/add-language atom/language-coffee-script coffeescript
```

That second `coffeescript` string comes from the fact that [the filename under *grammars* is called *coffeescript.cson*][coffeescript grammar]

## How does it work?

[Textpow][] does most of the heavy lifting. It reads YAML files of TextMate language definitions, and expects a processor to transform a string into some desirable output--in this case, an HTML document with Pygments class names.

Atom's syntax highlighting consists of CSON files generated from TextMate language definitions. We can easily convert this CSON to JSON, and, since JSON is considered a subset of YAML, we can use Textpow's same `YAML.load` calls to generate a mapping. All this library really does is define a renderer, called *pygments.render*, which maps TextMate grammar rules to expected HTML. For example:

``` yaml
begin: <span class="c1">
end: </span>
selector: comment.line.number-sign
```

In this example, when Textpow detects a string falling within a `comment.line.number-sign` rule, it wraps it up in `<span class="c1">`.

[coffeescript grammar]: https://github.com/atom/language-coffee-script/blob/0fb5046daa4a521196f9874260917d22ac2c23d6/grammars/coffeescript.cson
[Textpow]: https://github.com/grosser/textpow
