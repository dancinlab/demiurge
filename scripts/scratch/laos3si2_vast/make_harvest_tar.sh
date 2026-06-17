#!/usr/bin/env bash
# Bundle LaOs3Si2 DFPT el-ph results for local harvest (c5 preserve).
set -uo pipefail
cd /home/summer/laos3si2_dfpt || exit 2
tar czf laos3si2_elph_harvest.tgz \
  laos3si2.dyn0 laos3si2.dyn1 laos3si2.dyn2 laos3si2.dyn3 laos3si2.dyn4 \
  laos3si2.dyn1.elph.1 laos3si2.dyn2.elph.2 laos3si2.dyn3.elph.3 laos3si2.dyn4.elph.4 \
  scf.out ph_elph.out ph.in scf.in 2>/dev/null
ls -la laos3si2_elph_harvest.tgz
echo "--- contents ---"
tar tzf laos3si2_elph_harvest.tgz
