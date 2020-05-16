# minecraft-docker

based off [Marc Tönsing's previous work](https://github.com/mtoensing/Docker-Minecraft-PaperMC-Server), this repository includes scripts to create container images to run [PaperMC](https://papermc.io/) 1.15.2 minecraft servers. the build script allows you to change which JDK version of [AdoptOpenJDK](https://adoptopenjdk.net/) you want to use (14 by default) and the JVM implementation:
* hotspot: the default. higher performance but also higher memory usage
* openj9: you should probably only use this if you are absolutely up against the wall in terms of memory

it also caches the paperclip.jar patcher and patched minecraft server jar, which docker's ADD command doesn't do, because blah blah blah

## why

i didn't ask myself this question when i wrote this in the first place but I really should've. introducing docker makes everything more complicated, you are honestly probably better off just running the server inside a tmux session using a regular user.

## prerequisites

to run the build script you need a java runtime and `curl` on the path. currently the build script refers to docker only, if you want to use podman you may need to change it.

## usage

the build script has two options:

* `-9`: build an OpenJ9 image
* `-v VERSION`: build an image using a certain JDK version

the run script creates a throwaway container that stores the minecraft server data in the `mcdata` volume which you should create prior to using it. it sets the heap size to 2 gigabytes and accepts the EULA for you. publishes the default port (25565) and uses cloudflare dns because it was bugging out for me although thats probably because i use nftables on my server and docker DOESNT SUPPORT NFTABLES YET

## start scripts

the start scripts are different between the runtime implementations. HotSpot uses [Aikar's flags](https://mcflags.emc.gs) and OpenJ9 mostly uses [Tux's flags](https://steinborn.me/posts/tuning-minecraft-openj9/). they use 2 environment variables you can set in `run.sh`:

* `MEMORY_SIZE`: heap size in **megabytes**
* `EULA`: become submissive to Mojang. foolishly this is set to true by default. idk if this is legal or not

## legality

it's actually probably illegal to publish these images in binary form anywhere since they contain the proprietary server jar.

the default setting of `$EULA` is true. the server helpfully informs you that this means you agree to Mojang's [EULA](https://account.mojang.com/documents/minecraft_eula).