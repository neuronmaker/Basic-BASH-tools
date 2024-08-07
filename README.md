# Basic BASH Tools

This is a collection of basic tools that I made to speed up some repetitive
tasks that I find tedious.

These files will probably "just work" independently of many configurations.
Though you may need to install external software to make some of these tools
work, but many dependencies come pre-installed with most Linux based operating
systems. Often they are ways to wrap an existing program and automate a repetitive task.

## These may or may not work for you and your system

I am not maintaining a high quality set of utilities here. These are simple tools
that I made for my own personal use, on my systems, and I publish them in case
someone finds them useful.

## Requirements

- Flac wrapper scripts
  - `flac.sh` - Requires a working flac encoder that is accessible by the `flac` command
  - `flac-pipe.sh` - Requires a working `flac.sh` script, change the `flacScript` variable to reflect where the script is located
  - `find-flac.sh` - Requires a working `flac-pipe.sh` script
- `photoname.sh` - Requires a working version of `exiftool`
- `enable-git-signing.sh` - Only requires a working installation of the `git` version control tool
- `rotate-background.sh` - Only designed to work on Cinnamon, it also needs two background image files to be set into its variables