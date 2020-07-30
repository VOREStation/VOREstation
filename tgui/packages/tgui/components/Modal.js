import { classes } from 'common/react';
import { computeBoxClassName, computeBoxProps } from './Box';
import { Dimmer } from './Dimmer';

export const Modal = props => {
  const {
    className,
    children,
<<<<<<< HEAD
    onEnter,
    ...rest
  } = props;
  let handleKeyDown;
  if (onEnter) {
    handleKeyDown = e => {
      let key = e.which || e.keyCode;
      if (key === 13) {
        onEnter(e);
      }
    };
  }
  return (
    <Dimmer
      onKeyDown={handleKeyDown}>
=======
    ...rest
  } = props;
  return (
    <Dimmer>
>>>>>>> f1eb479... Merge pull request #7317 from ShadowLarkens/tgui
      <div
        className={classes([
          'Modal',
          className,
          computeBoxClassName(rest),
        ])}
        {...computeBoxProps(rest)}>
        {children}
      </div>
    </Dimmer>
  );
};
