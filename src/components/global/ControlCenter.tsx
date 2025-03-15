import { useState } from 'react';
import { MdWifi, MdKeyboardArrowDown, MdLightMode, MdDarkMode } from 'react-icons/md';
import { FaKeyboard, FaPlay, FaPause, FaStepForward, FaStepBackward } from 'react-icons/fa';
import { IoVolumeMedium } from 'react-icons/io5';
import { TbWorld } from 'react-icons/tb';
import { BsBrightnessHigh } from 'react-icons/bs';

interface ControlCenterProps {
  isDark: boolean;
  toggleTheme: () => void;
}

export default function ControlCenter({ isDark, toggleTheme }: ControlCenterProps) {
  const [isPlaying, setIsPlaying] = useState(false);
  const [volume, setVolume] = useState(50);
  const [brightness, setBrightness] = useState(75);

  const handleVolumeChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setVolume(Number(e.target.value));
  };

  const handleBrightnessChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setBrightness(Number(e.target.value));
  };

  return (
    <div className="absolute top-6 right-0 w-80 bg-black/80 backdrop-blur-xl rounded-lg shadow-2xl border border-white/10 text-white p-4 space-y-4">
      {/* Top Grid */}
      <div className="grid grid-cols-2 gap-3">
        <button 
          onClick={toggleTheme}
          className="bg-white/10 p-3 rounded-xl hover:bg-white/20 transition-colors flex items-center justify-between"
        >
          {isDark ? <MdDarkMode size={20} /> : <MdLightMode size={20} />}
          <span className="text-sm">{isDark ? 'Dark Mode' : 'Light Mode'}</span>
        </button>
        <button className="bg-white/10 p-3 rounded-xl hover:bg-white/20 transition-colors flex items-center space-x-2">
          <MdWifi size={20} />
          <span className="text-sm">Wi-Fi</span>
        </button>
        <button className="bg-white/10 p-3 rounded-xl hover:bg-white/20 transition-colors flex items-center space-x-2">
          <TbWorld size={20} />
          <span className="text-sm">Network</span>
        </button>
        <button className="bg-white/10 p-3 rounded-xl hover:bg-white/20 transition-colors flex items-center space-x-2">
          <FaKeyboard size={18} />
          <span className="text-sm">Keyboard</span>
        </button>
      </div>

      {/* Brightness Slider */}
      <div className="space-y-2">
        <div className="flex items-center justify-between">
          <span className="text-sm flex items-center gap-2">
            <BsBrightnessHigh size={16} />
            Display
          </span>
          <span className="text-xs text-white/60">{brightness}%</span>
        </div>
        <input
          type="range"
          min="0"
          max="100"
          value={brightness}
          onChange={handleBrightnessChange}
          className="w-full h-1.5 bg-white/20 rounded-full appearance-none cursor-pointer [&::-webkit-slider-thumb]:appearance-none [&::-webkit-slider-thumb]:h-3 [&::-webkit-slider-thumb]:w-3 [&::-webkit-slider-thumb]:rounded-full [&::-webkit-slider-thumb]:bg-white"
        />
      </div>

      {/* Volume Slider */}
      <div className="space-y-2">
        <div className="flex items-center justify-between">
          <span className="text-sm flex items-center gap-2">
            <IoVolumeMedium size={18} />
            Sound
          </span>
          <span className="text-xs text-white/60">{volume}%</span>
        </div>
        <input
          type="range"
          min="0"
          max="100"
          value={volume}
          onChange={handleVolumeChange}
          className="w-full h-1.5 bg-white/20 rounded-full appearance-none cursor-pointer [&::-webkit-slider-thumb]:appearance-none [&::-webkit-slider-thumb]:h-3 [&::-webkit-slider-thumb]:w-3 [&::-webkit-slider-thumb]:rounded-full [&::-webkit-slider-thumb]:bg-white"
        />
      </div>

      {/* Music Player */}
      <div className="bg-white/5 rounded-xl p-3 space-y-3">
        <div className="flex items-center justify-between">
          <div>
            <h3 className="text-sm font-medium">Now Playing</h3>
            <p className="text-xs text-white/60">Song Title - Artist</p>
          </div>
          <img 
            src="/album-placeholder.jpg" 
            alt="Album Art"
            className="w-12 h-12 rounded-md object-cover"
          />
        </div>
        <div className="flex items-center justify-center gap-4">
          <button className="text-white/80 hover:text-white">
            <FaStepBackward size={14} />
          </button>
          <button 
            className="text-white hover:text-white/80"
            onClick={() => setIsPlaying(!isPlaying)}
          >
            {isPlaying ? <FaPause size={20} /> : <FaPlay size={20} />}
          </button>
          <button className="text-white/80 hover:text-white">
            <FaStepForward size={14} />
          </button>
        </div>
      </div>
    </div>
  );
} 