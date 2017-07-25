var fs = require('fs'),
	path = require('path'),
	accum = require('accum'),
	React = require('react'),
	tools = require('react-tools'),
	reactify = require('reactify'),
	browserify = require('browserify'),
	stream = require('stream'),
	http = require('http'),
	through = require('through2');

require.extensions['.jsx'] = function(module, filename) {
	module._compile(tools.transform(fs.readFileSync(filename, {encoding: 'utf8'})), filename);
};

var components = {};
fs.readdirSync(path.join(__dirname, '..', 'js/components')).forEach(function(file) {
	components[file.replace(/\.jsx?$/, '')] = require(path.join(__dirname, '..', 'js/components', file));
});

var _cache = {}, _packageCache = {};
function bundle(data, done) {

	var startTime = new Date();
	var s = new stream.Readable();
	s.push(data);
	s.push(null);

	var b = browserify({
		cache: _cache,
		packageCache: _packageCache,
		fullPaths: true,
		basedir: path.join(__dirname, '../js'),
		extensions: [ '.jsx' ]
	})
	b.transform(reactify);
	b.add(s);

	/*
	b.pipeline.get('deps').push(through.obj(function(row, enc, next) {
		_cache[row.file] = JSON.parse(JSON.stringify({ id: row.file, source: row.source, deps: row.deps, file: row.file }));
		next();
	}));
	*/

	b.bundle().pipe(accum(done));
}

function renderReact(data, done) {
	var id = Math.random().toString(36).substring(2);
	// First: render the JSX
	var out = '<script type="text/javascript">' + tools.transform('$(function() { React.render(' + data + ', $("#' + id + '")[0]); });') + '</script>';

	// Yuck
	with (components) {
		out += '<div id="' + id + '">' + eval(tools.transform('React.renderToString(' + data + ')')) + '</div>';
	}

	done(out);
}

var server = http.createServer(function(req, res) {
	var body = '';
	req.on('data', function (data) {
		body += data;
	});
	req.on('end', function() {
		var inc = JSON.parse(body);

		function finish(data) {
			res.writeHead(200, {'Content-Type': 'text/plain'});
			res.end(data);
		}

		if (inc.type == 'bundle') { bundle(inc.data, finish); }
		else if (inc.type == 'react') { renderReact(inc.data, finish); }
	});
});

server.listen(process.argv[2]);
