import React, { useEffect, useState } from "react";
import consumer from "../channels/consumer";

const Notification = () => {
  const [notifications, setNotifications] = useState([]);

  const numberOfNotifications = notifications.length;

  useEffect(() => {
    const wineChannel = consumer.subscriptions.create("WineChannel", {
      received(data) {
        setNotifications((prevNotifications) => [
          ...prevNotifications,
          data.notification,
        ]);
      },
    });

    return () => {
      wineChannel.unsubscribe();
    };
  }, []);

  return (
    <React.Fragment>
      <button
        type="button"
        className="relative rounded-full bg-gray-800 p-1 text-gray-400 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
      >
        <span className="absolute -inset-1.5"></span>
        <span className="sr-only">View notifications</span>
        <svg
          className="h-6 w-6"
          fill="none"
          viewBox="0 0 24 24"
          strokeWidth="1.5"
          stroke="currentColor"
          aria-hidden="true"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            d="M14.857 17.082a23.848 23.848 0 005.454-1.31A8.967 8.967 0 0118 9.75v-.7V9A6 6 0 006 9v.75a8.967 8.967 0 01-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 01-5.714 0m5.714 0a3 3 0 11-5.714 0"
          />
        </svg>
        {numberOfNotifications !== 0 && (
          <span className="absolute top-0 right-0 transform translate-x-1/4 -translate-y-1/4 bg-red-500 text-white rounded-full px-2 py-1 text-xs">
            {numberOfNotifications}
          </span>
        )}
      </button>
      {numberOfNotifications !== 0 && (
        <div
          className="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
          role="menu"
          aria-orientation="vertical"
          aria-labelledby="user-menu-button"
          tabIndex="-1"
        >
          {notifications.map((notification) => (
            <a
              href={notification.url}
              className="block px-4 py-2 text-sm text-gray-700"
              role="menuitem"
              tabIndex="-1"
              id="user-menu-item-0"
            >
              {notification.message}
            </a>
          ))}
        </div>
      )}
    </React.Fragment>
  );
};

export default Notification;
