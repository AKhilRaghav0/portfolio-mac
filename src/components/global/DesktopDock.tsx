import { useState } from 'react';
import { BsGithub, BsSpotify } from 'react-icons/bs';
import { IoIosMail } from 'react-icons/io';
import { VscVscode } from 'react-icons/vsc';
import { FaRegEdit } from 'react-icons/fa';
import BlogWindow from '../BlogWindow';

export default function DesktopDock() {
  const [hoveredIcon, setHoveredIcon] = useState<string | null>(null);
  const [isBlogOpen, setIsBlogOpen] = useState(false);

  const handleEmailClick = () => {
    window.location.href = 'mailto:work@akhilraghav.com';
  };

  const handleGithubClick = () => {
    window.open('https://github.com/AKhilRaghav0', '_blank');
  };

  const handleBlogClick = () => {
    setIsBlogOpen(true);
  };

  const handleCalendarClick = () => {
    window.open('https://calendly.com/akhilraghav/30min', '_blank');
  };

  const handleSpotifyClick = () => {
    window.open('https://open.spotify.com', '_blank');
  };

  const handleVSCodeClick = () => {
    window.location.href = 'vscode:/';
  };

  const Tooltip = ({ text }: { text: string }) => (
    <div className='absolute -top-14 left-1/2 -translate-x-1/2'>
      <div className='relative px-3 py-1 bg-[#1d1d1f]/80 backdrop-blur-sm text-white text-sm rounded-lg whitespace-nowrap border border-px border-gray-600'>
        {text}
        <div className='absolute left-1/2 -translate-x-1/2 -bottom-[7px] w-3 h-3 bg-[#1d1d1f]/80 backdrop-blur-sm rotate-45 border-b border-r border-gray-600' />
      </div>
    </div>
  );

  return (
    <>
      {isBlogOpen && <BlogWindow isVisible={isBlogOpen} onClose={() => setIsBlogOpen(false)} />}
      
      <div className='fixed bottom-0 left-1/2 -translate-x-1/2 hidden md:block z-50'>
        <div className='relative mb-2 p-3 bg-gradient-to-t from-gray-700 to-gray-800 backdrop-blur-2xl rounded-2xl'>
          <div className='flex items-end space-x-4'>
            {/* Blog */}
            <button
              onClick={handleBlogClick}
              onMouseEnter={() => setHoveredIcon('blog')}
              onMouseLeave={() => setHoveredIcon(null)}
              className='relative'
            >
              <div className='w-14 h-14 bg-gradient-to-t from-purple-600 to-purple-400 rounded-xl flex items-center justify-center shadow-lg'>
                <FaRegEdit size={35} className='text-white' />
              </div>
              {hoveredIcon === 'blog' && <Tooltip text='Blog Posts' />}
            </button>

            {/* Email */}
            <button
              onClick={handleEmailClick}
              onMouseEnter={() => setHoveredIcon('email')}
              onMouseLeave={() => setHoveredIcon(null)}
              className='relative'
            >
              <div className='w-14 h-14 bg-gradient-to-t from-blue-600 to-blue-400 rounded-xl flex items-center justify-center shadow-lg'>
                <IoIosMail size={45} className='text-white' />
              </div>
              {hoveredIcon === 'email' && <Tooltip text='Email Me' />}
            </button>

            {/* Github */}
            <button
              onClick={handleGithubClick}
              onMouseEnter={() => setHoveredIcon('github')}
              onMouseLeave={() => setHoveredIcon(null)}
              className='relative'
            >
              <div className='w-14 h-14 bg-gradient-to-t from-black to-black/60 rounded-xl flex items-center justify-center shadow-lg'>
                <BsGithub size={45} className='text-gray-100' />
              </div>
              {hoveredIcon === 'github' && <Tooltip text='My GitHub' />}
            </button>

            {/* Calendar */}
            <button
              onClick={handleCalendarClick}
              onMouseEnter={() => setHoveredIcon('calendar')}
              onMouseLeave={() => setHoveredIcon(null)}
              className='relative'
            >
              <div className='w-14 h-14 overflow-hidden shadow-lg'>
                <div className='absolute inset-0 bg-gradient-to-b from-white to-gray-200 rounded-xl'></div>

                <div className='absolute top-0 inset-x-0 h-5 bg-red-500 flex items-center justify-center rounded-t-xl'>
                  <span className='text-xs font-semibold text-white uppercase'>
                    {new Date().toLocaleString('en-US', { month: 'short' })}
                  </span>
                </div>

                <div className='absolute inset-0 flex items-end justify-center'>
                  <span className='text-3xl font-light text-black'>
                    {new Date().getDate()}
                  </span>
                </div>
              </div>
              {hoveredIcon === 'calendar' && <Tooltip text='Book a Call' />}
            </button>

            {/* Spotify */}
            <button
              onClick={handleSpotifyClick}
              onMouseEnter={() => setHoveredIcon('spotify')}
              onMouseLeave={() => setHoveredIcon(null)}
              className='relative'
            >
              <div className='w-14 h-14 bg-gradient-to-t from-black to-black/60 rounded-xl flex items-center justify-center shadow-lg'>
                <BsSpotify size={45} className='text-[#1ED760]' />
              </div>
              {hoveredIcon === 'spotify' && <Tooltip text='My Dev Playlist' />}
            </button>

            {/* Divider */}
            <div className='flex items-center'>
              <div className='w-px h-14 bg-white/20' />
            </div>

            {/* VSCode */}
            <button
              onClick={handleVSCodeClick}
              onMouseEnter={() => setHoveredIcon('vscode')}
              onMouseLeave={() => setHoveredIcon(null)}
              className='relative'
            >
              <div className='w-14 h-14 bg-white rounded-xl flex items-center justify-center shadow-lg'>
                <VscVscode size={45} className='text-blue-500' />
              </div>
              {hoveredIcon === 'vscode' && <Tooltip text='Launch VS Code' />}
            </button>
          </div>
        </div>
      </div>
    </>
  );
}
