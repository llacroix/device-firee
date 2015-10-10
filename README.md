# Alcatel OneTouch Fire E (OT-6015x)

This is an attempt to create a usable build profile for the phone OT-6015x. The sources to compile b2g are available on SourceForge: [http://sourceforge.net/projects/alcatel/files/OT_FF_6015X_20150403.tar.xz/download](http://sourceforge.net/projects/alcatel/files/OT_FF_6015X_20150403.tar.xz/download).

# Setup

In order to build the device, you have to set b2g to use this repository [https://github.com/llacroix/b2g-manifest](https://github.com/llacroix/b2g-manifest) instead of the usual b2g-manifest repository. The custom b2g-manifest repository add the firee build profile to b2g.

Run:

    ./config.sh firee

Then:

    ./build.sh

# Status

What needs to be done:

- [x] Kernel build working
- [ ] B2G builds
  - [ ] B2G boot
  - [ ] Userdata / Custpack split

Read more about the device in the [Wiki](https://github.com/llacroix/device-firee/wiki)
