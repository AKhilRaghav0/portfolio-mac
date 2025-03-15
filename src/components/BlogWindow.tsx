import React, { useState } from 'react';
import { format } from 'date-fns';
import { VscChromeClose, VscChromeMinimize, VscChromeMaximize } from 'react-icons/vsc';
import { BiSearch } from 'react-icons/bi';
import { FaTags } from 'react-icons/fa';

interface BlogPost {
  id: number;
  title: string;
  content: string;
  date: Date;
  tags: string[];
  readTime: string;
  views: number;
}

interface BlogWindowProps {
  isVisible: boolean;
  onClose: () => void;
}

const samplePosts: BlogPost[] = [
  {
    id: 1,
    title: 'Building a Modern Portfolio with Astro',
    content: '# Building a Modern Portfolio\n\nIn this post, I\'ll share my experience building a portfolio site using Astro, React, and TailwindCSS...',
    date: new Date(),
    tags: ['astro', 'react', 'portfolio'],
    readTime: '5 min',
    views: 123
  },
  {
    id: 2,
    title: 'Mastering Data Structures in Competitive Programming',
    content: '# Data Structures in CP\n\nLet\'s dive into advanced data structures commonly used in competitive programming...',
    date: new Date(),
    tags: ['cp', 'algorithms', 'coding'],
    readTime: '8 min',
    views: 256
  }
];

export default function BlogWindow({ isVisible, onClose }: BlogWindowProps) {
  const [posts] = useState<BlogPost[]>(samplePosts);
  const [selectedPost, setSelectedPost] = useState<BlogPost | null>(null);
  const [isEditing, setIsEditing] = useState(false);

  if (!isVisible) return null;

  return (
    <div className="fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-[#1e1e1e] w-[800px] h-[600px] rounded-lg overflow-hidden shadow-2xl">
      {/* Window Toolbar */}
      <div className="bg-[#2d2d2d] h-8 flex items-center px-3 select-none">
        <div className="flex items-center space-x-2">
          <button 
            onClick={onClose}
            className="w-3 h-3 rounded-full bg-red-500 hover:bg-red-600 transition-colors duration-150 flex items-center justify-center group"
          >
            <VscChromeClose className="hidden group-hover:block text-red-800" size={8} />
          </button>
          <button className="w-3 h-3 rounded-full bg-yellow-500 hover:bg-yellow-600 transition-colors duration-150 flex items-center justify-center group">
            <VscChromeMinimize className="hidden group-hover:block text-yellow-800" size={8} />
          </button>
          <button className="w-3 h-3 rounded-full bg-green-500 hover:bg-green-600 transition-colors duration-150 flex items-center justify-center group">
            <VscChromeMaximize className="hidden group-hover:block text-green-800" size={8} />
          </button>
        </div>
        
        <div className="flex-1 flex justify-center">
          <span className="text-gray-400 text-sm">Blog Posts</span>
        </div>
      </div>

      <div className="flex h-[calc(100%-2rem)]">
        {/* Sidebar */}
        <div className="w-72 border-r border-gray-700 overflow-y-auto">
          {/* Search Bar */}
          <div className="p-3 border-b border-gray-700">
            <div className="flex items-center bg-[#3d3d3d] rounded-md px-3 py-1.5">
              <BiSearch className="text-gray-400" size={14} />
              <input
                type="text"
                placeholder="Search posts..."
                className="bg-transparent border-none text-sm text-gray-200 placeholder-gray-500 focus:outline-none ml-2 w-full"
              />
            </div>
          </div>

          {/* Posts List */}
          <div className="divide-y divide-gray-700">
            {posts.map(post => (
              <button
                key={post.id}
                onClick={() => setSelectedPost(post)}
                className={`w-full text-left p-4 hover:bg-[#2d2d2d] transition-colors duration-150 ${
                  selectedPost?.id === post.id ? 'bg-[#2d2d2d]' : ''
                }`}
              >
                <h3 className="text-gray-200 font-medium text-sm mb-1">{post.title}</h3>
                <div className="flex items-center space-x-3 text-xs text-gray-400">
                  <span>{format(post.date, 'MMM dd, yyyy')}</span>
                  <span>·</span>
                  <span>{post.readTime}</span>
                  <span>·</span>
                  <span>{post.views} views</span>
                </div>
                <div className="flex items-center mt-2 space-x-2">
                  {post.tags.map(tag => (
                    <span
                      key={tag}
                      className="px-2 py-0.5 bg-[#3d3d3d] text-gray-300 rounded text-xs"
                    >
                      {tag}
                    </span>
                  ))}
                </div>
              </button>
            ))}
          </div>
        </div>

        {/* Main Content */}
        <div className="flex-1 overflow-y-auto bg-[#1e1e1e]">
          {selectedPost ? (
            <div className="p-6">
              <div className="flex items-center justify-between mb-6">
                <h2 className="text-xl text-gray-200 font-semibold">
                  {selectedPost.title}
                </h2>
                <button
                  onClick={() => setIsEditing(!isEditing)}
                  className="px-3 py-1 bg-blue-500 text-white rounded-md text-sm hover:bg-blue-600 transition-colors duration-150"
                >
                  {isEditing ? 'Preview' : 'Edit'}
                </button>
              </div>
              <div className="prose prose-invert max-w-none">
                {isEditing ? (
                  <textarea
                    value={selectedPost.content}
                    onChange={(e) => setSelectedPost({ ...selectedPost, content: e.target.value })}
                    className="w-full h-[400px] bg-[#2d2d2d] text-gray-200 p-4 rounded-md font-mono text-sm focus:outline-none"
                  />
                ) : (
                  <div className="markdown-preview whitespace-pre-wrap font-mono text-gray-200">
                    {selectedPost.content}
                  </div>
                )}
              </div>
            </div>
          ) : (
            <div className="h-full flex items-center justify-center text-gray-400">
              Select a post to view or edit
            </div>
          )}
        </div>
      </div>
    </div>
  );
} 