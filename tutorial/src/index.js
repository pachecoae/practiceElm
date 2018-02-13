'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

// Require index.html so it gets copied to the dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// .embed() cdan take an optional second argument
// This would be an object describing the data we need to start a program
// i.e. a user id or some token
var app = Elm.Main.embed(mountNode);