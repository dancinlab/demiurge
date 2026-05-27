// VerbShell — PR#34: layout 3-column 이 좌측 두 sidebar 를 들고 있으므로
// VerbShell 은 메인 영역 안에서 record / slot / history 3-band 만 제공.

import type { ReactNode } from "react";
import { MainSplitPane } from "./MainSplitPane";
import type { VerbId, VerbStatus } from "./VerbTreeNav";

export async function VerbShell({
  record,
  slot,
  history,
}: {
  verb: VerbId;
  domain: string;
  statusByVerb?: Partial<Record<VerbId, VerbStatus>>;
  record: ReactNode;
  slot: ReactNode;
  history: ReactNode;
}) {
  return <MainSplitPane record={record} slot={slot} history={history} />;
}
