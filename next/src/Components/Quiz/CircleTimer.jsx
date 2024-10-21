import { useEffect, useState } from 'react';
import { CountdownCircleTimer } from 'react-countdown-circle-timer';

function CircleTimer({ duration=600, onComplete }) {
  const [timerKey, setTimerKey] = useState(0);
  const [timerFinished, setTimerFinished] = useState(false);
  const colors = ['#FF6347', '#FFD700', '#32CD32'];

  useEffect(() => {
    setTimerKey(prevKey => prevKey + 1);
    setTimerFinished(false);
  }, [duration]);

  const handleComplete = () => {
    setTimerFinished(true);
    if (onComplete && typeof onComplete === 'function') {
      onComplete();
    }
  };

  return (
    <div style={{ width: '60px', height: '60px', position: 'absolute', right: '-30px', top: '-80px' }}>
      <CountdownCircleTimer
        key={timerKey}
        isPlaying={!timerFinished}
        duration={duration}
        colors={colors.map(color => [color])}
        // colorsTime={[70,50,20]}
        onComplete={handleComplete}
        size={56}
        strokeWidth={6}
        trailColor="transparent"
      >
        {({ remainingTime }) => (
          <div style={{ fontSize: '20px', fontWeight: 'bold' }}>
            {remainingTime > 0 ? `${Math.floor(remainingTime / 60)}:${remainingTime % 60 < 10 ? '0' : ''}${remainingTime % 60}` : '0:00'}
          </div>
        )}
      </CountdownCircleTimer>
    </div>
  );
}

export default CircleTimer;