import { useState, useEffect } from 'react';
import { MdWifi, MdNotifications } from 'react-icons/md';
import { FaApple } from 'react-icons/fa';
import { IoCellular, IoBatteryHalfOutline } from 'react-icons/io5';
import { VscVscode } from 'react-icons/vsc';
import { BsGearFill } from 'react-icons/bs';
import ControlCenter from './ControlCenter';

export default function MacToolbar() {
  const [currentDateTime, setCurrentDateTime] = useState(new Date());
  const [showControlCenter, setShowControlCenter] = useState(false);
  const [showNotifications, setShowNotifications] = useState(false);
  const [isDark, setIsDark] = useState(true);

  useEffect(() => {
    const timer = setInterval(() => {
      setCurrentDateTime(new Date());
    }, 60000);

    return () => clearInterval(timer);
  }, []);

  useEffect(() => {
    // Apply theme to document
    document.documentElement.classList.toggle('dark', isDark);
  }, [isDark]);

  const formatMacDate = (date: Date) => {
    const weekday = date.toLocaleString('en-US', { weekday: 'short' });
    const month = date.toLocaleString('en-US', { month: 'short' });
    const day = date.getDate();
    const hour = date.toLocaleString('en-US', {
      hour: 'numeric',
      hour12: true,
    });
    const minute = date.getMinutes().toString().padStart(2, '0');
    const period = date.getHours() >= 12 ? 'PM' : 'AM';

    return `${weekday} ${month} ${day} ${hour.replace(
      /\s?[AP]M/,
      ''
    )}:${minute} ${period}`;
  };

  const formatIPhoneTime = (date: Date) => {
    let hour = date.getHours();
    const minute = date.getMinutes().toString().padStart(2, '0');

    hour = hour % 12;
    hour = hour ? hour : 12;

    return `${hour}:${minute}`;
  };

  const handleVSCodeClick = () => {
    window.location.href = 'vscode:/';
  };

  const toggleTheme = () => {
    setIsDark(!isDark);
  };

  return (
    <>
      <div className='sticky top-0 z-50 md:hidden bg-transparent text-white h-12 px-8 flex items-center justify-between text-base font-medium'>
        <span className='font-semibold'>
          {formatIPhoneTime(currentDateTime)}
        </span>
        <div className='flex items-center gap-1.5'>
          <IoCellular size={20} />
          <MdWifi size={20} />
          <IoBatteryHalfOutline size={24} />
        </div>
      </div>

      <div className={`sticky top-0 z-50 hidden md:flex ${isDark ? 'bg-black/20' : 'bg-white/20'} backdrop-blur-md text-white h-6 px-4 items-center justify-between text-sm transition-colors duration-200`}>
        <div className='flex items-center space-x-4'>
          <div className="group relative">
            <FaApple size={16} className="cursor-default" />
            <div className={`hidden group-hover:block absolute top-6 left-0 w-56 ${isDark ? 'bg-black/80' : 'bg-white/80'} backdrop-blur-xl rounded-lg shadow-2xl border border-white/10`}>
              <div className="py-1">
                <button className="w-full px-4 py-1 text-left hover:bg-white/10">About This Mac</button>
                <button className="w-full px-4 py-1 text-left hover:bg-white/10">System Settings...</button>
                <div className="my-1 h-px bg-white/10"></div>
                <button className="w-full px-4 py-1 text-left hover:bg-white/10">App Store...</button>
                <div className="my-1 h-px bg-white/10"></div>
                <button className="w-full px-4 py-1 text-left hover:bg-white/10">Sleep</button>
                <button className="w-full px-4 py-1 text-left hover:bg-white/10">Restart...</button>
                <button className="w-full px-4 py-1 text-left hover:bg-white/10">Shut Down...</button>
                <div className="my-1 h-px bg-white/10"></div>
                <button className="w-full px-4 py-1 text-left hover:bg-white/10">Lock Screen</button>
                <button className="w-full px-4 py-1 text-left hover:bg-white/10">Log Out...</button>
              </div>
            </div>
          </div>
          <span className='font-semibold cursor-default'>Akhil Raghav</span>
          <span className='cursor-default hover:bg-white/10 px-2 rounded'>File</span>
          <span className='cursor-default hover:bg-white/10 px-2 rounded'>Edit</span>
          <span className='cursor-default hover:bg-white/10 px-2 rounded'>View</span>
          <span className='cursor-default hover:bg-white/10 px-2 rounded'>Go</span>
          <span className='cursor-default hover:bg-white/10 px-2 rounded'>Window</span>
          <span className='cursor-default hover:bg-white/10 px-2 rounded'>Help</span>
        </div>
        <div className='flex items-center space-x-2'>
          <VscVscode
            size={16}
            className='cursor-default hover:opacity-80 transition-opacity'
            onClick={handleVSCodeClick}
            title='Open in VSCode'
          />
          <div className="relative">
            <button
              onClick={() => setShowControlCenter(!showControlCenter)}
              className="hover:bg-white/10 p-1 rounded transition-colors"
            >
              <BsGearFill size={14} />
            </button>
            {showControlCenter && (
              <ControlCenter 
                isDark={isDark}
                toggleTheme={toggleTheme}
              />
            )}
          </div>
          <button
            onClick={() => setShowNotifications(!showNotifications)}
            className="hover:bg-white/10 p-1 rounded transition-colors"
          >
            <MdNotifications size={16} />
          </button>
          <span className='cursor-default hover:bg-white/10 px-2 rounded'>
            {formatMacDate(currentDateTime)}
          </span>
        </div>
      </div>
    </>
  );
}
