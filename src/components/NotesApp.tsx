import { useState, useEffect } from 'react';
import { IoIosSearch, IoIosMore } from 'react-icons/io';
import { FaPlus, FaChevronLeft, FaFolder } from 'react-icons/fa';
import { format } from 'date-fns';

interface Note {
  id: string;
  title: string;
  content: string;
  lastModified: Date;
  folder: string;
}

export default function NotesApp() {
  const [notes, setNotes] = useState<Note[]>(() => {
    const savedNotes = localStorage.getItem('notes');
    return savedNotes ? JSON.parse(savedNotes) : [];
  });
  const [selectedNote, setSelectedNote] = useState<Note | null>(null);
  const [searchQuery, setSearchQuery] = useState('');
  const [isMobile, setIsMobile] = useState(false);
  const [showNotesList, setShowNotesList] = useState(true);

  useEffect(() => {
    const checkMobile = () => {
      setIsMobile(window.innerWidth < 768);
    };
    
    checkMobile();
    window.addEventListener('resize', checkMobile);
    return () => window.removeEventListener('resize', checkMobile);
  }, []);

  useEffect(() => {
    localStorage.setItem('notes', JSON.stringify(notes));
  }, [notes]);

  const createNewNote = () => {
    const newNote: Note = {
      id: Date.now().toString(),
      title: 'New Note',
      content: '',
      lastModified: new Date(),
      folder: 'Notes',
    };
    setNotes([newNote, ...notes]);
    setSelectedNote(newNote);
    if (isMobile) setShowNotesList(false);
  };

  const updateNote = (noteId: string, updates: Partial<Note>) => {
    setNotes(notes.map(note => 
      note.id === noteId 
        ? { ...note, ...updates, lastModified: new Date() }
        : note
    ));
  };

  const deleteNote = (noteId: string) => {
    setNotes(notes.filter(note => note.id !== noteId));
    setSelectedNote(null);
    if (isMobile) setShowNotesList(true);
  };

  const filteredNotes = notes.filter(note =>
    note.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
    note.content.toLowerCase().includes(searchQuery.toLowerCase())
  );

  const formatDate = (date: Date) => {
    const now = new Date();
    const noteDate = new Date(date);
    
    if (noteDate.toDateString() === now.toDateString()) {
      return format(noteDate, 'h:mm a');
    }
    return format(noteDate, 'MMM d, yyyy');
  };

  return (
    <div className={`w-full h-full bg-mac-light dark:bg-mac-dark text-black dark:text-white flex ${isMobile ? 'flex-col' : ''}`}>
      {/* Sidebar/List View */}
      {(showNotesList || !isMobile) && (
        <div className={`${isMobile ? 'w-full' : 'w-80'} border-r border-gray-200 dark:border-gray-700`}>
          {/* Header */}
          <div className="p-4 border-b border-gray-200 dark:border-gray-700">
            <div className="flex items-center justify-between mb-4">
              <h1 className="text-xl font-semibold">Notes</h1>
              <button
                onClick={createNewNote}
                className="p-2 hover:bg-gray-200 dark:hover:bg-gray-700 rounded-full"
              >
                <FaPlus />
              </button>
            </div>
            <div className="relative">
              <IoIosSearch className="absolute left-3 top-2.5 text-gray-400" size={20} />
              <input
                type="text"
                placeholder="Search"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full pl-10 pr-4 py-2 bg-gray-100 dark:bg-gray-800 rounded-lg focus:outline-none"
              />
            </div>
          </div>

          {/* Notes List */}
          <div className="overflow-y-auto h-[calc(100vh-130px)]">
            {filteredNotes.map(note => (
              <div
                key={note.id}
                onClick={() => {
                  setSelectedNote(note);
                  if (isMobile) setShowNotesList(false);
                }}
                className={`p-4 cursor-pointer border-b border-gray-200 dark:border-gray-700 ${
                  selectedNote?.id === note.id ? 'bg-gray-100 dark:bg-gray-800' : ''
                } hover:bg-gray-100 dark:hover:bg-gray-800`}
              >
                <h2 className="font-semibold mb-1">{note.title}</h2>
                <div className="flex items-center text-sm text-gray-500 dark:text-gray-400">
                  <span>{formatDate(note.lastModified)}</span>
                  <span className="mx-2">•</span>
                  <span className="truncate">{note.content.slice(0, 50)}</span>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Note Editor */}
      {selectedNote && (!showNotesList || !isMobile) && (
        <div className={`${isMobile ? 'w-full' : 'flex-1'} flex flex-col h-full`}>
          {/* Editor Header */}
          <div className="p-4 border-b border-gray-200 dark:border-gray-700 flex items-center justify-between">
            {isMobile && (
              <button
                onClick={() => setShowNotesList(true)}
                className="p-2 hover:bg-gray-200 dark:hover:bg-gray-700 rounded-full"
              >
                <FaChevronLeft />
              </button>
            )}
            <div className="flex items-center space-x-4">
              <FaFolder className="text-gray-400" />
              <span>{selectedNote.folder}</span>
            </div>
            <button
              onClick={() => deleteNote(selectedNote.id)}
              className="p-2 hover:bg-gray-200 dark:hover:bg-gray-700 rounded-full"
            >
              <IoIosMore />
            </button>
          </div>

          {/* Editor Content */}
          <div className="flex-1 p-4">
            <input
              type="text"
              value={selectedNote.title}
              onChange={(e) => updateNote(selectedNote.id, { title: e.target.value })}
              className="w-full text-2xl font-semibold mb-4 bg-transparent focus:outline-none"
              placeholder="Title"
            />
            <textarea
              value={selectedNote.content}
              onChange={(e) => updateNote(selectedNote.id, { content: e.target.value })}
              className="w-full h-[calc(100%-80px)] bg-transparent focus:outline-none resize-none"
              placeholder="Start writing..."
            />
          </div>
        </div>
      )}

      {/* Empty State */}
      {!selectedNote && !isMobile && (
        <div className="flex-1 flex items-center justify-center text-gray-400">
          <p>Select a note or create a new one</p>
        </div>
      )}
    </div>
  );
} 