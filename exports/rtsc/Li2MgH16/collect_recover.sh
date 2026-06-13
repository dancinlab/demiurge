#!/bin/bash
# Collect 4 shards of a q-point into the assembly host, run recover to assemble full dynN+elphN.
# The assembly happens on a dedicated assembly pod (one of the shards, repurposed) holding the
# full out/li2mgh16.save. Each shard contributes its out/_ph0/li2mgh16.q_N/ + phsave/{dynmat,elph}.N.*.xml
# args: Q ASSEMBLY_HOST ASSEMBLY_PORT  <then list of "host:port" for the 4 shards>
# Strategy: pull each shard's phsave partials (dynmat.N.M.xml, elph.N.M.xml) to LOCAL, then push
# the merged set to the assembly pod, run ph.x recover=.true full irr range -> dynN + elphN.
set -e
Q=$1; AH=$2; AP=$3; shift 3
SHARDS=("$@")
S="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=25 -o ServerAliveInterval=30"
LOC=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16/assembly/q$Q
mkdir -p $LOC/phsave_parts
echo "[collect q$Q] pulling shard phsave partials..."
for hp in "${SHARDS[@]}"; do
  h=${hp%:*}; p=${hp#*:}
  scp $S -P $p "root@$h:/root/work/out/_ph0/li2mgh16.phsave/dynmat.$Q.*.xml" $LOC/phsave_parts/ 2>/dev/null || echo "  (no dynmat from $hp)"
  scp $S -P $p "root@$h:/root/work/out/_ph0/li2mgh16.phsave/elph.$Q.*.xml"   $LOC/phsave_parts/ 2>/dev/null || echo "  (no elph from $hp)"
done
echo "[collect q$Q] dynmat parts: $(ls $LOC/phsave_parts/dynmat.$Q.*.xml 2>/dev/null|wc -l)  elph parts: $(ls $LOC/phsave_parts/elph.$Q.*.xml 2>/dev/null|wc -l)"
