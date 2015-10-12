# Alcatel OneTouch Fire E (OT-6015x)

This is an attempt to create a usable build profile for the phone OT-6015x. The sources to compile b2g are available on SourceForge: [http://sourceforge.net/projects/alcatel/files/OT_FF_6015X_20150403.tar.xz/download](http://sourceforge.net/projects/alcatel/files/OT_FF_6015X_20150403.tar.xz/download).

# Setup

In order to build the device, you have to set b2g to use this repository [https://github.com/llacroix/b2g-manifest](https://github.com/llacroix/b2g-manifest) instead of the usual b2g-manifest repository. The custom b2g-manifest repository add the firee build profile to b2g.

The kernel sources aren't yet configured in the manifest to point to something that works. If you want to build the kernel, you can configure the epo with ``config.sh` then create a new branch in `kerel/` paste the sources ther and commit the changes. If you rerun the `config` or sync the repos... It will probably change the working directory of the kernel. After that just checkout the branch you added.

Run:

    ./config.sh firee

Then:

    ./build.sh

# Status

What needs to be done:

- [x] Kernel build working
- [x] Userdata build working (1.3)
- [ ] Add the kernel sources (somewhere) and fix the manifest
- [ ] B2G builds
  - [ ] B2G boot
- [ ] Enable hidden soft buttons on the bottom of the display: The phone has 3 soft buttons with keycode (158 102 139). The alcatel 6015x is a clone of the alcatel onetouch idol 2 mini L (ot-6014x). The button works in ClockWorkMod recovery.

Read more about the device in the [Wiki](https://github.com/llacroix/device-firee/wiki)
