import { useState } from 'react';
import Draggable from 'react-draggable';
import NotesApp from './NotesApp';

interface NotesWindowProps {
  onClose: () => void;
}

export default function NotesWindow({ onClose }: NotesWindowProps) {
  const [isMaximized, setIsMaximized] = useState(false);

  return (
    <Draggable handle=".handle" disabled={isMaximized}>
      <div 
        className={`fixed ${
          isMaximized ? 'top-0 left-0 right-0 bottom-0 rounded-none' : 'top-10 left-10 w-[900px] h-[600px] rounded-lg'
        } bg-mac-light dark:bg-mac-dark shadow-2xl overflow-hidden z-40 transition-all duration-300`}
      >
        {/* Window Toolbar */}
        <div className="handle h-8 bg-gray-200 dark:bg-gray-800 flex items-center px-4 justify-between">
          <div className="flex items-center space-x-2">
            <button
              onClick={onClose}
              className="w-3 h-3 rounded-full bg-red-500 hover:bg-red-600"
            />
            <button
              className="w-3 h-3 rounded-full bg-yellow-500 hover:bg-yellow-600"
            />
            <button
              onClick={() => setIsMaximized(!isMaximized)}
              className="w-3 h-3 rounded-full bg-green-500 hover:bg-green-600"
            />
          </div>
          <div className="absolute left-1/2 transform -translate-x-1/2 text-sm text-gray-600 dark:text-gray-400">
            Notes
          </div>
        </div>

        {/* Notes App */}
        <div className="h-[calc(100%-2rem)]">
          <NotesApp />
        </div>
      </div>
    </Draggable>
  );
} 