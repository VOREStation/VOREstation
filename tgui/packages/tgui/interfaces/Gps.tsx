// Currently not used!

import { map, sortBy } from 'common/collections';
import { flow } from 'common/fp';
import { clamp } from 'common/math';
import { BooleanLike } from 'common/react';
import { vecLength, vecSubtract } from 'common/vector';

import { useBackend } from '../backend';
import { Box, Button, Icon, LabeledList, Section, Table } from '../components';
import { Window } from '../layouts';

const coordsToVec = (coords) => map(coords.split(', '), parseFloat);

type Data = {
  currentArea: string;
  power: BooleanLike;
  tag: string;
  updating: BooleanLike;
  currentCoords: string; // "x, y, z"
  globalmode: BooleanLike;
  signals: signal[];
};

type signal = {
  entrytag: string;
  coords: string;
  dist: number;
  degrees: number;
};

export const Gps = (props) => {
  const { act, data } = useBackend<Data>();
  const { currentArea, currentCoords, globalmode, power, tag, updating } = data;
  const signals = flow([
    (signals: signal[]) =>
      map(signals, (signal, index) => {
        // Calculate distance to the target. BYOND distance is capped to 127,
        // that's why we roll our own calculations here.
        const dist =
          signal.dist &&
          Math.round(
            vecLength(
              vecSubtract(
                coordsToVec(currentCoords),
                coordsToVec(signal.coords),
              ),
            ),
          );
        return { ...signal, dist, index };
      }),
    (signals: signal[]) =>
      sortBy(
        signals,
        // Signals with distance metric go first
        (signal) => signal.dist === undefined,
        // Sort alphabetically
        (signal) => signal.entrytag,
      ),
  ])(data.signals || []);
  return (
    <Window title="Global Positioning System" width={470} height={700}>
      <Window.Content scrollable>
        <Section
          title="Control"
          buttons={
            <Button
              icon="power-off"
              selected={power}
              onClick={() => act('power')}
            >
              {power ? 'On' : 'Off'}
            </Button>
          }
        >
          <LabeledList>
            <LabeledList.Item label="Tag">
              <Button icon="pencil-alt" onClick={() => act('rename')}>
                {tag}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Scan Mode">
              <Button
                icon={updating ? 'unlock' : 'lock'}
                color={!updating && 'bad'}
                onClick={() => act('updating')}
              >
                {updating ? 'AUTO' : 'MANUAL'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Range">
              <Button
                icon="sync"
                selected={!globalmode}
                onClick={() => act('globalmode')}
              >
                {globalmode ? 'MAXIMUM' : 'LOCAL'}
              </Button>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {!!power && (
          <>
            <Section title="Current Location">
              <Box fontSize="18px">
                {currentArea} ({currentCoords})
              </Box>
            </Section>
            <Section title="Detected Signals">
              <Table>
                <Table.Row bold>
                  <Table.Cell content="Name" />
                  <Table.Cell collapsing content="Direction" />
                  <Table.Cell collapsing content="Coordinates" />
                </Table.Row>
                {signals.map((signal) => (
                  <Table.Row
                    key={signal.entrytag + signal.coords + signal.index}
                    className="candystripe"
                  >
                    <Table.Cell bold color="label">
                      {signal.entrytag}
                    </Table.Cell>
                    <Table.Cell
                      collapsing
                      opacity={
                        signal.dist !== undefined &&
                        clamp(1.2 / Math.log(Math.E + signal.dist / 20), 0.4, 1)
                      }
                    >
                      {signal.degrees !== undefined && (
                        <Icon
                          mr={1}
                          size={1.2}
                          name="arrow-up"
                          rotation={signal.degrees}
                        />
                      )}
                      {signal.dist !== undefined && signal.dist + 'm'}
                    </Table.Cell>
                    <Table.Cell collapsing>{signal.coords}</Table.Cell>
                  </Table.Row>
                ))}
              </Table>
            </Section>
          </>
        )}
      </Window.Content>
    </Window>
  );
};
