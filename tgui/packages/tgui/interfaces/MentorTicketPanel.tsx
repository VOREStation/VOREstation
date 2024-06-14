/* eslint react/no-danger: "off" */
import { toFixed } from 'common/math';

import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const State = {
  open: 'Open',
  resolved: 'Resolved',
  unknown: 'Unknown',
};

type Data = {
  id: number;
  title: string;
  name: string;
  state: string;
  opened_at: number;
  closed_at: number;
  opened_at_date: string;
  closed_at_date: string;
  actions: string;
  log: string[];
};

export const MentorTicketPanel = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    id,
    title,
    name,
    state,
    opened_at,
    closed_at,
    opened_at_date,
    closed_at_date,
    actions,
    log,
  } = data;
  return (
    <Window width={900} height={600}>
      <Window.Content scrollable>
        <Section
          title={'Ticket #' + id}
          buttons={
            <Box nowrap>
              <Button icon="arrow-up" onClick={() => act('escalate')}>
                Escalate
              </Button>
              <Button onClick={() => act('legacy')}>Legacy UI</Button>
            </Box>
          }
        >
          <LabeledList>
            <LabeledList.Item label="Mentor Help Ticket">
              #{id}: <div dangerouslySetInnerHTML={{ __html: name }} />
            </LabeledList.Item>
            <LabeledList.Item label="State">{State[state]}</LabeledList.Item>
            {State[state] === State.open ? (
              <LabeledList.Item label="Opened At">
                {opened_at_date +
                  ' (' +
                  toFixed(opened_at / 600) +
                  ' minutes ago.)'}
              </LabeledList.Item>
            ) : (
              <LabeledList.Item label="Closed At">
                {closed_at_date +
                  ' (' +
                  toFixed(closed_at / 600) +
                  ' minutes ago.)'}
                <Button onClick={() => act('reopen')}>Reopen</Button>
              </LabeledList.Item>
            )}
            <LabeledList.Item label="Actions">
              <div dangerouslySetInnerHTML={{ __html: actions }} />
            </LabeledList.Item>
            <LabeledList.Item label="Log">
              {Object.keys(log).map((L, i) => (
                <div key={i} dangerouslySetInnerHTML={{ __html: log[L] }} />
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
