{task, async, sync, go, gutil} = require('ds-gulp-builder')(require('gulp'))

# Zork: It's local version of gulp builder - for gulp builder development
# {task, async, sync, go, gutil} = require('../../GIT/DSGulpBuilder')(require('gulp'))

[src, dest, stat] = ['./src', './build', './static']
tasks = []

# Clear ./build and ./generated folders
clearFolders = [
  task('clear-build').clearFolder(dest).keep('.git')
]

# Copy libs and images
tasks.push task('copy-libs').copy("#{stat}/libs").dest("#{dest}/libs")
tasks.push task('copy-img').copy("#{src}/images").dest("#{dest}/images")

# Build html
tasks.push task('build-html').jade("#{src}/html/**/*.+(jade|html)").dest("#{dest}")

# Build js
tasks.push task('build-app', []).browserify("#{src}/javascript/app.coffee").dest("#{dest}")

# Build sass
tasks.push task('build-sass').sass("#{src}/sass").dest("#{dest}")

#
## Build 'client'
## 1. rest of jades converted to script that loading them to $templateCache
#tasks.push task('build-client-index').jade("#{clientSrc}/index.jade").dest("#{dest}")
## 2. rest of jades converted to script that loading them to $templateCache
#ngClientTemplates = task('ng-client-templates', []).ngJade2js("#{clientSrc}/**/*.+(jade|html)", moduleName: 'ngClientTemplates', prefix: '').dest("#{generated}/ngClientTemplates.js")
## 3. Build 'template' folder. Override ui-bootstrap template
#ngTemplates = task('ng-templates', []).ngJade2js("./src/template/template/**/*.+(jade|html)", moduleName: 'template', prefix: 'template/').dest("#{generated}/templates.js")
## 4. Build 'ng-table-templates' folder. Templates for ng-table directive
#ngTableTemplates = task('ng-table-templates', []).ngJade2js("./src/template/ng-table/**/*.+(jade|html)", moduleName: 'ngTableTemplates', prefix: 'ng-table/').dest("#{generated}/ngTableTemplates.js")
## 5. generate client/ngApp.js
#tasks.push task('build-ngApp', [ngClientTemplates, ngTemplates, ngTableTemplates]).browserify("#{clientSrc}/ngApp.coffee").dest("#{dest}/#{stat}")


## Build 'server'
## 1. run specs
#if !gutil.env.notests
##  compileSpecs = task('compile-specs').coffee2js("#{spec}/server").dest("#{generated}/srv-specs")
##  appSpecs = task('app-specs', [compileSpecs]).jasmine("#{spec}/server", includeStackTrace: true)
#  appSpecs = task('app-specs').jasmine("#{spec}/server", includeStackTrace: false)
#  tasks.push task('build-app', [appSpecs]).coffee2js(serverSrc).dest(dest)
## 2. build js
#else
#  tasks.push task('build-app').coffee2js(serverSrc).dest(dest)
## 3. build sass
#tasks.push task('build-sass').sass(serverSrc).dest("#{dest}/#{stat}")
## 4. copy server jade files (w/o conversion to html)
#tasks.push task('copy-jade').copy("#{serverSrc}/**/*.+(jade|html)").dest(dest)

#tasks.push task('browser-sync').browserSync(dest, proxy: 'localhost:3010')

if gutil.env.dev then go tasks
else go sync [clearFolders, tasks]