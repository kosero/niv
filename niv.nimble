# Package

version       = "0.1.0"
author        = "kosero"
description   = "simple text editor with nim"
license       = "BSD-3-Clause"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["niv"]


# Dependencies

requires "nim >= 2.0.10"
requires "ui >= 0.9.4"

