// Bootstrap 4 plugins and inline scripts expect jQuery as a global
// (Webpacker used ProvidePlugin for this).
import jquery from "jquery"
window.$ = window.jQuery = jquery
