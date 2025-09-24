# ECMWF C++ Stack Dependencies

## How to Install for Local Development

Call `build.sh`, by default the dependencies are installed into the current
working directory under `deps`. This can be customized by exorting
`INSTALL_PREFIX`.

In most cases you will want to call:

```bash
INSTALL_PREFIX=~/cxx-deps ./build.sh
```

## How to Use in Bundles

Add `cxx-dependencies` to your bundles CMakeLists.txt

```
ecbuild_bundle( PROJECT cxx-dependencies GIT "ssh://git@github.com/ecmwf/cxx-dependencies"    BRANCH master   UPDATE RECURSIVE)
```

> [!] IMPORTANT
> Do not omit the `RECURSIVE` in the call to `ecbuild_bundle(...)`, this
> ensures that the `cxx-dependencies` is cloned including all submodules.

## Dependecy Listing

| Name | Source | Documentation | Version |
|------|--------|---------------|---------|
| ecbuild | [GitHub](https://github.com/ecmwf/ecbuild) | [Docs](https://ecbuild.readthedocs.io/en/latest/) | 3.11.0 |
| Pybind11 | [GitHub](https://github.com/pybind/pybind11) | [Docs](https://pybind11.readthedocs.io/en/stable/) | 3.0.1 |
| CLI11 | [GitHub](https://github.com/CLIUtils/CLI11) | [Docs](https://cliutils.github.io/CLI11/book/) | 2.5.0 |
| libaec | [DKRRZ](https://gitlab.dkrz.de/k202009/libaec) | [README](https://gitlab.dkrz.de/k202009/libaec/-/blob/master/README.md) | 1.1.3 |

## TODOs

- [ ] Clean up temp folder containing build files after install
