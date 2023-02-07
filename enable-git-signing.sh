#!/bin/bash
# Simple script to tell Git about your GPG key and maybe tell Git to sign commits by default
# This is a SUPER basic script, I only made this for myself and will probably have to change it as time goes on
# To find this, run gpg -K command, this will print the keys which you have the private key for,
# then copy the last 16 digits of your preferred key fingerprint.
# Refer to the guide that Github published on how to enable git signing.
gpgKey="48A73B8C89207930" #this is my current preferred key, you should change this to your key's fingerprint
# uncomment below to unset previous a configuration
# git config --global --unset gpg.format

# tell git about your GnuPG key
git config --global user.signingkey $gpgKey

# setting default git options
signCommits="true" # "true" signs commits by default, "false" requires use of the -S option
signTags="true" # "true signs tags by default, "false" does not
# apply the above options
git config --global commit.gpgSign $signCommits
git config --global tag.gpgSign $signTags

