import { MdWifi, MdBluetooth } from 'react-icons/md';
import { BsBrightnessHigh, BsMoonStars } from 'react-icons/bs';
import { AiOutlineShareAlt } from 'react-icons/ai';

interface ControlCenterProps {
  isDark: boolean;
  toggleTheme: () => void;
}

export default function ControlCenter({ isDark, toggleTheme }: ControlCenterProps) {
  return (
    <div className="absolute top-6 right-0 w-80 bg-black/80 backdrop-blur-xl rounded-lg shadow-2xl border border-white/10">
      <div className="p-4 space-y-4">
        {/* Top Row */}
        <div className="grid grid-cols-2 gap-3">
          <button className="flex flex-col items-center justify-center p-3 rounded-xl bg-white/10 hover:bg-white/20 transition-colors">
            <MdWifi size={24} className="text-white" />
            <span className="text-xs text-white mt-1">Wi-Fi</span>
          </button>
          <button className="flex flex-col items-center justify-center p-3 rounded-xl bg-white/10 hover:bg-white/20 transition-colors">
            <MdBluetooth size={24} className="text-white" />
            <span className="text-xs text-white mt-1">Bluetooth</span>
          </button>
        </div>

        {/* Middle Row */}
        <div className="grid grid-cols-2 gap-3">
          <button className="flex flex-col items-center justify-center p-3 rounded-xl bg-white/10 hover:bg-white/20 transition-colors">
            <AiOutlineShareAlt size={24} className="text-white" />
            <span className="text-xs text-white mt-1">AirDrop</span>
          </button>
          <button 
            onClick={toggleTheme}
            className="flex flex-col items-center justify-center p-3 rounded-xl bg-white/10 hover:bg-white/20 transition-colors"
          >
            {isDark ? (
              <>
                <BsMoonStars size={24} className="text-white" />
                <span className="text-xs text-white mt-1">Dark Mode</span>
              </>
            ) : (
              <>
                <BsBrightnessHigh size={24} className="text-white" />
                <span className="text-xs text-white mt-1">Light Mode</span>
              </>
            )}
          </button>
        </div>

        {/* Display & Sound Controls */}
        <div className="space-y-4">
          <div className="space-y-2">
            <div className="flex items-center justify-between text-xs text-white">
              <span>Display</span>
              <span>75%</span>
            </div>
            <div className="w-full h-1 bg-white/20 rounded-full">
              <div className="w-3/4 h-full bg-white rounded-full"></div>
            </div>
          </div>

          <div className="space-y-2">
            <div className="flex items-center justify-between text-xs text-white">
              <span>Sound</span>
              <span>60%</span>
            </div>
            <div className="w-full h-1 bg-white/20 rounded-full">
              <div className="w-3/5 h-full bg-white rounded-full"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
} 