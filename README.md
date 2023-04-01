# endoplasm-setup

Automated configuration setup for my Linux workstations

:warning: **I would not recommend you to run this repo!**: This is for my
convenience only. If you do insist on using it, please only run it on a clean
system that you don't mind messing up if things go wrong. Also, please read
through the scripts and understand them before running.

## Requirements

Start with a clean installation of [`Pop!_OS 22.04 LTS
(NVIDIA)`](https://pop.system76.com/).

## (Optional) Change hostname to whatever you want

It has to be changed in two places. First run:

```bash
sudo hostnamectl set-hostname [your hostname]
```

Then sudo edit `/etc/hosts`, changing all instances of `pop-os` to your hostname.
Here's an example of what it would look like:

```
127.0.0.1 localhost
::1   localhost
127.0.1.1 [your hostname].localdomain  [your hostname]
```

## Installation

Run the following:

```bash
bash run.sh
```

When prompted, enter your password and accept any EULAs.

When the script is finished without error, restart your machine.

If there are any errors, you gotta figure out what's wrong.
