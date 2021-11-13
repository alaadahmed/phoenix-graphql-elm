const esbuild = require('esbuild')
const ElmPlugin = require('esbuild-plugin-elm')
const sassPlugin = require('esbuild-plugin-sass')
const postCssPlugin = require("@deanc/esbuild-plugin-postcss");
const autoprefixer = require('autoprefixer')
const tailwindcss = require('tailwindcss')

const args = process.argv.slice(2)
const watch = args.includes('--watch')
const deploy = args.includes('--deploy')

const loader = {
  // Add loaders for images/fonts/etc, e.g. {'.svg': 'file'}
}

const plugins = [
  ElmPlugin({
    debug: true,
    clearOnWatch: true,
  }),
  postCssPlugin({
    plugins: [
      autoprefixer,
      tailwindcss
    ]
  }),
  sassPlugin(),
]

let opts = {
  entryPoints: ['js/app.js'],
  bundle: true,
  target: 'es2017',
  outdir: '../priv/static/assets',
  logLevel: 'info',
  loader,
  plugins
}

if (watch) {
  opts = {
    ...opts,
    watch,
    sourcemap: 'inline'
  }
}

if (deploy) {
  opts = {
    ...opts,
    minify: true
  }
}

const promise = esbuild.build(opts)

if (watch) {
  promise.then(_result => {
    process.stdin.on('close', () => {
      process.exit(0)
    })

    process.stdin.resume()
  })
}
