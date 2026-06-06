#!/bin/bash
# Master: wait all 16 shards JOB DONE, assemble each q (recover full-irr on its s1 pod),
# harvest dyn5-8 + elph5-8 locally. Runs as one long bg job.
D=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16
S="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=10 -o ServerAliveInterval=30 -o BatchMode=yes"
# allmap.txt is prebuilt (16 shards: ID HOST PORT Q SI LI TAG)

shard_done(){ # host port q -> echo 1 if JOB DONE
  local host=$1 port=$2
  local j=$(timeout 12 ssh $S -p $port root@$host "grep -c 'JOB DONE' /root/work/ph.out 2>/dev/null" 2>/dev/null | tail -1)
  [ "$j" = "1" ] && echo 1 || echo 0
}

echo "=== MASTER START $(date) ==="
# Phase 1: wait for all 16 done
for round in $(seq 1 48); do  # 48*150s = 2h cap
  nd=0; pending=""
  while read id host port q si li tag; do
    d=$(shard_done "$host" "$port")
    [ "$d" = "1" ] && nd=$((nd+1)) || pending="$pending $tag"
  done < $D/allmap.txt
  echo "[$(date +%H:%M:%S)] done=$nd/16 pending:$pending"
  [ $nd -ge 16 ] && { echo ALL16_DONE; break; }
  sleep 150
done

# Phase 2: assemble each q on its s1 pod
echo "=== ASSEMBLY $(date) ==="
get(){ grep " $1\$" $D/allmap.txt | head -1; }  # tag -> line
for q in 5 6 7 8; do
  read i1 h1 p1 qq s s2 t1 <<< "$(get q$q-s1)"
  read i2 h2 p2 a b c t2 <<< "$(get q$q-s2)"
  read i3 h3 p3 a b c t3 <<< "$(get q$q-s3)"
  read i4 h4 p4 a b c t4 <<< "$(get q$q-s4)"
  echo "[asm q$q] base=$h1:$p1  others=$h2:$p2 $h3:$p3 $h4:$p4"
  bash $D/assemble_q.sh $q $h1 $p1 "$h2:$p2" "$h3:$p3" "$h4:$p4"
done

# Phase 3: wait assemblies + harvest
echo "=== HARVEST WAIT $(date) ==="
for round in $(seq 1 20); do
  na=0
  for q in 5 6 7 8; do
    read i1 h1 p1 r <<< "$(get q$q-s1)"
    x=$(timeout 12 ssh $S -p $p1 root@$h1 "grep -c ASMEXIT_0 /root/work/ph_asm$q.log 2>/dev/null" 2>/dev/null|tail -1)
    [ "$x" = "1" ] && na=$((na+1))
  done
  echo "[$(date +%H:%M:%S)] assemblies done=$na/4"
  [ $na -ge 4 ] && break
  sleep 60
done

mkdir -p $D/harvest_final
for q in 5 6 7 8; do
  read i1 h1 p1 r <<< "$(get q$q-s1)"
  scp $S -P $p1 "root@$h1:/root/work/li2mgh16.dyn$q" "$D/harvest_final/" 2>/dev/null
  scp $S -P $p1 "root@$h1:/root/work/li2mgh16.dyn$q.elph.$q" "$D/harvest_final/" 2>/dev/null
  scp $S -P $p1 "root@$h1:/root/work/ph_asm$q.out" "$D/harvest_final/ph_asm$q.out" 2>/dev/null
done
echo "=== HARVEST DONE $(date) ==="
ls -la $D/harvest_final/li2mgh16.dyn5 $D/harvest_final/li2mgh16.dyn6 $D/harvest_final/li2mgh16.dyn7 $D/harvest_final/li2mgh16.dyn8 2>/dev/null
echo MASTER_COMPLETE
