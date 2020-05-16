#!/bin/sh
NURSERY_MINIMUM=$(($MEMORY_SIZE / 2))
NURSERY_MAXIMUM=$(($MEMORY_SIZE * 4 / 5))
exec java \
	-Xms${MEMORY_SIZE}M \
	-Xmx${MEMORY_SIZE}M \
	-Dcom.mojang.eula.agree=${EULA} \
	-Xmns${NURSERY_MINIMUM}M \
	-Xmnx${NURSERY_MAXIMUM}M \
	-Xgc:concurrentScavenge \
	-Xgc:dnssExpectedTimeRatioMaximum=3 \
	-Xgc:scvNoAdaptiveTenure \
	-Xgc:scvTenureAge=1 \
	-Xdisableexplicitgc \
	-Xshareclasses \
	-jar /paperspigot.jar nogui
