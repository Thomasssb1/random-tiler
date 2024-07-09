package = "random-tiler"
version = "dev-1"
source = {
   url = "git+https://github.com/Thomasssb1/random-tiler.git"
}
description = {
   homepage = "https://github.com/Thomasssb1/random-tiler",
   license = "*** please specify a license ***"
}
dependencies = {
   "oocairo"
}
build = {
   type = "builtin",
   modules = {
      main = "main.lua",
      node = "node.lua",
      quad = "quad.lua"
   }
}
