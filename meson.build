project('eONpy', 'cpp',
  default_options : ['warning_level=3', 'cpp_std=c++17'])

_args = [] # Extra arguments
_fargs = [] # Fortran arguments TODO(rg): Maybe unused from a binding persp
_deps = [] # Dependencies
_linkto = [] # All the sub-libraries
_incdirs = [] # All the includes

cppc = meson.get_compiler('cpp')

# TODO(rg): Maybe needs better defaults
eclib_dep = subproject('EONgit',
                       default_options: [
                         'default_library=static'
                       ]).get_variable(
                         'eclib_dep'
                       )
_deps += [eclib_dep]

py = import('python').find_installation(pure: false)
_deps += [
  py.dependency(),
  dependency('pybind11'),
  ]

# for the bindings
py.extension_module(
  '_eclib',
  sources : [
    'pyb11_srcs/bindings.cpp'
  ],
  include_directories: _incdirs,
  dependencies: _deps,
  link_with: _linkto,
  cpp_args : _args,
  install: true,
  subdir: 'eONpy/'
)


# eONpy main package
py.install_sources([
    'eONpy/__init__.py',
  ],
  pure: false, # install next to compiled extension
  subdir: 'eONpy'
)
