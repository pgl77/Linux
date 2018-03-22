#!/bin/sh
rsync -av --delete /home/peter/ /media/peter/714DEB1579F92BE0/home_bak
# rsync -avn --delete /home/peter/ /media/peter/714DEB1579F92BE0/home_bak
#trailing n on -avn just tests

#Test on trial data
#rsync -av --delete /home/peter/testdir/ /media/peter/714DEB1579F92BE0/home_bak
#test works - 

# N.B.
#we need trailing bar on source. Otherwise we create home_bak/testdir. Rather than copying contenst of testdir into home_bak

#From man rsync

# rsync -avz foo:src/bar /data/tmp

#       This would recursively transfer all files from the directory src/bar on the machine foo into the /data/tmp/bar directory on the local machine. The files  are  trans‐
#       ferred  in  "archive"  mode, which ensures that symbolic links, devices, attributes, permissions, ownerships, etc. are preserved in the transfer.  Additionally, com‐
#       pression will be used to reduce the size of data portions of the transfer.

#              rsync -avz foo:src/bar/ /data/tmp

#       A trailing slash on the source changes this behavior to avoid creating an additional directory level at the destination.  You can think of a trailing / on  a  source
#       as  meaning "copy the contents of this directory" as opposed to "copy the directory by name", but in both cases the attributes of the containing directory are trans‐
#       ferred to the containing directory on the destination.
