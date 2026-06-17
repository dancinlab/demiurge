# LaOs3Si2 DFPT el-ph — vast 41069486 q3·q4 parallel shard (2026-06-17)

Source SCF base: summer ~/laos3si2_dfpt/ (verified ph.in, q1·q2 already el-ph complete).
Transfer: summer→mini LAN scp (md5 1d7748fc85af5b0ec3d968d943e39f59) → pod via hexa cloud copy-to (sha256 verified 1e518a5441c3).
charge-density.hdf5 md5 = 01d437bc08ce46b0e1285805e14ccaa9 (matches summer original).

Pod: vast 41069486 (64 core / 125G / QE 7.5 conda env qe, openmpi).
Split: q3 → /root/laos3si2_q3 (32 ranks, PID 17002), q4 → /root/laos3si2_q4 (32 ranks, PID 17162).
Each shard: isolated TMPDIR + --mca orte_tmpdir_base to avoid PMIx session-dir collision.
ph.in shards = verified ph.in + start_q/last_q + absolute outdir (only deltas; all physics params untouched).

dyn0 q-list (2x2x2 irreducible, 4 q):
  q1 = Gamma           (summer: done)
  q2 = (0,0,-0.746)    (summer: done)
  q3 = (0,-0.577,0)    (vast shard)
  q4 = (0,-0.577,-0.746) (vast shard)
