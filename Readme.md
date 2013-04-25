# Components for everyone

 The release of [Component](https://github.com/component/component) 0.15.0 adds an extremely simple but crucial feature: dropping prefixes for globally `require()`-d components.

 For those of you who are not familiar Component uses GitHub as its primary registry, thus we do not need to fight over names - there are no collisions. Prior to this release if you were to `require()` a component from _outside_ another you would have to add the username prefix such as `require('visionmedia-superagent')`. This restriction has been lifed and a simple call to `require('superagent')` will do.

 This simple change makes Component a _much_ better candidate for using Components within existing applications or in tandem with other frameworks such as Backbone or AngularJS. The downside of this approach of course is that the rest of your application remains using globals instead of self-contained modules.

## Getting started

 First you'll want to install `component(1)`, if you don't have node installed view the instructions [here](github.com/component/component), otherwise execute:

 ```
$ npm install -g component
 ```

 To get started create a new directory, and place a file named index.html within it, containing a simple list of pets:

 ```html
<html>
<head>
  <title>Component example</title>
  <style>
    body {
      font: 14px Helvetica;
      padding: 50px;
    }
  </style>
</head>
<body>
  <h1>Component example</h1>
  <p>Simple example of using component with script tags for integration with existing frameworks.</p>

  <ul id="pets">
    <li data-species="cat" data-age="3">Manny</li>
    <li data-species="cat" data-age="3">Luna</li>
    <li data-species="ferret" data-age="3">Tobi</li>
    <li data-species="ferret" data-age="2">Loki</li>
    <li data-species="ferret" data-age="6">Jane</li>
  </ul>
</body>
</html>
```

As a contrived example we'll iterate the pet dom nodes and add a paragraph displaying the oldest ferret. To get started installing components create a `./component.json` file with two dependencies, the first is [enumerable](https://github.com/component/enumerable) which we'll use to filter the elements, and [dom](https://github.com/component/dom) which is effectively a small jQuery dom manipulation replacement which itself is comprised of several smaller logical modules.

```json
{
  "name": "myapp",
  "dependencies": {
    "component/enumerable": "0.3.1",
    "component/dom": "0.6.0"
  }
}
```

## Installing the dependencies

Now install the components:

```
$ component install

     install : component/enumerable@0.3.1
     install : component/dom@0.6.0
     install : component/to-function@master
     install : component/type@master
     install : component/event@master
     install : component/delegate@master
     install : component/indexof@master
     install : component/domify@master
     install : component/classes@master
     install : component/css@master
     install : component/sort@master
     install : component/value@master
     install : component/query@master
     install : component/matches-selector@master
     install : component/event@master
     install : component/indexof@master
     complete : component/to-function
     ...
```

## Producing build files

As you can see `component(1)` resolves and installs all of the dependencies much like any other package manager. The next thing we need to do is produce a build of the CSS and JavaScript, in this case just JavaScript:

```
$ component build
```

This produces the `./build` directory containing assets, `build.css`, and `build.js`. Now all you have to do to integrate components into your application is add a `<script src="build/build.js">` tag. Add the following to the bottom of your `<body>` tag to filter the pets:

```html
<script src="build/build.js"></script>
<script>
  var dom = require('dom')
  var list = require('enumerable')

  var pets = list(dom('#pets > li'))

  var name = pets
    .select('.attr("data-species") == "ferret"')
    .select('.attr("data-age") > 4')
    .map('text()')
    .first()

  dom('<p>')
    .text('The oldest ferret is ' + name)
    .appendTo('body')
</script>
```

## Notes

 For the full source of this example view the [component/script-tag-example](https://github.com/component/script-tag-example) repository. To browse over __850__ fantastic components visit [component.io](http://component.io/), and for more development information view the [component/component](https://github.com/component/component) repository.

