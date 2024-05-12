import { BooleanLike } from 'common/react';

import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

type Data = {
  mode: number;
  pressure: number;
  isAI: BooleanLike;
  panel_open: BooleanLike;
  flushing: BooleanLike;
};

export const DisposalBin = (props) => {
  const { act, data } = useBackend<Data>();
  const { mode, pressure, isAI, panel_open, flushing } = data;
  let stateColor;
  let stateText;
  if (mode === 2) {
    stateColor = 'good';
    stateText = 'Ready';
  } else if (mode <= 0) {
    stateColor = 'bad';
    stateText = 'N/A';
  } else if (mode === 1) {
    stateColor = 'average';
    stateText = 'Pressurizing';
  } else {
    stateColor = 'average';
    stateText = 'Idle';
  }
  return (
    <Window width={300} height={250}>
      <Window.Content>
        <Section>
          <Box bold m={1}>
            Status
          </Box>
          <LabeledList>
            <LabeledList.Item label="State" color={stateColor}>
              {stateText}
            </LabeledList.Item>
            <LabeledList.Item label="Pressure">
              <ProgressBar
                ranges={{
                  bad: [-Infinity, 0],
                  average: [0, 99],
                  good: [99, Infinity],
                }}
                value={pressure}
                minValue={0}
                maxValue={100}
              />
            </LabeledList.Item>
          </LabeledList>
          <Box bold m={1}>
            Controls
          </Box>
          <LabeledList>
            <LabeledList.Item label="Handle">
              <Button
                icon="toggle-off"
                disabled={isAI || panel_open}
                content="Disengaged"
                selected={flushing ? null : true}
                onClick={() => act('disengageHandle')}
              />
              <Button
                icon="toggle-on"
                disabled={isAI || panel_open}
                content="Engaged"
                selected={flushing ? true : null}
                onClick={() => act('engageHandle')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Power">
              <Button
                icon="toggle-off"
                disabled={mode === -1}
                content="Off"
                selected={mode ? null : true}
                onClick={() => act('pumpOff')}
              />
              <Button
                icon="toggle-on"
                disabled={mode === -1}
                content="On"
                selected={mode ? true : null}
                onClick={() => act('pumpOn')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Eject">
              <Button
                icon="sign-out-alt"
                disabled={isAI}
                content="Eject Contents"
                onClick={() => act('eject')}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
