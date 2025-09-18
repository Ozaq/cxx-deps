# Build Scripts

Add one script per dependency, this script controls build and install. Before
calling the individual build scripts the following environment variables are
exported for the scripts to use:


`INSTALL\_PREFIX`
Specifies root of the install tree, pass it on to cmake with
-DCMAKE\_INSTALL\_PREFIX. If your dependency depends on other dependencies pass
-DCMAKE\_PREFIX\_PATH as well so that cmake can find allready build
dependencies.

`BUILD\_PATH`
Root path for all build output, create a subfolder in this path for your build
script, e.g. `mkdir -p $BUILD_PATH/libfoo`.

Inside your build script define a function `build()`, this will be called from
[build.sh](../build.sh).
