import { BsGithub, BsSpotify } from 'react-icons/bs';
import { IoIosMail } from 'react-icons/io';
import { FaPhoneAlt } from 'react-icons/fa';

export default function MobileDock() {
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
          <a href="https://open.spotify.com/user/31gms3hlihdvvu6kxh7o6gg42wuy" target="_blank" className="p-2">
            <BsSpotify size={55} className="text-white hover:scale-110 transition-transform" />
          </a>
        </div>
      </div>
    </div>
  );
}
