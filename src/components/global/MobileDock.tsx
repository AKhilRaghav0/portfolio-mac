import { BsGithub } from 'react-icons/bs';
import { IoIosMail } from 'react-icons/io';
import { FaPhoneAlt } from 'react-icons/fa';
import { FiEdit } from 'react-icons/fi';

interface MobileDockProps {
  onNotesClick: () => void;
}

export default function MobileDock({ onNotesClick }: MobileDockProps) {
  return (
    <div className="fixed bottom-0 left-0 right-0 md:hidden">
      <div className="mx-4 mb-4 p-2 rounded-2xl bg-black/40 backdrop-blur-md border border-white/10">
        <div className="flex justify-around items-center">
          <a href="tel:+919999999999" className="p-2">
            <FaPhoneAlt size={60} className="text-white hover:scale-110 transition-transform" />
          </a>
          <a href="mailto:work@akhilraghav.com" className="p-2">
            <IoIosMail size={60} className="text-white hover:scale-110 transition-transform" />
          </a>
          <a href="https://github.com/AKhilRaghav0" target="_blank" className="p-2">
            <BsGithub size={55} className="text-white hover:scale-110 transition-transform" />
          </a>
          <button onClick={onNotesClick} className="p-2">
            <FiEdit size={55} className="text-white hover:scale-110 transition-transform" />
          </button>
        </div>
      </div>
    </div>
  );
}
