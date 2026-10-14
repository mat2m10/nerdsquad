# Pin npm packages by running ./bin/importmap

pin "application"
pin "bootstrap" # @4.6.2
pin "jquery" # @3.7.1
pin "popper.js" # @1.16.1
pin "turbolinks", to: "turbolinks.esm.js" # @5.2.0 (renamed: the turbolinks gem ships a non-module turbolinks.js on the asset path)
pin "jquery_global"
pin "@rails/ujs", to: "rails-ujs.esm.js"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin "@rails/activestorage", to: "activestorage.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
pin_all_from "app/javascript/components", under: "components"
pin_all_from "app/javascript/plugins", under: "plugins"
