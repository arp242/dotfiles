My dotfiles.

`manage-dotfiles.py` is a tool to manage your dotfiles.

Why another tool?

- It's so obvious how to use this that your grandmother could do it.
- Not tied with git, or any other VCS (does have optional features which require
  either `hg` or `git`).
- Just a few lines of code. Not a crapload some other tools.
- Easy installation *and* upgrade; also makes it easy to *merge* your files.
- Not based on symlinks. Be free to modify your files and *not* merge changes back.

So, how do you use it:

- In the directory `modules` you keep modules.
- Every module has a `module.py` code, here you can assign `files`, `dirs`, and
  `symlinks` to manage as a dict where the key is the destination directory, and
  the value is the directory from which to source them (relative to the module
  dir).
- Run `./manage-dotfiles.py` to install & merge everything, or
  `./manage-dotfiles.py module1 module2` to install only `module1` & `module2`.
  You can also use the `-i` to switch to ask confirmation for everything, and
  the `-f` switch to override all local files regardless of any changes.

Alternatives: [dotfiles.github.io](http://dotfiles.github.io/) lists some.

