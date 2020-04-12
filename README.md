# Summary
This repository contains xLua scripts for DDenn's Bombardier Challenger 300. It replaces some standard xPlane commands with CL300 specific variants. My motivation was to control lights using standard xPlane commands = with my new Honeycomb Aplha Flight Control yoke. It means for example standard xPlane command `sim/lights/landing_lights_on` which you can map in controls section works with Challenger - it turns on all 3 landing lights switches.

# Installation
Copy xLua plugin from any LR aircraft (like 747) and to CL300 dir and empty scripts directory. Then clone (or download and unzip) content of this repo to `scripts` directory. After the installation you should have directory structure like this
```
Challenger300_XP11
  plugins
    xlua
      64
      init.lua
      scripts
        cl300_enh
          cl300_enh.lua
```

Then you can use standard light commands defined [here](https://github.com/me2d13/cl300_enh/blob/master/cl300_enh.lua#L65) to controll Challenger.

# Motivation
_Why xLua when CL300 uses sasl?_

Because I wanted to use something light (xLua) and I don't want to modify existing sasl scripts. This repo works as addition, not modification.

