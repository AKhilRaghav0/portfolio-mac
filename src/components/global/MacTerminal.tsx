import { useState, useEffect, useRef } from 'react';
import { FaRegFolderClosed } from 'react-icons/fa6';
import { BiSearch } from 'react-icons/bi';
import { IoIosArrowBack, IoIosArrowForward } from 'react-icons/io';
import { VscChromeMinimize, VscChromeMaximize, VscChromeClose } from 'react-icons/vsc';
import '@fontsource/jetbrains-mono';

type Message = {
  role: 'system' | 'user' | 'assistant';
  content: string;
};

type ChatHistory = {
  messages: Message[];
  input: string;
};

const PLACEHOLDER_MESSAGES = [
  'Type your question...',
  'How old are you?',
  'What are your skills?',
  'Where are you located?',
  'What projects have you worked on?',
  'What is your email?',
  'What is your GitHub?',
];

export default function MacTerminal() {
  const [chatHistory, setChatHistory] = useState<ChatHistory>({
    messages: [],
    input: '',
  });
  const [isTyping, setIsTyping] = useState(false);
  const [placeholder, setPlaceholder] = useState('');
  const [currentPlaceholderIndex, setCurrentPlaceholderIndex] = useState(0);
  const [isDeleting, setIsDeleting] = useState(false);
  const messagesEndRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    let timeout: NodeJS.Timeout;
    const currentMessage = PLACEHOLDER_MESSAGES[currentPlaceholderIndex];

    const animatePlaceholder = () => {
      if (isDeleting) {
        if (placeholder.length === 0) {
          setIsDeleting(false);
          setCurrentPlaceholderIndex(
            (prev) => (prev + 1) % PLACEHOLDER_MESSAGES.length
          );
          timeout = setTimeout(animatePlaceholder, 400);
        } else {
          setPlaceholder((prev) => prev.slice(0, -1));
          timeout = setTimeout(animatePlaceholder, 80);
        }
      } else {
        if (placeholder.length === currentMessage.length) {
          timeout = setTimeout(() => setIsDeleting(true), 1500);
        } else {
          setPlaceholder(currentMessage.slice(0, placeholder.length + 1));
          timeout = setTimeout(animatePlaceholder, 120);
        }
      }
    };

    timeout = setTimeout(animatePlaceholder, 100);

    return () => clearTimeout(timeout);
  }, [placeholder, isDeleting, currentPlaceholderIndex]);

  const welcomeMessage = `Welcome to My Portfolio

Name: Akhil Raghav
Role: Full Stack Developer & CP Enthusiast
Location: India

Contact: work@akhilraghav.com
GitHub: github.com/AKhilRaghav0

Ask me anything!
`;

  const currentDate = new Date();
  const formattedDate = currentDate.toLocaleDateString('en-US', {
    month: 'long',
    day: 'numeric',
    year: 'numeric',
  });

  const systemPrompt = `IMPORTANT: You ARE Akhil Raghav himself. You must always speak in first-person ("I", "my", "me"). Never refer to "Akhil" in third-person.

CURRENT DATE: ${formattedDate} - Always use this exact date when discussing the current date/year.

Example responses:
Q: "Where do you live?"
A: "I live in India"

Q: "What's your age"
A: "I'm 23 years old"

Q: "What's your background?"
A: "I'm a Full Stack Developer with experience in iOS, Backend Development, and Competitive Programming"

Q: "What's your email?"
A: "My email is work@akhilraghav.com"

Q: "What's your GitHub?"
A: "My GitHub is github.com/AKhilRaghav0"

Core details about me:
- I'm a Full Stack Developer
- My email is work@akhilraghav.com
- I specialize in Backend Development and CP
- I have past experience in iOS Development

My technical expertise:
- Full Stack Development
- iOS Development (Past Experience)
- Competitive Programming
- Backend Development & System Design

Response rules:
1. ALWAYS use first-person (I, me, my)
2. Never say "Akhil" or refer to myself in third-person
3. Keep responses concise and professional
4. Use markdown formatting when appropriate
5. Maintain a friendly, conversational tone

If a question is unrelated to my work or portfolio, say: "That's outside my area of expertise. Feel free to email me at work@akhilraghav.com and we can discuss further!"`;

  useEffect(() => {
    setChatHistory((prev) => ({
      ...prev,
      messages: [
        ...prev.messages,
        { role: 'assistant', content: welcomeMessage },
      ],
    }));
  }, []);

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [chatHistory.messages]);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setChatHistory((prev) => ({ ...prev, input: e.target.value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const userInput = chatHistory.input.trim();

    if (!userInput) return;

    setChatHistory((prev) => ({
      messages: [...prev.messages, { role: 'user', content: userInput }],
      input: '',
    }));

    setIsTyping(true);

    try {
      const response = await fetch('/api/chat', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          messages: [
            { role: 'system', content: systemPrompt },
            ...chatHistory.messages,
            { role: 'user', content: userInput },
          ],
        }),
      });

      if (!response.ok) throw new Error('Failed to get response');

      const data = await response.json();

      setChatHistory((prev) => ({
        ...prev,
        messages: [
          ...prev.messages,
          { role: 'assistant', content: data.message },
        ],
      }));
    } catch (error) {
      setChatHistory((prev) => ({
        ...prev,
        messages: [
          ...prev.messages,
          {
            role: 'assistant',
            content:
              "I'm having trouble processing that. Please email me at work@akhilraghav.com",
          },
        ],
      }));
    } finally {
      setIsTyping(false);
    }
  };

  return (
    <div className='w-[95vw] md:w-[600px] h-[400px] bg-black/90 rounded-lg overflow-hidden shadow-lg mx-4 sm:mx-0'>
      {/* Main Toolbar */}
      <div className='bg-gray-800 h-6 flex items-center px-2 select-none'>
        {/* Window Controls */}
        <div className='flex items-center space-x-1.5'>
          <button className='w-3 h-3 rounded-full bg-red-500 hover:bg-red-600 transition-colors duration-150 flex items-center justify-center group'>
            <VscChromeClose className='hidden group-hover:block text-red-800 transition-opacity duration-150' size={8} />
          </button>
          <button className='w-3 h-3 rounded-full bg-yellow-500 hover:bg-yellow-600 transition-colors duration-150 flex items-center justify-center group'>
            <VscChromeMinimize className='hidden group-hover:block text-yellow-800 transition-opacity duration-150' size={8} />
          </button>
          <button className='w-3 h-3 rounded-full bg-green-500 hover:bg-green-600 transition-colors duration-150 flex items-center justify-center group'>
            <VscChromeMaximize className='hidden group-hover:block text-green-800 transition-opacity duration-150' size={8} />
          </button>
        </div>

        {/* Navigation */}
        <div className='flex items-center space-x-2 ml-4'>
          <button className='text-gray-400 hover:text-gray-200 transition-colors duration-150 p-0.5 rounded hover:bg-gray-700/30'>
            <IoIosArrowBack size={14} />
          </button>
          <button className='text-gray-400 hover:text-gray-200 transition-colors duration-150 p-0.5 rounded hover:bg-gray-700/30'>
            <IoIosArrowForward size={14} />
          </button>
        </div>

        {/* Path Display */}
        <div className='flex-1 flex items-center justify-center gap-2 px-4'>
          <FaRegFolderClosed size={14} className='text-gray-300' />
          <div className='flex items-center bg-gray-700/50 px-2 py-0.5 rounded text-xs hover:bg-gray-700/70 transition-colors duration-150 cursor-default'>
            <span className='text-gray-300'>~</span>
            <span className='text-gray-400 mx-1'>/</span>
            <span className='text-gray-300'>portfolio</span>
          </div>
        </div>

        {/* Right Controls */}
        <div className='flex items-center space-x-2'>
          <button className='text-gray-400 hover:text-gray-200 transition-colors duration-150 p-0.5 rounded hover:bg-gray-700/30'>
            <BiSearch size={14} />
          </button>
          <select className='bg-transparent text-gray-400 hover:text-gray-200 text-xs outline-none cursor-pointer transition-colors duration-150 hover:bg-gray-700/30 rounded px-1'>
            <option value="100" className='bg-gray-800 text-gray-200'>100%</option>
          </select>
        </div>
      </div>

      {/* Terminal Content */}
      <div className='p-4 font-mono text-sm text-white/90 h-[calc(100%-1.5rem)] overflow-y-auto'>
        <div className='space-y-2'>
          {chatHistory.messages.map((message, index) => (
            <div key={index} className='whitespace-pre-wrap'>
              {message.role === 'user' ? (
                <div className='flex items-start'>
                  <span className='text-green-400 mr-2'>❯</span>
                  <span>{message.content}</span>
                </div>
              ) : (
                <div>{message.content}</div>
              )}
            </div>
          ))}
          <div ref={messagesEndRef} />
        </div>

        {/* Input Area */}
        <form onSubmit={handleSubmit} className='mt-4 flex items-center'>
          <span className='text-green-400 mr-2'>❯</span>
          <input
            type='text'
            value={chatHistory.input}
            onChange={handleInputChange}
            placeholder={placeholder}
            className='flex-1 bg-transparent outline-none caret-white/60 text-white/90 placeholder-white/30'
            autoFocus
          />
        </form>

        {isTyping && (
          <div className='mt-2 text-white/60'>
            <span className='animate-pulse'>▋</span>
          </div>
        )}
      </div>
    </div>
  );
}
