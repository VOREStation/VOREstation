export const stats: (string | undefined)[] = [undefined, 'average', 'bad'];

export const digestModeToColor = {
  Hold: null,
  Digest: 'red',
  Absorb: 'purple',
  Unabsorb: 'purple',
  Drain: 'orange',
  Selective: 'orange',
  Shrink: 'teal',
  Grow: 'teal',
  'Size Steal': 'teal',
  Heal: 'green',
  'Encase In Egg': 'blue',
};

export const digestModeToPreyMode = {
  Hold: 'being held.',
  Digest: 'being digested.',
  Absorb: 'being absorbed.',
  Unabsorb: 'being unabsorbed.',
  Drain: 'being drained.',
  Selective: 'being processed.',
  Shrink: 'being shrunken.',
  Grow: 'being grown.',
  'Size Steal': 'having your size stolen.',
  Heal: 'being healed.',
  'Encase In Egg': 'being encased in an egg.',
};
